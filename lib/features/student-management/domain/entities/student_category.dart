import 'package:clearance_processing_system/features/clearance/domain/entities/uploaded_req_entity.dart';
import 'package:clearance_processing_system/features/fee-management/domain/enitites/requirement_entity.dart';
import 'package:clearance_processing_system/features/student-management/domain/entities/student.dart';
import 'package:clearance_processing_system/features/wallet/domain/enitites/payment.dart';
import 'package:equatable/equatable.dart';

class StudentCategory extends Equatable {
  final StudentEntity? studentEntity;
  final List<PaymentEntity>? paymentEntity;
  final List<RequirementEntity>? requirementEntity;

  const StudentCategory(
      {this.paymentEntity, this.requirementEntity, this.studentEntity});

  @override
  List<Object?> get props => [studentEntity, paymentEntity, requirementEntity];
}
