import 'package:clearance_processing_system/core/helpers/extensions.dart';
import 'package:clearance_processing_system/core/utils/strings.dart';
import 'package:clearance_processing_system/general_widgets/UCPSScaffold.dart';
import 'package:clearance_processing_system/general_widgets/shrink_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../notifiers/fee_notifier.dart';
import '../notifiers/view_fees_notifier.dart';


class RequirementsPage extends HookConsumerWidget {
  const RequirementsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createNewFeeNotifier = ref.watch(createNewFeeNotifierProvider);

    useEffect(() {

      Future.delayed(const Duration(milliseconds: 500), () {
        // createNewFeeNotifier.getFees();
      });

      return () {
      };
    }, []);

    return UCPSScaffold(
      title: AppStrings.requirements,
      actions: [
        ShrinkButton(
          onTap: Navigator.of(context).pop,
          text: 'Done',
          isExpanded: false,
        )
      ],
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){},
        backgroundColor: Colors.transparent,
        elevation: 0.0,
          label: ShrinkButton(
            onTap: () => createNewFeeNotifier.addRequirementDialog(context),
            text: 'Add a new Requirement',
            isExpanded: false,
          ),
      ),
      child: SizedBox(
        child: (){
          if(createNewFeeNotifier.requirements.value.isEmpty){
            return const Center(child: SizedBox());
          }

          return UserTable(createNewFeeNotifier: createNewFeeNotifier);
        }(),
      ),
    );
  }
}

class UserTable extends StatelessWidget {
  final FeeNotifier createNewFeeNotifier;

  const UserTable({super.key, required this.createNewFeeNotifier});

  @override
  Widget build(BuildContext context) {
    final userRecords = createNewFeeNotifier.requirements.value;
    List<DataRow> dataRows = userRecords.map((e) => DataRow(cells: [
      DataCell(Text(e.title ?? '')),
      DataCell(Text(e.description ?? '')),
      DataCell(Text(e.feeID ?? '')),
      DataCell(Text(e.dateTime ?? '')),
    ])).toList();


    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        rows: dataRows,
        columns: const [
          DataColumn(label: Text("Title")),
          DataColumn(label: Text("Description")),
          DataColumn(label: Text("Fee ID")),
          DataColumn(label: Text("Date created")),
        ],
      ),
    );
  }
}
