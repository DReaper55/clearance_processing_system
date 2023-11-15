import 'package:clearance_processing_system/features/wallet/data/generic-datasources/transaction_client.dart';
import 'package:clearance_processing_system/features/wallet/data/generic-datasources/transaction_datasource.dart';
import 'package:clearance_processing_system/features/wallet/data/repositories/transaction_repo_impl.dart';
import 'package:clearance_processing_system/features/wallet/domain/repositories/payment_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/use-cases/transaction_usecases.dart';

final transactionRepoProvider = Provider<TransactionRepo>((ref) {
  return TransactionRepoImpl(dataSource: TransactionDataSourceImpl(TransactionClient()));
});

final initializeTransactionProvider =
Provider.autoDispose<InitializeTransaction>((ref) {
  final repository = ref.watch(transactionRepoProvider);
  return InitializeTransaction(repository);
});

final verifyTransactionProvider =
Provider.autoDispose<VerifyTransaction>((ref) {
  final repository = ref.watch(transactionRepoProvider);
  return VerifyTransaction(repository);
});

final createChargeProvider =
Provider.autoDispose<CreateCharge>((ref) {
  final repository = ref.watch(transactionRepoProvider);
  return CreateCharge(repository);
});
