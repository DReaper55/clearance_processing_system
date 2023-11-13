import 'package:clearance_processing_system/core/helpers/helpers_functions.dart';
import 'package:clearance_processing_system/core/utils/colors.dart';
import 'package:clearance_processing_system/core/utils/dimensions.dart';
import 'package:clearance_processing_system/core/utils/validations.dart';
import 'package:clearance_processing_system/general_widgets/shrink_button.dart';
import 'package:clearance_processing_system/general_widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../notifiers/login_notifier.dart';

class Login extends HookConsumerWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginNotifier = ref.watch(loginNotifierProvider);

    return  Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          width: Helpers.width(context) * .5,
          height: Helpers.height(context) * .65,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.medium),
            border: Border.all(color: UCPSColors.grey)
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: loginNotifier.emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: Validators.email(),
                ),
                const Spacing.mediumHeight(),
                TextField(
                  controller: loginNotifier.passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                const Spacing.mediumHeight(),
                Row(
                  children: [
                    const Text("I'm a Student"),
                    Checkbox(
                      value: loginNotifier.isStudent.value,
                      onChanged: loginNotifier.toggleUserType,
                    ),
                  ],
                ),

                const Spacing.largeHeight(),
                ShrinkButton(
                  onTap: () => loginNotifier.login(context),
                  text: 'Login',
                  isExpanded: true,
                  isLoading: loginNotifier.isCreating.value,
                ),

                const Spacing.xxLargeHeight(),
                TextButton(
                  onPressed: loginNotifier.navigateToRegistrationPage,
                  child: const Text('Register a new admin'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}