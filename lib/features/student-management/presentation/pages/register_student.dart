import 'package:clearance_processing_system/core/helpers/helpers_functions.dart';
import 'package:clearance_processing_system/core/utils/strings.dart';
import 'package:clearance_processing_system/core/utils/validations.dart';
import 'package:clearance_processing_system/general_widgets/UCPSScaffold.dart';
import 'package:clearance_processing_system/general_widgets/custom-widgets/dropdown_field.dart';
import 'package:clearance_processing_system/general_widgets/shrink_button.dart';
import 'package:clearance_processing_system/general_widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../notifiers/register_student_notifier.dart';

class RegisterStudent extends HookConsumerWidget {
  const RegisterStudent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createNewStudentNotifier = ref.watch(createNewStudentNotifierProvider);

    return UCPSScaffold(
      title: AppStrings.createNewStudent,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: Helpers.width(context) * .5,
        height: Helpers.height(context) * .9,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: createNewStudentNotifier.emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: Validators.email(),
              ),

              const Spacing.mediumHeight(),
              TextFormField(
                controller: createNewStudentNotifier.fullNameController,
                decoration: const InputDecoration(labelText: 'Full name'),
                validator: Validators.notEmpty(),
              ),

              const Spacing.mediumHeight(),
              TextFormField(
                controller: createNewStudentNotifier.matricController,
                decoration: const InputDecoration(labelText: 'Matric number'),
                validator: Validators.notEmpty(),
              ),

              const Spacing.mediumHeight(),
              TextFormField(
                controller: createNewStudentNotifier.facultyController,
                decoration: const InputDecoration(labelText: 'Faculty'),
                validator: Validators.notEmpty(),
              ),

              const Spacing.mediumHeight(),
              TextFormField(
                controller: createNewStudentNotifier.deptController,
                decoration: const InputDecoration(labelText: 'Department'),
                validator: Validators.notEmpty(),
              ),

              const Spacing.mediumHeight(),
              TextFormField(
                controller: createNewStudentNotifier.passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: Validators.password(),
              ),

              const Spacing.mediumHeight(),
              TextFormField(
                controller: createNewStudentNotifier.confirmPasswordController,
                decoration: const InputDecoration(labelText: 'Confirm password'),
                obscureText: true,
                validator: Validators.password(),
              ),

              const Spacing.xxLargeHeight(),
              ShrinkButton(
                onTap: () => createNewStudentNotifier.createNewStudent(context),
                text: 'Create account',
                isExpanded: true,
                isLoading: createNewStudentNotifier.isCreating.value,
              ),

              const Spacing.xxLargeHeight(),
            ],
          ),
        ),
      ),
    );
  }
}