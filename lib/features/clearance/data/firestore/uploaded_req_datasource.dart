import 'package:clearance_processing_system/core/utils/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadedReqRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getUploadedReqs() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await _firestore.collection(FireStoreCollectionStrings.uploadedRequirements).get();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }
}
