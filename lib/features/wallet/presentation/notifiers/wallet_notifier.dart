import 'package:clearance_processing_system/core/helpers/helpers_functions.dart';
import 'package:clearance_processing_system/core/utils/strings.dart';
import 'package:clearance_processing_system/features/wallet/domain/enitites/payment.dart';
import 'package:clearance_processing_system/features/wallet/presentation/notifiers/payment_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nanoid/nanoid.dart';

import '../../../register/domain/use-cases/vendor_firestore_usecases.dart';
import '../../../register/presentation/providers/save_data_to_firebase_providers.dart';
import '../widgets/choose_amount_dialog.dart';

final walletNotifierProvider =
    ChangeNotifierProvider((ref) => WalletNotifier(ref));

class WalletNotifier extends ChangeNotifier {
  final Ref ref;

  final isMakingPayment = ValueNotifier(false);

  WalletNotifier(this.ref);

  void fundWallet(context) async {
    final amount = await _displayAmountDialog(context);

    if(amount == null) return;

    isMakingPayment.value = true;
    notifyListeners();

    final result = await ref.read(paymentNotifierProvider).pay(amount);

    if(result != null && result.status == PaymentStatus.success.name){
      final updateRes = await _savePaymentInfo(paymentRefNumber: result.reference, amount: amount);

      isMakingPayment.value = false;
      notifyListeners();

      if(!updateRes){
        showError(text: AppStrings.errorText, context: context);
        return;
      }

      showSuccess(text: 'Funded wallet', context: context, duration: 5);
      return;
    }

    isMakingPayment.value = false;
    notifyListeners();
  }

  Future<String?> _displayAmountDialog(context) async {
    final amount = await showDialog(
        context: context,
        builder: (ctx) => const ChooseAmountDialog());

    if(amount is String){
      return amount;
    }

    return null;
  }

  Future<bool> _savePaymentInfo({String? paymentRefNumber, required String amount}) async {
    String userUid = FirebaseAuth.instance.currentUser!.uid;

    final payment = PaymentEntity(
      description: 'Fund wallet',
      dateTime: DateTime.now().toString(),
      amount: amount,
      referenceCode: paymentRefNumber,
      userID: userUid,
    );

    try {
      return await ref.read(addDataToFireStore(FireStoreParams(
        collectionName: FireStoreCollectionStrings.transactions,
        uid: '$userUid-${payment.referenceCode}',
        data: payment.toMap(),
      )).future);
    } catch (e, stack) {
      debugPrintStack(stackTrace: stack);
      return false;
    }
  }
}