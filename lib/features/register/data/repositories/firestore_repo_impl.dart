import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:clearance_processing_system/core/config/exceptions/task_failure.dart';
import 'package:clearance_processing_system/features/register/data/firebase/online_firebase_db.dart';
import 'package:clearance_processing_system/features/register/domain/repositories/firestore_repo.dart';

class FireStoreRepoImpl implements FireStoreRepo{
  final FirebaseDataSource dataSource;

  FireStoreRepoImpl(this.dataSource);

  @override
  Future<Either<TaskFailure, bool>> addDocument(String collectionName, String documentId, Map<String, dynamic> data) async {
    try {
      bool done = await dataSource.addDocument(collectionName, documentId, data);
      return Right(done);
    } on Exception{
      return Left(FireStoreFailure(message: 'Failed to add document to collection'));
    }
  }

  @override
  Future<Either<TaskFailure, bool>> deleteDocument(String collectionName, String documentId) async {
    try {
      bool done = await dataSource.deleteDocument(collectionName, documentId);
      return Right(done);
    } on Exception{
      return Left(FireStoreFailure(message: 'Failed to delete document'));
    }
  }

  @override
  Future<Either<TaskFailure, Stream<List<DocumentSnapshot<Object?>>>>> listenToCollection(String collectionName) async {
    try {
      Stream<List<DocumentSnapshot<Object?>>> collectionStream = dataSource.listenToCollection(collectionName);
      return Right(collectionStream);
    } on Exception{
      return Left(FireStoreFailure(message: 'Failed to listen to collection'));
    }
  }

  @override
  Future<Either<TaskFailure, bool>> updateDocument(String collectionName, String documentId, Map<String, dynamic> data) async {
    try {
      bool done = await dataSource.updateDocument(collectionName, documentId, data);
      return Right(done);
    } on Exception{
      return Left(FireStoreFailure(message: 'Failed to update document'));
    }
  }

}