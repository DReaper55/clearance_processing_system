import 'package:clearance_processing_system/core/config/exceptions/task_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FireStoreRepo {
  Future<Either<TaskFailure, Stream<List<DocumentSnapshot>>>> listenToCollection(String collectionName);
  Future<Either<TaskFailure, bool>> addDocument(String collectionName, String documentId, Map<String, dynamic> data);
  Future<Either<TaskFailure, bool>> updateDocument(
      String collectionName, String documentId, Map<String, dynamic> data);
  Future<Either<TaskFailure, bool>> deleteDocument(String collectionName, String documentId);
}