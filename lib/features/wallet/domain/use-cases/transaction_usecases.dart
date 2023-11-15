import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:clearance_processing_system/core/config/exceptions/task_failure.dart';
import 'package:clearance_processing_system/features/register/utils/usecase.dart';

import '../enitites/transaction.dart';
import '../repositories/payment_repo.dart';


class InitializeTransaction implements UseCase<TransactionEntity, TransactionParams> {
  final TransactionRepo repository;

  InitializeTransaction(this.repository);

  @override
  Future<Either<TaskFailure, TransactionEntity>> call(TransactionParams params) async {
    return await repository.initializeTransaction(email: params.email!, amount: params.amount!, subAccountCode: params.subAccountCode,);
  }
}

class VerifyTransaction implements UseCase<TransactionEntity, TransactionParams> {
  final TransactionRepo repository;

  VerifyTransaction(this.repository);

  @override
  Future<Either<TaskFailure, TransactionEntity>> call(TransactionParams params) async {
    return await repository.verifyTransaction(reference: params.reference!);
  }
}

class CreateCharge implements UseCase<TransactionEntity, TransactionParams> {
  final TransactionRepo repository;

  CreateCharge(this.repository);

  @override
  Future<Either<TaskFailure, TransactionEntity>> call(TransactionParams params) async {
    return await repository.createCharge(email: params.email!, amount: params.amount!, authCode: params.authCode);
  }
}

class TransactionParams extends Equatable {
  final String? email;
  final String? amount;
  final String? subAccountCode;
  final String? reference;
  final String? authCode;

  const TransactionParams({
    this.subAccountCode,
    this.amount,
    this.email,
    this.reference,
    this.authCode,
    });

  @override
  List<Object?> get props => [
    subAccountCode,
    amount,
    email,
    authCode,
    reference,
  ];
}

