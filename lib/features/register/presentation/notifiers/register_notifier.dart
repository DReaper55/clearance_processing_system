import 'package:clearance_processing_system/core/config/exceptions/failure.dart';
import 'package:clearance_processing_system/core/helpers/helpers_functions.dart';
import 'package:clearance_processing_system/core/services/navigation_services.dart';
import 'package:clearance_processing_system/core/utils/routes.dart';
import 'package:clearance_processing_system/core/utils/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final registerNotifierProvider =
    ChangeNotifierProvider((ref) => RegisterNotifier(ref));

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

    try {
      UserCredential appUser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email, password: password);

      isCreating.value = false;
      notifyListeners();

      if(appUser.user == null) {
        showError(text: AppStrings.errorText, context: context);

        return;
      }

      showSuccess(text: 'Account created', context: context);

      ref.read(navigationService).navigateToNamed(Routes.sideNavPages);

      return;
    } on Failure catch (ex) {
      isCreating.value = false;
      notifyListeners();

      showError(text: ex.message, context: context);
      throw Exception(
          'FirebaseAuthFailure: Failed to Register user to Firebase');
    } finally {

    }
  }

  void navigateToRegistrationPage() {
    ref.read(navigationService).navigateToNamed(Routes.register);
  }
}