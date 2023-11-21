import 'package:clearance_processing_system/core/helpers/helpers_functions.dart';
import 'package:clearance_processing_system/core/utils/strings.dart';
import 'package:clearance_processing_system/features/clearance/domain/uploaded_req_entity.dart';
import 'package:clearance_processing_system/features/clearance/presentation/notifiers/student_req_notifier.dart';
import 'package:clearance_processing_system/features/register/domain/use-cases/vendor_firestore_usecases.dart';
import 'package:clearance_processing_system/features/register/presentation/providers/save_data_to_firebase_providers.dart';
import 'package:clearance_processing_system/features/student-management/domain/entities/student_category.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'view_students_notifier.dart';

final studentInfoNotifierProvider =
    ChangeNotifierProvider((ref) => StudentInfoNotifier(ref));

class StudentInfoNotifier extends ChangeNotifier {
  final Ref ref;

  final studentCategory = ValueNotifier<StudentCategory?>(null);

  final showPaymentInfo = ValueNotifier(false);
  final showUploadInfo = ValueNotifier(false);

  StudentInfoNotifier(this.ref);

  void setData() async {
    final studentCat = ref.read(selectedStudentState.state).state;

    if(studentCat == null) return;

    studentCategory.value = studentCat;

    notifyListeners();
  }

  void displayPayment(){
    showPaymentInfo.value = !showPaymentInfo.value;

    if(showPaymentInfo.value){
      showUploadInfo.value = false;
    }

    notifyListeners();
  }

  void displayUpload(){
    showUploadInfo.value = !showUploadInfo.value;

    if(showUploadInfo.value){
      showPaymentInfo.value = false;
    }

    notifyListeners();
  }

  void updateStatus(context, {required UploadedReqEntity document, required bool status}) async {
    document = document.copyWith(verificationStatus: status ? VerificationStatus.verified.name : VerificationStatus.error.name);

    final result = await _saveDataToFirebase(document);

    if(result){
      showSuccess(text: 'Successfully updated', context: context);

      final viewStudentNotifier = ref.read(viewStudentsNotifierProvider);

      viewStudentNotifier.setData().then((value) {
        final students = viewStudentNotifier.studentCategory.value;

        final student = students.firstWhere((element) => element.studentEntity!.uid == studentCategory.value!.studentEntity!.uid, orElse: () => const StudentCategory());

        if(student.studentEntity != null){
          studentCategory.value = student;
          notifyListeners();
        }
      });

      return;
    }

    showError(text: AppStrings.errorText, context: context);
  }

  Future<bool> _saveDataToFirebase(UploadedReqEntity document) async {
    try {
      return await ref.read(updateDataInFireStore(FireStoreParams(
        collectionName: FireStoreCollectionStrings.uploadedRequirements,
        uid: '${document.userID}-${document.requirementID}-${document.id}',
        data: document.toMap(),
      )).future);
    } catch (e, stack) {
      debugPrintStack(stackTrace: stack);
      return false;
    }
  }
}