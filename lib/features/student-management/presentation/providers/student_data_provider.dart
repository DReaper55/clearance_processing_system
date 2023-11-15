import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/firestore/student_datasource.dart';

final studentRepositoryProvider = Provider<StudentRepository>((ref) => StudentRepository());

final getStudentsUseCaseProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final studentRepository = ref.read(studentRepositoryProvider);
  return await studentRepository.getStudents();
});
