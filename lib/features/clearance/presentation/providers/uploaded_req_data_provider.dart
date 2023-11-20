import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/firestore/uploaded_req_datasource.dart';


final uploadedReqRepositoryProvider = Provider<UploadedReqRepository>((ref) => UploadedReqRepository());

final getRequirementsUseCaseProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final uploadedReqRepository = ref.read(uploadedReqRepositoryProvider);
  return await uploadedReqRepository.getUploadedReqs();
});
