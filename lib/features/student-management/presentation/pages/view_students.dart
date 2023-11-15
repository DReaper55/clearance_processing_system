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
        viewStudentsNotifier.getStudents();
      });

      return () {
      };
    }, []);

    return UCPSScaffold(
        title: AppStrings.viewRecords,
        child: SizedBox(
          child: (){
            if(viewStudentsNotifier.students.value.isEmpty){
              return const SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: CircularProgressIndicator());
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
    final userRecords = viewStudentsNotifier.students.value;
    List<DataRow> dataRows = userRecords.map((e) => DataRow(cells: [
      DataCell(Text(e.email!)),
      DataCell(Text(e.fullName!)),
      DataCell(Text(e.matric!)),
      DataCell(Text(e.faculty!)),
      DataCell(Text(e.department!)),
      DataCell(Text(e.dateTime!)),
    ])).toList();


    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        rows: dataRows,
        columns: const [
          DataColumn(label: Text("Email")),
          DataColumn(label: Text("Full name")),
          DataColumn(label: Text("Matric number")),
          DataColumn(label: Text("Faculty")),
          DataColumn(label: Text("Department")),
          DataColumn(label: Text("Date created")),
        ],
      ),
    );
  }
}
