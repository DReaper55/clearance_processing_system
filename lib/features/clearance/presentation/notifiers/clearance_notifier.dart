import 'package:clearance_processing_system/core/services/new_navigation_services.dart';
import 'package:clearance_processing_system/core/utils/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../fee-management/domain/enitites/fee_entity.dart';
import '../../../fee-management/domain/enitites/requirement_entity.dart';
import '../../../fee-management/presentation/providers/fee_data_provider.dart';
import '../../domain/fee_category.dart';
import '../providers/requirement_data_provider.dart';

final clearanceNotifierProvider =
    ChangeNotifierProvider((ref) => ClearanceNotifier(ref));

final selectedFeeCategory =
StateProvider<FeeCategory?>((ref) => const FeeCategory());

class ClearanceNotifier extends ChangeNotifier {
  final Ref ref;

  final feeCategories = ValueNotifier<List<FeeCategory>>([]);

  final totalFee = ValueNotifier(0.0);

  ClearanceNotifier(this.ref);

  void getFeeCategories() async {
    final fees = await _getFees();
    final requirements = await  _getRequirements();

    for(var fee in fees){
      final foundReq = requirements.where((element) => element.feeID == fee.feeID).toList();

      final newFee = FeeCategory(feeEntity: fee, requirementEntities: foundReq);

      feeCategories.value.add(newFee);
    }

    for (var fee in fees) {
      totalFee.value += double.parse(fee.amount!);
    }

    notifyListeners();
  }

  Future<List<FeeEntity>> _getFees() async {
    final feeRes = await ref.read(feeRepositoryProvider).getFees();

    return feeRes.map((e) => FeeEntity.fromMap(e)).toList();
  }

  Future<List<RequirementEntity>> _getRequirements() async {
    final requirementRes = await ref.read(requirementRepositoryProvider).getRequirements();

    return requirementRes.map((e) => RequirementEntity.fromMap(e)).toList();
  }

  void navigateToRequirementPage(FeeCategory feeCat) {
    ref.read(selectedFeeCategory.state).state = feeCat;

    ref.read(newNavigationService).navigateToNamed(Routes.studentReqPage);
  }

}