import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:clearance_processing_system/core/config/exceptions/task_failure.dart';
import 'package:clearance_processing_system/features/register/utils/usecase.dart';

import '../repositories/firestore_repo.dart';


class AddDocument implements UseCase<bool, FireStoreParams> {
  final FireStoreRepo repository;

  AddDocument({required this.repository});

  @override
  Future<Either<TaskFailure, bool>> call(FireStoreParams params) async {
    return await repository.addDocument(params.collectionName!, params.documentId!, params.data!);
  }
}

class UpdateDocument implements UseCase<bool, FireStoreParams> {
  final FireStoreRepo repository;

  UpdateDocument({required this.repository});

  @override
  Future<Either<TaskFailure, bool>> call(FireStoreParams params) async {
    return await repository.updateDocument(params.collectionName!, params.documentId!, params.data!);
  }
}

class DeleteDocument implements UseCase<bool, FireStoreParams> {
  final FireStoreRepo repository;

  DeleteDocument({required this.repository});

  @override
  Future<Either<TaskFailure, bool>> call(FireStoreParams params) async {
    return await repository.deleteDocument(params.collectionName!, params.documentId!);
  }
}

class FireStoreParams extends Equatable {
  final String? collectionName;
  final Map<String, dynamic>? data;
  final String? documentId;
  final String uid;

  const FireStoreParams({
    this.collectionName,
    this.data,
    this.documentId,
    required this.uid,
    });

  FireStoreParams copyWith({
    String? collectionName,
    Map<String, dynamic>? data,
    String? documentId,
    String? inventoryId,
    String? businessType,
    String? uid,
    bool? isCustomer,
}){
    return FireStoreParams(
      uid: uid ?? this.uid,
      collectionName: collectionName ?? this.collectionName,
      data: data ?? this.data,
      documentId: documentId ?? this.documentId
    );
}

  @override
  List<Object?> get props => [
    collectionName,
    data,
    uid,
    documentId,
  ];
}
