import 'package:clearance_processing_system/core/utils/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FeeRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getFees() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await _firestore.collection(FireStoreCollectionStrings.fees).get();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }
}
