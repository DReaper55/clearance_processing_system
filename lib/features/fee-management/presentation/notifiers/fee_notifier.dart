import 'package:clearance_processing_system/core/helpers/extensions.dart';
import 'package:clearance_processing_system/core/helpers/helpers_functions.dart';
import 'package:clearance_processing_system/core/utils/strings.dart';
import 'package:clearance_processing_system/features/fee-management/domain/enitites/requirement_entity.dart';
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
import '../widgets/add_requirement_dialog.dart';
import '../widgets/paystack_banks_bottomsheet.dart';

final createNewFeeNotifierProvider =
ChangeNotifierProvider((ref) => FeeNotifier(ref));

enum Departments { all, computer, statistics, chemistry }

class FeeNotifier extends ChangeNotifier {
  final Ref ref;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();

  final mSelectedBank = ValueNotifier<PayStackBankEntity?>(null);

  final isCreating = ValueNotifier(false);
  final isLoadingAccNum = ValueNotifier(false);

  final requirements = ValueNotifier<List<RequirementEntity>>([]);

  final selectedDepartments = ValueNotifier<List<Map<Departments, String>?>>([]);
  final listOfDepartments = [
    {Departments.all: 'All'},
    {Departments.computer: 'Computer science'},
    {Departments.statistics: 'Maths & Stats'},
    {Departments.chemistry: 'Chemistry'},
  ];

  FeeNotifier(this.ref);

  void setData() {
    selectedDepartments.value.add(listOfDepartments.first);

    notifyListeners();
  }

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

    final feeID = nanoid(6);

    final isSuccessful = await _saveFeeData(feeID);

    isCreating.value = false;
    notifyListeners();

    if(!isSuccessful){
      showError(text: AppStrings.errorText, context: context);

      return;
    }

    if(isSuccessful && requirements.value.isNotEmpty){
      final mRequirements = requirements.value;

      for(var mRequirement in mRequirements){
        final data = mRequirement.copyWith(
          postedBy: FirebaseAuth.instance.currentUser!.uid,
          feeID: feeID,
        );

        try {
          _saveRequirementData(data);
        } on Exception {
          debugPrintStack();
        }
      }
    }

    showSuccess(text: 'Successfully created fee', context: context);
  }

  Future<bool> _saveFeeData(String feeID) async {
    String userUid = FirebaseAuth.instance.currentUser!.uid;

    final fee = FeeEntity(
      postedBy: userUid,
      dateTime: DateTime.now().toString(),
      departmentsToPay: selectedDepartments.value.map((e) => e!.keys.first.name).join('-'),
      accountName: accountNameController.text,
      accountNumber: accountNumberController.text,
      amount: amountController.text,
      bankCode: mSelectedBank.value!.code,
      bankName: mSelectedBank.value!.name,
      feeID: feeID,
      title: titleController.text,
    );

    try {
      return await ref.read(addDataToFireStore(FireStoreParams(
        collectionName: FireStoreCollectionStrings.fees,
        uid: userUid.docFormat(id: fee.feeID!.toString()),
        data: fee.toMap(),
      )).future);
    } catch (e, stack) {
      debugPrintStack(stackTrace: stack);
      return false;
    }
  }

  Future<bool> _saveRequirementData(RequirementEntity data) async {
    String userUid = FirebaseAuth.instance.currentUser!.uid;

    try {
      return await ref.read(addDataToFireStore(FireStoreParams(
        collectionName: FireStoreCollectionStrings.requirements,
        uid: '$userUid-${data.feeID}-${data.requirementID}',
        data: data.toMap(),
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

  void onDropdownChanged(Map<Departments, String>? value) {
    if(value == null) return;

    final key = value.keys.first;

    if(key == Departments.all){
      selectedDepartments.value.clear();
      selectedDepartments.value.add(value);

      notifyListeners();

      return;
    }

    selectedDepartments.value.removeWhere((element) => element!.keys.first == Departments.all);

    final foundDep = selectedDepartments.value.firstWhere((element) => element!.keys.first == key, orElse: () => {});

    if(foundDep == null || foundDep.isEmpty){
      selectedDepartments.value.add(value);
    }

    notifyListeners();
  }

  void removeItem(Map<Departments, String> department) {
    selectedDepartments.value.removeWhere((element) => element!.keys.first == department.keys.first);

    notifyListeners();
  }

  void addRequirementDialog(BuildContext context) async {
    final requirement = await showDialog(
    context: context,
    builder: (ctx) => const AddRequirementDialog());

    if(requirement is RequirementEntity){
      requirements.value.add(requirement);

      notifyListeners();
    }
  }
}