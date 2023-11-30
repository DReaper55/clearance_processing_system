import 'package:clearance_processing_system/core/helpers/helpers_functions.dart';
import 'package:clearance_processing_system/core/services/new_navigation_services.dart';
import 'package:clearance_processing_system/core/utils/routes.dart';
import 'package:clearance_processing_system/core/utils/strings.dart';
import 'package:clearance_processing_system/features/login/presentation/notifiers/login_notifier.dart';
import 'package:clearance_processing_system/features/register/domain/use-cases/vendor_firestore_usecases.dart';
import 'package:clearance_processing_system/features/register/presentation/providers/save_data_to_firebase_providers.dart';
import 'package:clearance_processing_system/features/student-management/presentation/providers/student_data_provider.dart';
import 'package:clearance_processing_system/features/wallet/domain/enitites/payment.dart';
import 'package:clearance_processing_system/features/wallet/presentation/notifiers/payment_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nanoid/nanoid.dart';

import '../../../fee-management/domain/enitites/fee_entity.dart';
import '../../../fee-management/domain/enitites/requirement_entity.dart';
import '../../../fee-management/presentation/providers/fee_data_provider.dart';
import '../../../student-management/domain/entities/student.dart';
import '../../../wallet/presentation/providers/transaction_data_provider.dart';
import '../../domain/entities/fee_category.dart';
import '../providers/requirement_data_provider.dart';

final clearanceNotifierProvider =
    ChangeNotifierProvider((ref) => ClearanceNotifier(ref));

final selectedFeeCategory =
StateProvider<FeeCategory?>((ref) => const FeeCategory());

class ClearanceNotifier extends ChangeNotifier {
  final Ref ref;

  final feeCategories = ValueNotifier<List<FeeCategory>>([]);

  final totalFee = ValueNotifier(0.0);

  final isMakingPayment = ValueNotifier(false);

  ClearanceNotifier(this.ref);

  void getFeeCategories() async {
    totalFee.value = 0.0;
    feeCategories.value.clear();

    final fees = await _getFees();
    final requirements = await  _getRequirements();
    final transactions = await  getTransactions();

    for(var fee in fees){
      final foundReq = requirements.where((element) => element.feeID == fee.feeID).toList();
      final foundTransaction = transactions.firstWhere((element) => element.feeID == fee.feeID, orElse: () => const PaymentEntity());

      final newFee = FeeCategory(feeEntity: fee, requirementEntities: foundReq, isPaid: foundTransaction.feeID != null);

      feeCategories.value.add(newFee);
    }

    for (var fee in fees) {
      final foundTransaction = transactions.firstWhere((element) =>
      element.feeID == fee.feeID, orElse: () => const PaymentEntity());

      if (foundTransaction.feeID == null) {
        totalFee.value += double.parse(fee.amount!);
      }
    }

    notifyListeners();
  }

  Future<List<FeeEntity>> _getFees() async {
    final feeRes = await ref.read(feeRepositoryProvider).getFees();

    return feeRes.map((e) => FeeEntity.fromMap(e)).toList();
  }

  Future<List<RequirementEntity>> _getRequirements() async {
    final requirementRes = await ref.read(requirementRepositoryProvider).getRequirements();

    return requirementRes.map((e) => RequirementEntity.fromMap(e)).toList();
  }

  Future<List<PaymentEntity>> getTransactions() async {
    final transactionRes = await ref.read(transactionRepositoryProvider).getTransactions();

    return transactionRes.map((e) => PaymentEntity.fromMap(e)).toList();
  }

  void navigateToRequirementPage(FeeCategory feeCat) {
    ref.read(selectedFeeCategory.state).state = feeCat;

    ref.read(newNavigationService).navigateToNamed(Routes.studentReqPage);
  }

  void pay(FeeCategory feeCat, context) async {
    if(feeCat.feeEntity!.amount == null) return;
    
    final amount = double.parse(feeCat.feeEntity!.amount!);

    isMakingPayment.value = true;
    notifyListeners();

    StudentEntity? student = ref.read(studentEntityState.state).state;
    if(student == null || student.cashInWallet == null) {
      final mStudent = await ref.read(studentRepositoryProvider).getOneStudents(FirebaseAuth.instance.currentUser!.uid);
      student = StudentEntity.fromMap(mStudent);
    }

    double cashInWallet = double.parse(student.cashInWallet ?? '0.0');

    if(cashInWallet >= amount){
      bool isSuccessful = await _payWithWallet(amount, student: student, feeCat: feeCat);

      isMakingPayment.value = false;
      notifyListeners();

      if(!isSuccessful){
        showError(text: AppStrings.errorText, context: context);
        return;
      }

      showSuccess(text: 'Successfully paid', context: context);
      getFeeCategories();
      return;
    }

    final refCode = await _payWithPaystack(amount);

    isMakingPayment.value = false;
    notifyListeners();

    if(refCode.isEmpty){
      showError(text: AppStrings.errorText, context: context);
      return;
    }

    bool isSuccessful = await _savePaymentInfo(amount.toString(), refCode: refCode, feeCat: feeCat);

    if(!isSuccessful){
      showError(text: AppStrings.errorText, context: context);
      return;
    }

    showSuccess(text: 'Successfully paid', context: context);
    getFeeCategories();
    return;
  }

  Future<bool> _payWithWallet(double amount, {required FeeCategory feeCat, required StudentEntity student}) async {
    bool isSuccessful = await _savePaymentInfo(amount.toString(), feeCat: feeCat);

    if(!isSuccessful) return false;

    double cashInWallet = double.parse(student.cashInWallet!) - amount;

    final mStudent = student.copyWith(cashInWallet: cashInWallet.toString());

    try {
      return await ref.read(updateDataInFireStore(FireStoreParams(
        collectionName: FireStoreCollectionStrings.students,
        uid: mStudent.uid!,
        data: mStudent.toMap(),
      )).future);
    } catch (e, stack) {
      debugPrintStack(stackTrace: stack);
      return false;
    }
  }

  Future<String> _payWithPaystack(double amount) async {
    final result = await ref.read(paymentNotifierProvider).pay(amount.toString());

    if(result == null) return '';
    if(result.status != PaymentStatus.success.name) return '';
    if(result.reference == null) return '';

    return result.reference!;
  }

  Future<bool> _savePaymentInfo(String amount, {String? refCode, required FeeCategory feeCat}) async {
    String userUid = FirebaseAuth.instance.currentUser!.uid;

    final payment = PaymentEntity(
      description: 'Payment for clearance: ${feeCat.feeEntity!.feeID}',
      dateTime: DateTime.now().toString(),
      amount: amount,
      feeID: feeCat.feeEntity!.feeID!,
      referenceCode: refCode ?? nanoid(10),
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