import 'package:clearance_processing_system/core/config/exceptions/task_failure.dart';
import 'package:clearance_processing_system/features/register/utils/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../enitites/paystack_bank.dart';
import '../repositories/paystack_bank_repo.dart';


class GetPayStackBanks implements UseCase<List<PayStackBankEntity>, NoParams> {
  final PayStackBankRepo repository;

  GetPayStackBanks({required this.repository});

  @override
  Future<Either<TaskFailure, List<PayStackBankEntity>>> call(NoParams noParams) async {
    return await repository.getBanks();
  }
}

class VerifyAccountNumber implements UseCase<String, PayStackBankParams> {
  final PayStackBankRepo repository;

  VerifyAccountNumber({required this.repository});

  @override
  Future<Either<TaskFailure, String>> call(PayStackBankParams params) async {
    return await repository.verifyAccountNumber(bankCode: params.code, accountNumber: params.accountNumber,);
  }
}

class PayStackBankParams extends Equatable {
  final String accountNumber;
  final String code;


  const PayStackBankParams(this.accountNumber, this.code);

  @override
  // TODO: implement props
  List<Object?> get props => [accountNumber, code];

}
