import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/firestore/transaction_datasource.dart';

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) => TransactionRepository());

final getTransactionsUseCaseProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final transactionRepository = ref.read(transactionRepositoryProvider);
  return await transactionRepository.getTransactions();
});
