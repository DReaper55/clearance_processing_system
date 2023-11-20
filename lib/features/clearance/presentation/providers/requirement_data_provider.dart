import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/firestore/requirement_datasource.dart';

final requirementRepositoryProvider = Provider<RequirementRepository>((ref) => RequirementRepository());

final getRequirementsUseCaseProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final requirementRepository = ref.read(requirementRepositoryProvider);
  return await requirementRepository.getRequirements();
});
