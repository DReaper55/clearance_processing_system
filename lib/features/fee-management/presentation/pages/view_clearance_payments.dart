import 'package:clearance_processing_system/core/helpers/extensions.dart';
import 'package:clearance_processing_system/core/utils/strings.dart';
import 'package:clearance_processing_system/general_widgets/UCPSScaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../notifiers/clearance_payment_notifier.dart';



class ClearancePayments extends HookConsumerWidget {
  const ClearancePayments({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clearancePaymentNotifier = ref.watch(clearancePaymentNotifierProvider);

    useEffect(() {

      Future.delayed(const Duration(milliseconds: 500), () {
        clearancePaymentNotifier.setData();
      });

      return () {
      };
    }, []);

    return UCPSScaffold(
      title: AppStrings.clearancePayments,
      child: SizedBox(
        child: (){
          if(clearancePaymentNotifier.clearancePayments.value.isEmpty){
            return const Center(child: SizedBox(
                height: 50.0,
                width: 50.0,
                child: CircularProgressIndicator()));
          }

          return _TransactionTable(clearancePaymentNotifier: clearancePaymentNotifier);
        }(),
      ),
    );
  }
}

class _TransactionTable extends StatelessWidget {
  final ClearancePaymentNotifier clearancePaymentNotifier;

  const _TransactionTable({required this.clearancePaymentNotifier});

  @override
  Widget build(BuildContext context) {
    final userRecords = clearancePaymentNotifier.clearancePayments.value;
    List<DataRow> dataRows = userRecords.map((e) => DataRow(cells: [
      DataCell(Text(e.paymentEntity!.referenceCode!)),
      DataCell(Text((){
        if(e.paymentEntity!.amount != null){
          return 'N${e.paymentEntity!.amount!.addComma()}';
        }

        return '';
      }())),
      DataCell(Text(e.paymentEntity!.description!)),
      DataCell(Text(e.feeEntity!.title ?? '')),
      DataCell(Text(e.studentEntity!.fullName!)),
      DataCell(Text(e.studentEntity!.matric!)),
      DataCell(Text(e.paymentEntity!.dateTime!)),
    ])).toList();


    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        rows: dataRows,
        columns: const [
          DataColumn(label: Text("Reference code")),
          DataColumn(label: Text("Amount")),
          DataColumn(label: Text("Description")),
          DataColumn(label: Text("Clearance")),
          DataColumn(label: Text("Student's name")),
          DataColumn(label: Text("Student's matric")),
          DataColumn(label: Text("Date paid")),
        ],
      ),
    );
  }
}
