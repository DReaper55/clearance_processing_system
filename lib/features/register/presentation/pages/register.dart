import 'package:clearance_processing_system/core/helpers/helpers_functions.dart';
import 'package:clearance_processing_system/core/utils/colors.dart';
import 'package:clearance_processing_system/core/utils/dimensions.dart';
import 'package:clearance_processing_system/core/utils/validations.dart';
import 'package:clearance_processing_system/general_widgets/shrink_button.dart';
import 'package:clearance_processing_system/general_widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../notifiers/register_notifier.dart';

class Register extends HookConsumerWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerNotifier = ref.watch(registerNotifierProvider);

    return  Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          width: Helpers.width(context) * .5,
          height: Helpers.height(context) * .7,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.medium),
              border: Border.all(color: UCPSColors.grey)
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: registerNotifier.emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: Validators.email(),
                ),

                const Spacing.mediumHeight(),
                TextField(
                  controller: registerNotifier.passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),

                const Spacing.mediumHeight(),
                TextField(
                  controller: registerNotifier.confirmPasswordController,
                  decoration: const InputDecoration(labelText: 'Confirm password'),
                  obscureText: true,
                ),

                const Spacing.largeHeight(),
                ShrinkButton(
                  onTap: () => registerNotifier.register(context),
                  text: 'Create account',
                  isExpanded: true,
                  isLoading: registerNotifier.isCreating.value,
                ),

                const Spacing.xxLargeHeight(),
                TextButton(
                  onPressed: Navigator.of(context).pop,
                  child: const Text('Back to login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}