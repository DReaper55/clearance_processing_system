import 'package:clearance_processing_system/core/helpers/extensions.dart';
import 'package:clearance_processing_system/core/helpers/helpers_functions.dart';
import 'package:clearance_processing_system/core/utils/strings.dart';
import 'package:clearance_processing_system/features/register/domain/entities/user.dart';
import 'package:clearance_processing_system/features/register/domain/use-cases/vendor_firestore_usecases.dart';
import 'package:clearance_processing_system/features/register/presentation/providers/save_data_to_firebase_providers.dart';
import 'package:clearance_processing_system/features/student-management/domain/entities/student.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../register/presentation/notifiers/create_account.dart';
import '../../../register/presentation/notifiers/register_notifier.dart';

final myProfileNotifierProvider =
ChangeNotifierProvider((ref) => RegisterStudentNotifier(ref));

class RegisterStudentNotifier extends ChangeNotifier {
  final Ref ref;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController matricController = TextEditingController();
  final TextEditingController facultyController = TextEditingController();
  final TextEditingController deptController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final isCreating = ValueNotifier(false);

  RegisterStudentNotifier(this.ref);

  void updateProfile(context) async {
    String email = emailController.text;
    String password = passwordController.text;

    isCreating.value = true;
    notifyListeners();

    // final isSuccessful = await _saveUserData();

    isCreating.value = false;
    notifyListeners();

    // if (isSuccessful) {
    //   showSuccess(text: 'Account created', context: context);
    // }
  }

  Future<bool> _saveUserData() async {
    String userUid = FirebaseAuth.instance.currentUser!.uid;

    final user = StudentEntity(
      isSubscribed: false,
      fullName: fullNameController.text,
      faculty: facultyController.text,
      email: emailController.text,
      department: deptController.text,
      createdBy: userUid,
      uid: userUid,
      dateTime: DateTime.now().toString(),
      matric: matricController.text,
    );

    try {
      return await ref.read(updateDataInFireStore(FireStoreParams(
        collectionName: FireStoreCollectionStrings.students,
        uid: userUid,
        data: user.toMap(),
      )).future);
    } catch (e, stack) {
      debugPrintStack(stackTrace: stack);
      return false;
    }
  }
}