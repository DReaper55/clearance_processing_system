import 'package:clearance_processing_system/core/helpers/extensions.dart';
import 'package:clearance_processing_system/core/utils/strings.dart';
import 'package:clearance_processing_system/general_widgets/UCPSScaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../notifiers/view_transactions_notifier.dart';


class TransactionHistory extends HookConsumerWidget {
  const TransactionHistory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsNotifier = ref.watch(viewTransactionsNotifierProvider);

    useEffect(() {

      Future.delayed(const Duration(milliseconds: 500), () {
        transactionsNotifier.getTransactions();
      });

      return () {
      };
    }, []);

    return UCPSScaffold(
      title: AppStrings.transactionHistory,
      child: SizedBox(
        child: (){
          if(transactionsNotifier.transactions.value.isEmpty){
            return const Center(child: SizedBox(
                height: 50.0,
                width: 50.0,
                child: CircularProgressIndicator()));
          }

          return TransactionTable(transactionsNotifier: transactionsNotifier);
        }(),
      ),
    );
  }
}

class TransactionTable extends StatelessWidget {
  final ViewTransactionsNotifier transactionsNotifier;

  const TransactionTable({super.key, required this.transactionsNotifier});

  @override
  Widget build(BuildContext context) {
    final userRecords = transactionsNotifier.transactions.value;
    List<DataRow> dataRows = userRecords.map((e) => DataRow(cells: [
      DataCell(Text(e.referenceCode!)),
      DataCell(Text((){
        if(e.amount != null){
          return 'N${e.amount!.addComma()}';
        }

        return '';
      }())),
      DataCell(Text(e.description!)),
      DataCell(Text(e.dateTime!)),
    ])).toList();


    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        rows: dataRows,
        columns: const [
          DataColumn(label: Text("Reference code")),
          DataColumn(label: Text("Amount")),
          DataColumn(label: Text("Description")),
          DataColumn(label: Text("Date created")),
        ],
      ),
    );
  }
}
