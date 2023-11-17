import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:clearance_processing_system/core/helpers/helpers_functions.dart';
import 'package:clearance_processing_system/core/utils/strings.dart';
import 'package:clearance_processing_system/core/utils/validations.dart';
import 'package:clearance_processing_system/general_widgets/UCPSScaffold.dart';
import 'package:clearance_processing_system/general_widgets/shrink_button.dart';
import 'package:clearance_processing_system/general_widgets/spacing.dart';

import '../notifiers/my_profile_notifier.dart';

class MyProfile extends HookConsumerWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myProfileNotifier = ref.watch(myProfileNotifierProvider);

    return UCPSScaffold(
      title: AppStrings.myProfile,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: Helpers.width(context) * .5,
        height: Helpers.height(context) * .9,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: myProfileNotifier.emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: Validators.email(),
              ),

              const Spacing.mediumHeight(),
              TextFormField(
                controller: myProfileNotifier.fullNameController,
                decoration: const InputDecoration(labelText: 'Full name'),
                validator: Validators.notEmpty(),
              ),

              const Spacing.mediumHeight(),
              TextFormField(
                controller: myProfileNotifier.matricController,
                decoration: const InputDecoration(labelText: 'Matric number'),
                validator: Validators.notEmpty(),
              ),

              const Spacing.mediumHeight(),
              TextFormField(
                controller: myProfileNotifier.facultyController,
                decoration: const InputDecoration(labelText: 'Faculty'),
                validator: Validators.notEmpty(),
              ),

              const Spacing.mediumHeight(),
              TextFormField(
                controller: myProfileNotifier.deptController,
                decoration: const InputDecoration(labelText: 'Department'),
                validator: Validators.notEmpty(),
              ),

              const Spacing.mediumHeight(),
              TextFormField(
                controller: myProfileNotifier.passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: Validators.password(),
              ),

              const Spacing.mediumHeight(),
              TextFormField(
                controller: myProfileNotifier.confirmPasswordController,
                decoration: const InputDecoration(labelText: 'Confirm password'),
                obscureText: true,
                validator: Validators.password(),
              ),

              const Spacing.xxLargeHeight(),
              ShrinkButton(
                onTap: () => myProfileNotifier.updateProfile(context),
                text: 'Update profile',
                isExpanded: true,
                isLoading: myProfileNotifier.isCreating.value,
              ),

              const Spacing.xxLargeHeight(),
            ],
          ),
        ),
      ),
    );
  }
}