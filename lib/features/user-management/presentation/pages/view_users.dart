import 'package:clearance_processing_system/core/utils/strings.dart';
import 'package:clearance_processing_system/general_widgets/UCPSScaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../notifiers/view_users_notifier.dart';

class ViewUsers extends HookConsumerWidget {
  const ViewUsers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewUsersNotifier = ref.watch(viewUsersNotifierProvider);

    useEffect(() {

      Future.delayed(const Duration(milliseconds: 500), () {
        viewUsersNotifier.getUsers();
      });

      return () {
      };
    }, []);

    return UCPSScaffold(
        title: AppStrings.viewRecords,
        child: SizedBox(
          child: (){
            if(viewUsersNotifier.users.value.isEmpty){
              return const Center(child: SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: CircularProgressIndicator()));
            }

            return UserTable(viewUsersNotifier: viewUsersNotifier);
          }(),
        ),
    );
  }
}

class UserTable extends StatelessWidget {
  final ViewUsersNotifier viewUsersNotifier;

  const UserTable({super.key, required this.viewUsersNotifier});

  @override
  Widget build(BuildContext context) {
    final userRecords = viewUsersNotifier.users.value;
    List<DataRow> dataRows = userRecords.map((e) => DataRow(cells: [
      DataCell(Text(e.email!)),
      DataCell(Text(e.fullName!)),
      DataCell(Text(e.role!)),
      DataCell(Text(e.dateTime!)),
    ])).toList();


    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        rows: dataRows,
        columns: const [
          DataColumn(label: Text("Email")),
          DataColumn(label: Text("Full name")),
          DataColumn(label: Text("Role")),
          DataColumn(label: Text("Date created")),
        ],
      ),
    );
  }
}
