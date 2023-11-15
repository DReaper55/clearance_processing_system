import 'package:clearance_processing_system/core/helpers/helpers_functions.dart';
import 'package:clearance_processing_system/core/utils/strings.dart';
import 'package:clearance_processing_system/features/register/domain/use-cases/vendor_firestore_usecases.dart';
import 'package:clearance_processing_system/features/register/presentation/providers/save_data_to_firebase_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nanoid/nanoid.dart';

import '../../domain/enitites/fee_entity.dart';
import '../../domain/enitites/paystack_bank.dart';
import '../../domain/use-cases/paystack_bank_usecases.dart';
import '../providers/paystack_bank_providers.dart';
import '../widgets/paystack_banks_bottomsheet.dart';

final createNewFeeNotifierProvider =
ChangeNotifierProvider((ref) => FeeNotifier(ref));

class FeeNotifier extends ChangeNotifier {
  final Ref ref;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();

  final mSelectedBank = ValueNotifier<PayStackBankEntity?>(null);

  final isCreating = ValueNotifier(false);
  final isLoadingAccNum = ValueNotifier(false);

  FeeNotifier(this.ref);

  void onData(data) {
    if(!isLoadingAccNum.value) return;

    if(data.accountNumber != null) {
      accountNumberController.text = data.accountNumber!;
    }

    if(data.settlementBank != null) {
      bankNameController.text = data.settlementBank!;
    }

    if(data.vendorFullName != null) {
      accountNameController.text = data.vendorFullName!;
    }

    isLoadingAccNum.value = false;

    notifyListeners();
  }

  void onAccNumberChanged(String value) {
    bankNameController.clear();
    accountNameController.clear();

    notifyListeners();
  }

  void onBankLoadTap(context) {
    if (accountNumberController.text.isEmpty) return;

    _getBanksAndVerifyAccNumber(context);
  }

  void createNewFee(context) async {
    if(mSelectedBank.value == null){
      showError(text: 'Please choose a bank', context: context);

      return;
    }

    isCreating.value = true;
    notifyListeners();

    final isSuccessful = await _saveFeeData();

    isCreating.value = false;
    notifyListeners();

    if(!isSuccessful){
      showError(text: AppStrings.errorText, context: context);

      return;
    }

    showSuccess(text: 'Successfully created fee', context: context);
  }

  Future<bool> _saveFeeData() async {
    String userUid = FirebaseAuth.instance.currentUser!.uid;

    final fee = FeeEntity(
      postedBy: userUid,
      dateTime: DateTime.now().toString(),
      accountName: accountNameController.text,
      accountNumber: accountNumberController.text,
      bankCode: mSelectedBank.value!.code,
      bankName: mSelectedBank.value!.name,
      feeID: nanoid(6),
      title: titleController.text,
    );

    try {
      return await ref.read(addDataToFireStore(FireStoreParams(
        collectionName: FireStoreCollectionStrings.fees,
        uid: userUid,
        data: fee.toMap(),
      )).future);
    } catch (e, stack) {
      debugPrintStack(stackTrace: stack);
      return false;
    }
  }

  _getBanksAndVerifyAccNumber(context) {
    isLoadingAccNum.value = true;
    notifyListeners();

    ref.watch(getBanksProvider.future).then((payStackBanks) async {
      // Display bottom sheet of a list of banks for selection
      final selectedBank = await showModalBottomSheet(
        elevation: 2.0,
        isScrollControlled: true,
        context: context,
        constraints: BoxConstraints(
            minHeight: (MediaQuery.of(context).size.height) * .9,
            maxHeight: (MediaQuery.of(context).size.height) * .9),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
        builder: (builder) =>
            PayStackBanksBottomSheet(payStackBanks: payStackBanks),
      );

      if (payStackBanks.isEmpty) return;

      if (selectedBank == null) return;

      mSelectedBank.value = selectedBank as PayStackBankEntity;
      isLoadingAccNum.value = false;
      bankNameController.text = selectedBank.name!;

      notifyListeners();

      final accountName = await ref.read(verifyAccountNumber(
          PayStackBankParams(accountNumberController.text, selectedBank.code!))
          .future);
      if (accountName != null) {
        accountNameController.text = accountName;

        notifyListeners();
      }
    });
  }
}