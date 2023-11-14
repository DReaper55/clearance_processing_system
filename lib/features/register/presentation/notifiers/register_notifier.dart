import 'package:clearance_processing_system/core/config/exceptions/failure.dart';
import 'package:clearance_processing_system/core/helpers/helpers_functions.dart';
import 'package:clearance_processing_system/core/services/navigation_services.dart';
import 'package:clearance_processing_system/core/utils/routes.dart';
import 'package:clearance_processing_system/core/utils/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'create_account.dart';

final registerNotifierProvider =
    ChangeNotifierProvider((ref) => RegisterNotifier(ref));

final authCredState = StateProvider<AuthCredential?>((ref) => null);

class RegisterNotifier extends ChangeNotifier {
  final Ref ref;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final isCreating = ValueNotifier(false);

  RegisterNotifier(this.ref);

  void register(context) async {
    String email = emailController.text;
    String password = passwordController.text;

    isCreating.value = true;
    notifyListeners();

    final appUser = await ref.read(createAccountProvider).createUserWithEmailAndPassword(email: email, password: password);

    isCreating.value = false;
    notifyListeners();

    if(appUser == null || appUser.user == null) {
      showError(text: AppStrings.errorText, context: context);

      return;
    }

    showSuccess(text: 'Account created', context: context);

    ref.read(authCredState.state).state = appUser.credential;

    ref.read(navigationService).navigateToNamed(Routes.sideNavPages);
  }

  void navigateToRegistrationPage() {
    ref.read(navigationService).navigateToNamed(Routes.register);
  }
}