import 'package:clearance_processing_system/core/services/new_navigation_services.dart';
import 'package:clearance_processing_system/core/utils/routes.dart';
import 'package:clearance_processing_system/features/clearance/domain/uploaded_req_entity.dart';
import 'package:clearance_processing_system/features/clearance/presentation/notifiers/student_req_notifier.dart';
import 'package:clearance_processing_system/features/clearance/presentation/providers/requirement_data_provider.dart';
import 'package:clearance_processing_system/features/clearance/presentation/providers/uploaded_req_data_provider.dart';
import 'package:clearance_processing_system/features/fee-management/domain/enitites/fee_entity.dart';
import 'package:clearance_processing_system/features/fee-management/domain/enitites/requirement_entity.dart';
import 'package:clearance_processing_system/features/fee-management/presentation/providers/fee_data_provider.dart';
import 'package:clearance_processing_system/features/student-management/domain/entities/student.dart';
import 'package:clearance_processing_system/features/wallet/domain/enitites/payment.dart';
import 'package:clearance_processing_system/features/wallet/presentation/providers/transaction_data_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/entities/student_category.dart';
import '../providers/student_data_provider.dart';

final viewStudentsNotifierProvider =
    ChangeNotifierProvider((ref) => ViewStudentsNotifier(ref));

final selectedStudentState =
StateProvider<StudentCategory?>((ref) => const StudentCategory());

class ViewStudentsNotifier extends ChangeNotifier {
  final Ref ref;

  final studentCategory = ValueNotifier<List<StudentCategory>>([]);

  ViewStudentsNotifier(this.ref);

  Future setData() async {
    final students = await _getStudents();
    final payments = await _getAllTransactions();
    final uploads = await _getUploadedRequirements();
    final requirements = await _getRequirements();
    // final fees = await _getFees();

    for(var student in students){
      // Get all student's payments that were for clearance
      final foundPayments = payments.where((element) => element.userID == student.uid && !element.description!.contains('wallet')).toList();

      // Get all the documents the student has uploaded
      // but have not yet been verified
      final foundUploads = uploads.where((element) => element.userID == student.uid && element.verificationStatus == VerificationStatus.pending.name).toList();

      // ....................................................
      // Check if the student has paid for the document to
      // to be verified yet
      // ....................................................

      // Get the requirement linked with the uploaded document

      if(foundUploads.isNotEmpty) {
        final foundReq = requirements.firstWhere((element) =>
        element.requirementID == foundUploads[0].requirementID,
            orElse: () => const RequirementEntity());

        // Use the feeID to check through the student's
        // payments for one matching it
        if (foundReq.feeID != null) {
          final mFoundPay = foundPayments.firstWhere((element) =>
          element.feeID == foundReq.feeID, orElse: () => const PaymentEntity());

          // If a payment is found then record it
          if (mFoundPay.referenceCode != null) {
            for (int i = 0; i < foundUploads.length; i++) {
              foundUploads[i] = foundUploads[i].copyWith(isStudentPaid: true);
            }
          }

          // Else if a payment is not found then record it
          else {
            for (int i = 0; i < foundUploads.length; i++) {
              foundUploads[i] = foundUploads[i].copyWith(isStudentPaid: false);
            }
          }
        }
      }

      // Match every requirement with the corresponding
      // uploaded document
      final List<RequirementEntity> mNewRequirements = [];

      for(var upload in foundUploads){
        final mFoundReq = requirements.firstWhere((element) => element.requirementID == upload.requirementID, orElse: () => const RequirementEntity());

        if(mFoundReq.requirementID != null) {
          mNewRequirements.add(mFoundReq.copyWith(uploadedReqEntity: upload));
        }
      }

      studentCategory.value.add(StudentCategory(
        studentEntity: student,
        paymentEntity: foundPayments,
        requirementEntity: mNewRequirements,
      ));
    }

    notifyListeners();
    return;
  }

  Future<List<StudentEntity>> _getStudents() async {
    final studentRes = await ref.read(studentRepositoryProvider).getStudents();
    return studentRes.map((e) => StudentEntity.fromMap(e)).toList();
  }

  Future<List<PaymentEntity>> _getAllTransactions() async {
    final transactionRes = await ref.read(transactionRepositoryProvider).getAllTransactions();
    return transactionRes.map((e) => PaymentEntity.fromMap(e)).toList();
  }

  Future<List<RequirementEntity>> _getRequirements() async {
    final requirementsRes = await ref.read(requirementRepositoryProvider).getRequirements();
    return requirementsRes.map((e) => RequirementEntity.fromMap(e)).toList();
  }

  Future<List<FeeEntity>> _getFees() async {
    final feesRes = await ref.read(feeRepositoryProvider).getFees();
    return feesRes.map((e) => FeeEntity.fromMap(e)).toList();
  }

  Future<List<UploadedReqEntity>> _getUploadedRequirements() async {
    final uploadedReqRes = await ref.read(uploadedReqRepositoryProvider).getUploadedReqs();
    return uploadedReqRes.map((e) => UploadedReqEntity.fromMap(e)).toList();
  }

  void navigateToStudentInfoPage(StudentCategory studentCategory) {
    ref.read(selectedStudentState.state).state = studentCategory;

    ref.read(newNavigationService).navigateToNamed(Routes.studentInfoPage);
  }
}