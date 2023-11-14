import 'package:clearance_processing_system/core/config/exceptions/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final createAccountProvider =
    ChangeNotifierProvider((ref) => CreateAccount(ref));

class CreateAccount extends ChangeNotifier {
  final Ref ref;

  CreateAccount(this.ref);

  Future<UserCredential?> createUserWithEmailAndPassword({required String email, required String password}) async {
    try {
      UserCredential appUser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email, password: password);

      if(appUser.user == null) {
        return null;
      }

      return appUser;
    } on Failure catch (ex) {
      throw Exception(
          'FirebaseAuthFailure: Failed to CreateUser user to Firebase');
    } finally {

    }
  }
}