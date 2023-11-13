import 'package:clearance_processing_system/core/config/exceptions/failure.dart';
import 'package:clearance_processing_system/core/helpers/helpers_functions.dart';
import 'package:clearance_processing_system/core/services/navigation_services.dart';
import 'package:clearance_processing_system/core/utils/routes.dart';
import 'package:clearance_processing_system/core/utils/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final loginNotifierProvider =
    ChangeNotifierProvider((ref) => LoginNotifier(ref));

class LoginNotifier extends ChangeNotifier {
  final Ref ref;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final isStudent = ValueNotifier(false);

  final isCreating = ValueNotifier(false);

  LoginNotifier(this.ref);

  void toggleUserType(bool? value) {
    isStudent.value = !isStudent.value;
    notifyListeners();
  }

  void login(context) async {
    String email = emailController.text;
    String password = passwordController.text;
    // bool mIsStudent = isStudent.value;

    isCreating.value = true;
    notifyListeners();

    try {
      UserCredential appUser = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      isCreating.value = false;
      notifyListeners();

      if(appUser.user == null){
        showError(text: AppStrings.errorText, context: context);

        return;
      }

      ref.read(navigationService).navigateToNamed(Routes.sideNavPages);
      return;

    } on FirebaseAuthException catch (ex) {
      isCreating.value = false;
      notifyListeners();

      showError(text: ex.message ?? AppStrings.errorText, context: context);

      throw Failure(ex.message ?? 'Something went wrong!');
    }
  }

  void navigateToRegistrationPage() {
    ref.read(navigationService).navigateToNamed(Routes.register);
  }
}