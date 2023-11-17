import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:clearance_processing_system/core/services/navigation_services.dart';
import 'package:clearance_processing_system/features/wallet/domain/use-cases/transaction_usecases.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

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

    final Completer<void> timerCompleter = Completer<void>();

    Timer.periodic(const Duration(seconds: 30), (timer) async {
      final result = await _verifyAndSaveAuthCode(payload);

      if(result != null && result.status == PaymentStatus.success.name){
        timer.cancel();
        timerCompleter.complete();
      }
    });

    await Future.any([timerCompleter.future]);

    return await _verifyAndSaveAuthCode(payload);
  }

  Future<TransactionEntity?> _verifyAndSaveAuthCode(
      TransactionEntity? payload) async {
    if (payload == null) return null;
    if (payload.reference == null) return null;

    String reference = payload.reference!;

    final result = await _verifyTransaction(reference);

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

    // await ref.read(navigationService).navigateTo(
    //     MaterialPageRoute(builder: (ctx) => PaymentPage(url: payload.url!)));

    if (!await launchUrlString(payload.url!)) {
      throw Exception('Could not launch ${payload.url}');
    }

    return payload;
  }

  Future<TransactionEntity?> _verifyTransaction(String reference) async {
    final result = await ref
        .read(verifyTransactionProvider)
        .call(TransactionParams(reference: reference));

    return result.fold((failure) => null, (payload) => payload);
  }
}
