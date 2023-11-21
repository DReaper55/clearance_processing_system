import 'package:clearance_processing_system/features/fee-management/domain/enitites/fee_entity.dart';
import 'package:clearance_processing_system/features/student-management/domain/entities/student.dart';
import 'package:clearance_processing_system/features/wallet/domain/enitites/payment.dart';
import 'package:equatable/equatable.dart';

class ClearancePaymentCategory extends Equatable {
  final PaymentEntity? paymentEntity;
  final StudentEntity? studentEntity;
  final FeeEntity? feeEntity;

  const ClearancePaymentCategory({this.studentEntity, this.feeEntity, this.paymentEntity});

  @override
  List<Object?> get props => [ paymentEntity, studentEntity, feeEntity ];
}