import 'package:clearance_processing_system/core/helpers/extensions.dart';
import 'package:clearance_processing_system/core/helpers/helpers_functions.dart';
import 'package:clearance_processing_system/core/utils/strings.dart';
import 'package:clearance_processing_system/features/register/domain/entities/user.dart';
import 'package:clearance_processing_system/features/register/domain/use-cases/vendor_firestore_usecases.dart';
import 'package:clearance_processing_system/features/register/presentation/providers/save_data_to_firebase_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../register/presentation/notifiers/create_account.dart';
import '../../../register/presentation/notifiers/register_notifier.dart';

final createNewUserNotifierProvider =
ChangeNotifierProvider((ref) => CreateUserNotifier(ref));

enum Roles { library, studentAffairs, medical, security }

class CreateUserNotifier extends ChangeNotifier {
  final Ref ref;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final isCreating = ValueNotifier(false);

  final selectedRole = ValueNotifier<Map<Roles, String>?>(null);

  final adminRoles = [
    {Roles.library: Roles.library.name.capitalizeFirst()},
    {Roles.medical: Roles.medical.name.capitalizeFirst()},
    {Roles.security: Roles.security.name.capitalizeFirst()},
    {Roles.studentAffairs: 'Student Affairs'},
  ];

  CreateUserNotifier(this.ref);

  void createNewUser(context) async {
    String email = emailController.text;
    String password = passwordController.text;

    isCreating.value = true;
    notifyListeners();

    final appUser = await ref.read(createAccountProvider)
        .createUserWithEmailAndPassword(email: email, password: password);

    if (appUser == null || appUser.user == null) {
      isCreating.value = false;
      notifyListeners();

      showError(text: AppStrings.errorText, context: context);

      return;
    }

    final oldUserCred = ref.read(authCredState.state).state;

    if(oldUserCred != null) {
      final oldUser = await FirebaseAuth.instance.signInWithCredential(oldUserCred);

      // print('Senddd: $oldUser');
    }

    final isSuccessful = await _saveUserData(appUser.user!.uid);

    isCreating.value = false;
    notifyListeners();

    if (isSuccessful) {
      showSuccess(text: 'Account created', context: context);
    }
  }

  Future<bool> _saveUserData(String uid) async {
    String userUid = FirebaseAuth.instance.currentUser!.uid;

    final role = selectedRole.value != null ? selectedRole.value!.values.first : adminRoles.first.values.first;

    final user = UserEntity(
      createdBy: userUid,
      email: emailController.text,
      fullName: fullNameController.text,
      isSubscribed: false,
        uid: uid,
      role: role,
        dateTime: DateTime.now().toString()
    );

    try {
      return await ref.read(addDataToFireStore(FireStoreParams(
        collectionName: FireStoreCollectionStrings.admin,
        uid: userUid,
        data: user.toMap(),
      )).future);
    } catch (e, stack) {
      debugPrintStack(stackTrace: stack);
      return false;
    }
  }

  void onDropdownChanged(Object? value) {
    selectedRole.value = value as Map<Roles, String>;

    notifyListeners();
  }
}