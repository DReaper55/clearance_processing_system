import 'package:clearance_processing_system/core/utils/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TransactionRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getTransactions() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await _firestore
        .collection(FireStoreCollectionStrings.transactions)
        .where('userID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }
}
