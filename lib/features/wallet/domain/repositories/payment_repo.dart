import 'package:dartz/dartz.dart';
import 'package:clearance_processing_system/core/config/exceptions/task_failure.dart';

import '../enitites/transaction.dart';

abstract class TransactionRepo {
  Future<Either<TaskFailure, TransactionEntity>> initializeTransaction(
      {required String email,
    required String amount,
    String? subAccountCode});

  Future<Either<TaskFailure, TransactionEntity>> verifyTransaction({required String reference});

  Future<Either<TaskFailure, TransactionEntity>> createCharge({required String email, required String amount, String? authCode});
}