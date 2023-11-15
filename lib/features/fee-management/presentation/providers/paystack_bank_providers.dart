import 'package:clearance_processing_system/features/fee-management/data/generic-datasources/paystack_bank_client.dart';
import 'package:clearance_processing_system/features/fee-management/data/generic-datasources/paystack_bank_datasource.dart';
import 'package:clearance_processing_system/features/fee-management/domain/enitites/paystack_bank.dart';
import 'package:clearance_processing_system/features/fee-management/domain/use-cases/paystack_bank_usecases.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../register/utils/usecase.dart';
import '../../data/repositories/paystack_bank_repo_impl.dart';
import '../../domain/repositories/paystack_bank_repo.dart';

final payStackBankProvider = FutureProvider<PayStackBankRepo>((ref) async {
  return PayStackBankRepoImpl(PayStackBankDataSourceImpl(PayStackBankClient()));
});

final getBanksProvider = FutureProvider<List<PayStackBankEntity>>((ref) async {
  final repository = await ref.watch(payStackBankProvider.future);
  final result = await GetPayStackBanks(repository: repository).call(NoParams());
  return result.fold((l) {
    //   Handle error
    debugPrint('Exception: $l');
    return [];
  }, (bankList) {

    return bankList;
  });
});

final verifyAccountNumber = FutureProvider.family<String?, PayStackBankParams>((ref, params) async {
  final repository = await ref.watch(payStackBankProvider.future);
  final result = await VerifyAccountNumber(repository: repository).call(params);
  return result.fold((l) {
    //   Handle error
    debugPrint('Exception: $l');
    return null;
  }, (accountNumber) {
    return accountNumber;
  });
});