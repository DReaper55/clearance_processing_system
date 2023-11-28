import 'package:clearance_processing_system/features/fee-management/domain/enitites/fee_entity.dart';
import 'package:clearance_processing_system/features/fee-management/domain/enitites/requirement_entity.dart';
import 'package:equatable/equatable.dart';

class FeeCategory extends Equatable {
  final FeeEntity? feeEntity;
  final List<RequirementEntity>? requirementEntities;
  final bool? isPaid;

  const FeeCategory({this.feeEntity, this.requirementEntities, this.isPaid});

  FeeCategory copyWith(
      {FeeEntity? feeEntity,
        bool? isPaid,
        List<RequirementEntity>? requirementEntities}) {
    return FeeCategory(
      feeEntity: feeEntity ?? this.feeEntity,
      isPaid: isPaid ?? this.isPaid,
      requirementEntities: requirementEntities ?? this.requirementEntities,
    );
  }

  @override
  List<Object?> get props => [ feeEntity, isPaid, requirementEntities ];
}