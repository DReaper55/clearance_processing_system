import 'package:clearance_processing_system/core/config/exceptions/task_failure.dart';
import 'package:clearance_processing_system/features/fee-management/domain/enitites/paystack_bank.dart';
import 'package:dartz/dartz.dart';

abstract class PayStackBankRepo {
  Future<Either<TaskFailure, List<PayStackBankEntity>>> getBanks();
  Future<Either<TaskFailure, String>> verifyAccountNumber({required String accountNumber, required String bankCode});
}