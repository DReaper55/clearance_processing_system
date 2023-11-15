import 'package:clearance_processing_system/core/helpers/helpers_functions.dart';
import 'package:clearance_processing_system/core/utils/routes.dart';
import 'package:clearance_processing_system/core/utils/strings.dart';
import 'package:clearance_processing_system/general_widgets/UCPSScaffold.dart';
import 'package:clearance_processing_system/general_widgets/shrink_button.dart';
import 'package:clearance_processing_system/general_widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StudentManagement extends HookConsumerWidget {
  const StudentManagement({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UCPSScaffold(
      title: AppStrings.studentManagement,
      showLeadingBtn: false,
      child: SizedBox(
        width: Helpers.width(context),
        child: Wrap(
          children: [
            ShrinkButton(
              hasBorder: true,
              text: 'Register a student',
              icon: const Icon(Icons.add),
              hasIcon: true,
              onTap: () => Navigator.of(context).pushNamed(Routes.createStudent),
            ),
            const Spacing.largeWidth(),
            const Spacing.largeHeight(),

            ShrinkButton(
              hasBorder: true,
              text: 'View student records',
              icon: const Icon(Icons.people_alt_outlined),
              hasIcon: true,
              onTap: () => Navigator.of(context).pushNamed(Routes.viewStudents),
            ),
          ],
        ),
      ),
    );
  }
}