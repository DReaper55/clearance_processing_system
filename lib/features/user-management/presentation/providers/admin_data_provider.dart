import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/firestore/admin_datasource.dart';

final userRepositoryProvider = Provider<AdminRepository>((ref) => AdminRepository());

final getUsersUseCaseProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final userRepository = ref.read(userRepositoryProvider);
  return await userRepository.getUsers();
});
