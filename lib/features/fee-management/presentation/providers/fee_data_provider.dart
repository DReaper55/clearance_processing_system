import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/firestore/fee_datasource.dart';

final feeRepositoryProvider = Provider<FeeRepository>((ref) => FeeRepository());

final getFeesUseCaseProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final feeRepository = ref.read(feeRepositoryProvider);
  return await feeRepository.getFees();
});
