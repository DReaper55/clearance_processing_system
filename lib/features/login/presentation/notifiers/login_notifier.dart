import 'package:clearance_processing_system/core/config/exceptions/failure.dart';
import 'package:clearance_processing_system/core/helpers/helpers_functions.dart';
import 'package:clearance_processing_system/core/services/navigation_services.dart';
import 'package:clearance_processing_system/core/utils/routes.dart';
import 'package:clearance_processing_system/core/utils/strings.dart';
import 'package:clearance_processing_system/features/login/domain/use-cases/shared_prefs_usecases.dart';
import 'package:clearance_processing_system/features/register/domain/entities/user.dart';
import 'package:clearance_processing_system/features/student-management/domain/entities/student.dart';
import 'package:clearance_processing_system/features/student-management/presentation/providers/student_data_provider.dart';
import 'package:clearance_processing_system/features/user-management/presentation/providers/admin_data_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../register/presentation/notifiers/register_notifier.dart';
import '../providers/shared_prefs_providers.dart';
import 'user_notifier.dart';

final loginNotifierProvider =
    ChangeNotifierProvider((ref) => LoginNotifier(ref));

// final userIsStudentStateNotifier = StateProvider.autoDispose<bool>((ref) => false);

final studentEntityState =
StateProvider<StudentEntity?>((ref) => const StudentEntity());

final userEntityState =
StateProvider<UserEntity?>((ref) => const UserEntity());

class LoginNotifier extends ChangeNotifier {
  final Ref ref;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final isStudent = ValueNotifier(false);

  final isCreating = ValueNotifier(false);

  final canRegisterNewAccount = ValueNotifier(false);

  LoginNotifier(this.ref);

  void toggleUserType(bool? value) {
    isStudent.value = !isStudent.value;
    notifyListeners();
  }

  void _resetData() {
    emailController.clear();
    passwordController.clear();
    isStudent.value = false;

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

      ref.read(authCredState.state).state = appUser.credential;

      ref.read(userIsStudentStateNotifier.notifier).setIsStudent(isStudent.value);

      _resetData();

      _setUserData();

      Future.delayed(const Duration(seconds: 1), (){
        ref.read(navigationService).navigateToNamed(Routes.sideNavPages);
        return;
      });

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

  void checkForUsers() async {
    final userRef = await ref.read(userRepositoryProvider).getUsers();

    if(userRef.isEmpty){
      canRegisterNewAccount.value = true;
    }

    notifyListeners();
  }

  void _setUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if(user == null) return;

    if(isStudent.value){
      final mUser = await ref.read(studentRepositoryProvider).getOneStudents(user.uid);
      ref.read(studentEntityState.state).state = StudentEntity.fromMap(mUser);
      return;
    }

    final mUser = await ref.read(userRepositoryProvider).getOneUser(user.uid);
    ref.read(userEntityState.state).state = UserEntity.fromMap(mUser);
    return;
  }
}