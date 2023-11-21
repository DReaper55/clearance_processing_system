import 'package:clearance_processing_system/features/login/presentation/notifiers/login_notifier.dart';
import 'package:clearance_processing_system/features/student-management/domain/entities/student.dart';
import 'package:clearance_processing_system/features/student-management/presentation/providers/student_data_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final dashboardNotifierProvider =
    ChangeNotifierProvider((ref) => DashboardNotifier(ref));

class DashboardNotifier extends ChangeNotifier {
  final Ref ref;

  final cashInWallet = ValueNotifier('0.0');

  DashboardNotifier(this.ref);

  void setData() async {
    StudentEntity? student = ref.read(studentEntityState.state).state;

    if(student == null || student.cashInWallet == null){
      final mStudent = await ref.read(studentRepositoryProvider).getOneStudents(FirebaseAuth.instance.currentUser!.uid);

      student = StudentEntity.fromMap(mStudent);
    }

    if(student.cashInWallet == null) return;

    cashInWallet.value = student.cashInWallet!;

    notifyListeners();
  }
}