import 'dart:isolate';
import 'dart:ui';

import 'package:clearance_processing_system/core/services/navigation_services.dart';
import 'package:clearance_processing_system/features/wallet/domain/use-cases/transaction_usecases.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/enitites/transaction.dart';
import '../providers/transaction_providers.dart';
import '../widgets/payment_page.dart';

final paymentNotifierProvider =
    ChangeNotifierProvider((ref) => PaymentNotifier(ref));

enum PaymentStatus { success, abandoned, ongoing }

class PaymentNotifier extends ChangeNotifier {
  final Ref ref;

  PaymentNotifier(this.ref);

  final customerCode = ValueNotifier<String>('');

  Future<TransactionEntity?> pay(String amount) async {
    final payload = await _payWithUrl(amount);

    return await _verifyAndSaveAuthCode(payload);
  }

  Future<TransactionEntity?> _verifyAndSaveAuthCode(
      TransactionEntity? payload) async {
    if (payload == null) return null;
    if (payload.reference == null) return null;

    String reference = payload.reference!;

    final result = await _verifyTransaction(reference);

    ReceivePort receivePort = ReceivePort();

    // Spawn a new isolate and pass in the receivePort
    Isolate isolate = await Isolate.spawn(_mVerifyTransaction, [
      reference,
      receivePort.sendPort,
      ref.read(verifyTransactionProvider)
    ]);

    // Register the receivePort with a name so it can be used by other isolates
    IsolateNameServer.registerPortWithName(
        receivePort.sendPort, 'PAYMENT');

    receivePort.listen((message) {

      if(message != null){
        // Unregister the receivePort and terminate the isolate
        IsolateNameServer.removePortNameMapping(
            'PAYMENT');
        receivePort.close();
        isolate.kill();
      }
    });

    if (result == null) return null;

    return result;
  }

  Future<TransactionEntity?> _payWithUrl(String amount) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return null;

    final result =
        await ref.read(initializeTransactionProvider).call(TransactionParams(
              amount: amount,
              email: user.email,
            ));

    final payload = result.fold((l) => null, (r) => r);

    if (payload == null) return null;
    if (payload.url == null) return null;

    await ref.read(navigationService).navigateTo(
        MaterialPageRoute(builder: (ctx) => PaymentPage(url: payload.url!)));

    return payload;
  }

  Future<TransactionEntity?> _verifyTransaction(String reference) async {
    final result = await ref
        .read(verifyTransactionProvider)
        .call(TransactionParams(reference: reference));

    return result.fold((failure) => null, (payload) => payload);
  }
}

void _mVerifyTransaction(List args) async {
  String reference = args[0];
  SendPort sendPort = args[1];
  VerifyTransaction ref = args[2];

  final result = await ref.call(TransactionParams(reference: reference));

  final mRes = result.fold((failure) => null, (payload) => payload);

  if(mRes == null){
    sendPort.send(PaymentStatus.abandoned);
    return;
  }

  if(mRes.status == PaymentStatus.ongoing.name){
    Future.delayed(const Duration(seconds: 1), () => _mVerifyTransaction(args));
  } else {
    sendPort.send(mRes);
    return;
  }
}

