import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/enitites/payment.dart';
import '../providers/transaction_data_provider.dart';

final viewTransactionsNotifierProvider =
    ChangeNotifierProvider((ref) => ViewTransactionsNotifier(ref));

class ViewTransactionsNotifier extends ChangeNotifier {
  final Ref ref;
  
  final transactions = ValueNotifier<List<PaymentEntity>>([]);
  
  ViewTransactionsNotifier(this.ref);
  
  void getTransactions() async {
    final transactionRes = await ref.read(transactionRepositoryProvider).getTransactions();

    transactions.value = transactionRes.map((e) => PaymentEntity.fromMap(e)).toList();

    notifyListeners();
  }
}