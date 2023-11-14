import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirebaseDataSource {
  Stream<List<DocumentSnapshot>> listenToCollection(String collectionName);
  Future<bool> addDocument(String collectionName, String documentId, Map<String, dynamic> data);
  Future<bool> updateDocument(
      String collectionName, String documentId, Map<String, dynamic> data);
  Future<bool> deleteDocument(String collectionName, String documentId);
}

class FirebaseDataSourceImpl implements FirebaseDataSource {
  final FirebaseFirestore fireStore;

  FirebaseDataSourceImpl(this.fireStore);

  @override
  Stream<List<DocumentSnapshot>> listenToCollection(String collectionName) {
    return fireStore
        .collection(collectionName)
        .snapshots()
        .asyncMap((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.toList(growable: false);
      } else {
        throw Exception('No documents found in the collection');
      }
    }).handleError((error) {
      throw Exception('Failed to listen to collection: $error');
    });
  }

  @override
  Future<bool> addDocument(
      String collectionName, String documentId, Map<String, dynamic> data) async {
    try {
      // DocumentReference<Map<String, dynamic>> ref =
      // await fireStore.collection(collectionName).add(data);

      final document = fireStore.collection(collectionName);
      document.doc(documentId).set(data);
      return true;
    } catch (e) {
      throw Exception('Failed to add document: $e');
    }
  }

  @override
  Future<bool> updateDocument(
      String collectionName, String documentId, Map<String, dynamic> data) async {
    try {
      await fireStore
          .collection(collectionName)
          .doc(documentId)
          .update(data);
      return true;
    } catch (e) {
      throw Exception('Failed to update document: $e');
    }
  }

  @override
  Future<bool> deleteDocument(String collectionName, String documentId) async {
    try {
      await fireStore.collection(collectionName).doc(documentId).delete();
      return true;
    } catch (e) {
      throw Exception('Failed to delete document: $e');
    }
  }
}
