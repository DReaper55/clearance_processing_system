import 'package:clearance_processing_system/features/fee-management/domain/enitites/fee_entity.dart';
import 'package:clearance_processing_system/features/fee-management/domain/enitites/requirement_entity.dart';
import 'package:equatable/equatable.dart';

import 'uploaded_req_entity.dart';

class FeeCategory extends Equatable {
  final FeeEntity? feeEntity;
  final List<RequirementEntity>? requirementEntities;

  const FeeCategory({this.feeEntity, this.requirementEntities});

  FeeCategory copyWith(
      {FeeEntity? feeEntity,
        List<RequirementEntity>? requirementEntities}) {
    return FeeCategory(
      feeEntity: feeEntity ?? this.feeEntity,
      requirementEntities: requirementEntities ?? this.requirementEntities,
    );
  }

  @override
  List<Object?> get props => [ feeEntity, requirementEntities ];
}