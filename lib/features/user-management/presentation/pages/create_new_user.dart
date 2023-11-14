import 'package:clearance_processing_system/core/helpers/helpers_functions.dart';
import 'package:clearance_processing_system/core/utils/strings.dart';
import 'package:clearance_processing_system/core/utils/validations.dart';
import 'package:clearance_processing_system/general_widgets/UCPSScaffold.dart';
import 'package:clearance_processing_system/general_widgets/custom-widgets/dropdown_field.dart';
import 'package:clearance_processing_system/general_widgets/shrink_button.dart';
import 'package:clearance_processing_system/general_widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../notifiers/create_user_notifier.dart';

class CreateNewUser extends HookConsumerWidget {
  const CreateNewUser({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createNewUserNotifier = ref.watch(createNewUserNotifierProvider);

    return UCPSScaffold(
      title: AppStrings.createNewUser,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: Helpers.width(context) * .5,
        height: Helpers.height(context) * .9,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: createNewUserNotifier.emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: Validators.email(),
              ),

              const Spacing.mediumHeight(),
              TextFormField(
                controller: createNewUserNotifier.fullNameController,
                decoration: const InputDecoration(labelText: 'Full name'),
                validator: Validators.notEmpty(),
              ),

              const Spacing.mediumHeight(),
              TextFormField(
                controller: createNewUserNotifier.passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: Validators.password(),
              ),

              const Spacing.mediumHeight(),
              TextFormField(
                controller: createNewUserNotifier.confirmPasswordController,
                decoration: const InputDecoration(labelText: 'Confirm password'),
                obscureText: true,
                validator: Validators.password(),
              ),
              const Spacing.xLargeHeight(),

              DropDownField(
                values: createNewUserNotifier.adminRoles,
                label: 'Select a role',
                onChanged: createNewUserNotifier.onDropdownChanged,
                currentValue: createNewUserNotifier.selectedRole.value,
              ),

              const Spacing.xxLargeHeight(),
              ShrinkButton(
                onTap: () => createNewUserNotifier.createNewUser(context),
                text: 'Create account',
                isExpanded: true,
                isLoading: createNewUserNotifier.isCreating.value,
              ),

              const Spacing.xxLargeHeight(),
            ],
          ),
        ),
      ),
    );
  }
}