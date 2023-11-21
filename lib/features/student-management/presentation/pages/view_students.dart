import 'package:clearance_processing_system/core/utils/strings.dart';
import 'package:clearance_processing_system/general_widgets/UCPSScaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../notifiers/view_students_notifier.dart';

class ViewStudents extends HookConsumerWidget {
  const ViewStudents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewStudentsNotifier = ref.watch(viewStudentsNotifierProvider);

    useEffect(() {

      Future.delayed(const Duration(milliseconds: 500), () {
        viewStudentsNotifier.setData();
      });

      return () {
      };
    }, []);

    return UCPSScaffold(
        title: AppStrings.viewStudents,
        child: SizedBox(
          child: (){
            if(viewStudentsNotifier.studentCategory.value.isEmpty){
              return const Center(child: SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: CircularProgressIndicator()));
            }

            return UserTable(viewStudentsNotifier: viewStudentsNotifier);
          }(),
        ),
    );
  }
}

class UserTable extends StatelessWidget {
  final ViewStudentsNotifier viewStudentsNotifier;

  const UserTable({super.key, required this.viewStudentsNotifier});

  @override
  Widget build(BuildContext context) {
    final userRecords = viewStudentsNotifier.studentCategory.value;
    List<DataRow> dataRows = userRecords.map((e) => DataRow(
        cells: [
      DataCell(Text(e.studentEntity!.email!)),
      DataCell(Text(e.studentEntity!.fullName!)),
      DataCell(Text(e.studentEntity!.matric!)),
      DataCell(Text(e.studentEntity!.faculty!)),
      DataCell(Text(e.studentEntity!.department!)),
      DataCell(Text(e.paymentEntity!.length.toString())),
      DataCell(Text(e.requirementEntity!.length.toString())),
      DataCell(Text(e.studentEntity!.dateTime!)),
    ],
        onSelectChanged: (selected){
          if(selected != null && selected){
            viewStudentsNotifier.navigateToStudentInfoPage(e);
          }
        }
    )).toList();


    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        rows: dataRows,
        showCheckboxColumn: false,
        columns: const [
          DataColumn(label: Text("Email")),
          DataColumn(label: Text("Full name")),
          DataColumn(label: Text("Matric number")),
          DataColumn(label: Text("Faculty")),
          DataColumn(label: Text("Department")),
          DataColumn(label: Text("No of payments")),
          DataColumn(label: Text("No of pending verification")),
          DataColumn(label: Text("Date created")),
        ],
      ),
    );
  }
}
