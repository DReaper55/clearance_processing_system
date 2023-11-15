import 'package:clearance_processing_system/features/wallet/domain/enitites/transaction.dart';
import 'package:clearance_processing_system/features/wallet/domain/repositories/payment_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:clearance_processing_system/core/config/exceptions/task_failure.dart';

import '../generic-datasources/transaction_datasource.dart';

class TransactionRepoImpl implements TransactionRepo {
  final TransactionDataSource dataSource;

  TransactionRepoImpl({required this.dataSource});

  @override
  Future<Either<TaskFailure, TransactionEntity>> initializeTransaction({required String email,
    required String amount,
    String? subAccountCode}) async {
    try{
      TransactionEntity payload = await dataSource.initializeTransaction(email: email, amount: amount, subAccountCode: subAccountCode);
      return Right(payload);
    } on Exception{
      return Left(PayStackFailure(message: 'Failed to initiate transaction'));
    }
  }

  @override
  Future<Either<TaskFailure, TransactionEntity>> verifyTransaction({required String reference}) async {
    try{
      TransactionEntity payload = await dataSource.verifyTransaction(reference: reference);
      return Right(payload);
    } on Exception catch (e){
      return Left(PayStackFailure(message: 'Failed to verify transaction, $e'));
    }
  }

  @override
  Future<Either<TaskFailure, TransactionEntity>> createCharge({required String email, required String amount, String? authCode}) async {
    try{
      TransactionEntity customer = await dataSource.createCharge(email: email, amount: amount, authCode: authCode);
      return Right(customer);
    } on Exception catch (e){
      return Left(PayStackFailure(message: 'Failed to charge card: $e'));
    }
  }
}