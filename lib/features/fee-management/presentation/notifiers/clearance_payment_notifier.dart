import 'package:clearance_processing_system/features/fee-management/domain/enitites/fee_entity.dart';
import 'package:clearance_processing_system/features/fee-management/presentation/providers/fee_data_provider.dart';
import 'package:clearance_processing_system/features/student-management/presentation/providers/student_data_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../student-management/domain/entities/student.dart';
import '../../../wallet/domain/enitites/payment.dart';
import '../../../wallet/presentation/providers/transaction_data_provider.dart';
import '../../domain/enitites/clearance_payment_category.dart';

final clearancePaymentNotifierProvider =
    ChangeNotifierProvider((ref) => ClearancePaymentNotifier(ref));

class ClearancePaymentNotifier extends ChangeNotifier {
  final Ref ref;

  final clearancePayments = ValueNotifier<List<ClearancePaymentCategory>>([]);

  ClearancePaymentNotifier(this.ref);

  void setData() async {
    final payments = await getAllTransactions();
    final students = await _getStudents();
    final fees = await _getFees();

    payments.removeWhere((element) => element.description!.contains('wallet'));

    for(var payment in payments){
      final foundStudent = students.firstWhere((element) => element.uid == payment.userID, orElse: () => const StudentEntity());
      final foundFee = fees.firstWhere((element) => element.feeID == payment.feeID, orElse: () => const FeeEntity());

      if(foundStudent.uid != null){
        clearancePayments.value.add(ClearancePaymentCategory(
          paymentEntity: payment,
          studentEntity: foundStudent,
          feeEntity: foundFee
        ));
      }
    }

    notifyListeners();
  }

  Future<List<PaymentEntity>> getAllTransactions() async {
    final transactionRes = await ref.read(transactionRepositoryProvider).getAllTransactions();
    return transactionRes.map((e) => PaymentEntity.fromMap(e)).toList();
  }

  Future<List<FeeEntity>> _getFees() async {
    final feeRes = await ref.read(feeRepositoryProvider).getFees();
    return feeRes.map((e) => FeeEntity.fromMap(e)).toList();
  }

  Future<List<StudentEntity>> _getStudents() async {
    final studentsRes = await ref.read(studentRepositoryProvider).getStudents();
    return studentsRes.map((e) => StudentEntity.fromMap(e)).toList();
  }

}