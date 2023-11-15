import 'package:clearance_processing_system/core/helpers/extensions.dart';
import 'package:clearance_processing_system/core/utils/strings.dart';
import 'package:clearance_processing_system/general_widgets/UCPSScaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../notifiers/view_fees_notifier.dart';


class ViewFees extends HookConsumerWidget {
  const ViewFees({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewFeesNotifier = ref.watch(viewFeesNotifierProvider);

    useEffect(() {

      Future.delayed(const Duration(milliseconds: 500), () {
        viewFeesNotifier.getFees();
      });

      return () {
      };
    }, []);

    return UCPSScaffold(
        title: AppStrings.viewFees,
        child: SizedBox(
          child: (){
            if(viewFeesNotifier.fees.value.isEmpty){
              return const Center(child: SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: CircularProgressIndicator()));
            }

            return UserTable(viewFeesNotifier: viewFeesNotifier);
          }(),
        ),
    );
  }
}

class UserTable extends StatelessWidget {
  final ViewFeesNotifier viewFeesNotifier;

  const UserTable({super.key, required this.viewFeesNotifier});

  @override
  Widget build(BuildContext context) {
    final userRecords = viewFeesNotifier.fees.value;
    List<DataRow> dataRows = userRecords.map((e) => DataRow(cells: [
      DataCell(Text(e.title ?? '')),
      DataCell(Text((){
        if(e.amount != null){
          return 'N${e.amount!.addComma()}';
        }

        return '';
      }())),
      DataCell(Text(e.accountNumber ?? '')),
      DataCell(Text(e.accountName ?? '')),
      DataCell(Text(e.bankName ?? '')),
      DataCell(Text(e.departmentsToPay ?? '')),
      DataCell(Text(e.dateTime ?? '')),
    ])).toList();


    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        rows: dataRows,
        columns: const [
          DataColumn(label: Text("Title")),
          DataColumn(label: Text("Amount")),
          DataColumn(label: Text("Account number")),
          DataColumn(label: Text("Account name")),
          DataColumn(label: Text("Bank name")),
          DataColumn(label: Text("Departments to pay")),
          DataColumn(label: Text("Date created")),
        ],
      ),
    );
  }
}
