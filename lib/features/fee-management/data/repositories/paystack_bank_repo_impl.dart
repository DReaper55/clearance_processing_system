import 'package:clearance_processing_system/core/config/exceptions/task_failure.dart';
import 'package:dartz/dartz.dart';


import '../../domain/enitites/paystack_bank.dart';
import '../../domain/repositories/paystack_bank_repo.dart';
import '../generic-datasources/paystack_bank_datasource.dart';

class PayStackBankRepoImpl implements PayStackBankRepo {
  final PayStackBankDataSource dataSource;

  PayStackBankRepoImpl(this.dataSource);

  @override
  Future<Either<TaskFailure, List<PayStackBankEntity>>> getBanks() async {
    try{
      List<PayStackBankEntity> banks = await dataSource.getBanks();
      return Right(banks);
    } on Exception{
      return Left(PayStackFailure(message: 'Failed to retrieve banks from paystack'));
    }
  }

  @override
  Future<Either<TaskFailure, String>> verifyAccountNumber({required String accountNumber, required String bankCode}) async {
    try{
      String accountName = await dataSource.verifyAccountNumber(accountNumber: accountNumber, bankCode: bankCode);
      return Right(accountName);
    } on Exception{
      return Left(PayStackFailure(message: 'Failed to verify account number'));
    }
  }

}