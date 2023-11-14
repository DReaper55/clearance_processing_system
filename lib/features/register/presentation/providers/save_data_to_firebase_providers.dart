import 'package:clearance_processing_system/features/register/data/firebase/online_firebase_db.dart';
import 'package:clearance_processing_system/features/register/domain/repositories/firestore_repo.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/repositories/firestore_repo_impl.dart';
import '../../domain/use-cases/vendor_firestore_usecases.dart';

final fireStoreRepoProvider = Provider<FireStoreRepo>((ref) => FireStoreRepoImpl(FirebaseDataSourceImpl(FirebaseFirestore.instance)));

final addDataToFireStore = FutureProvider.family<bool, FireStoreParams>((ref, params) async {
  final repository = ref.watch(fireStoreRepoProvider);

    params = params.copyWith(documentId: params.uid);

  final result = await AddDocument(repository: repository).call(params);
  return result.fold((l) {
    debugPrint('Exception: $l');
    return false;
  }, (id) {
     return id;
  });
});

final updateDataInFireStore = FutureProvider.family<bool, FireStoreParams>((ref, params) async {
  final repository = ref.watch(fireStoreRepoProvider);

  params = params.copyWith(documentId: params.uid);

  final result = await UpdateDocument(repository: repository).call(params);
  return result.fold((l) {
    debugPrint('Exception: $l');
    return false;
  }, (id) {
    return id;
  });
});