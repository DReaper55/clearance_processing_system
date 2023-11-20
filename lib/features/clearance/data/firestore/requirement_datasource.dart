import 'package:clearance_processing_system/core/utils/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RequirementRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getRequirements() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await _firestore.collection(FireStoreCollectionStrings.requirements).get();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }
}
