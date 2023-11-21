import 'package:http/http.dart' as http;

import 'package:clearance_processing_system/core/utils/strings.dart';
import 'package:clearance_processing_system/features/clearance/domain/fee_category.dart';
import 'package:clearance_processing_system/features/clearance/domain/uploaded_req_entity.dart';
import 'package:clearance_processing_system/features/register/domain/use-cases/vendor_firestore_usecases.dart';
import 'package:clearance_processing_system/features/register/presentation/providers/save_data_to_firebase_providers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nanoid/nanoid.dart';

import '../providers/uploaded_req_data_provider.dart';
import 'clearance_notifier.dart';
import 'firebase_storage_notifier.dart';

final studentReqNotifierProvider =
    ChangeNotifierProvider((ref) => StudentReqNotifier(ref));

enum VerificationStatus { pending, verified, error }

class StudentReqNotifier extends ChangeNotifier {
  final Ref ref;

  final feeCat = ValueNotifier<FeeCategory>(const FeeCategory());

  StudentReqNotifier(this.ref);

  void setData() async {
    final mFeeCat = ref.read(selectedFeeCategory.state).state;

    if(mFeeCat == null || mFeeCat.requirementEntities == null) return;

    feeCat.value = mFeeCat;
    notifyListeners();

    final uploadedReqs = await getUploadedRequirements();

    if(uploadedReqs.isEmpty) return;
    if(feeCat.value.requirementEntities == null || feeCat.value.requirementEntities!.isEmpty) return;

    for(int i = 0; i < feeCat.value.requirementEntities!.length; i++){
      final foundReq = uploadedReqs.firstWhere((element) => element.requirementID == feeCat.value.requirementEntities![i].requirementID, orElse: () => const UploadedReqEntity());

      if(foundReq.id != null){
        // final mFoundReq = foundReq.copyWith(imageFile: await loadImage(foundReq.imageUrl!));

        feeCat.value.requirementEntities![i] = feeCat.value.requirementEntities![i].copyWith(uploadedReqEntity: foundReq);
      }
    }

    notifyListeners();
  }

  Future<List<UploadedReqEntity>> getUploadedRequirements() async {
    final uploadedReq = await ref.read(uploadedReqRepositoryProvider).getUploadedReqs();

    return uploadedReq.map((e) => UploadedReqEntity.fromMap(e)).toList();
  }

  void pickFile(String requirementID) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if(result != null){
      final foundReq = feeCat.value.requirementEntities!.firstWhere((element) => element.requirementID == requirementID);
      int index = feeCat.value.requirementEntities!.indexOf(foundReq);

      UploadedReqEntity uploadedReq = UploadedReqEntity(
        dateTime: DateTime.now().toString(),
        requirementID: requirementID,
        userID: FirebaseAuth.instance.currentUser!.uid,
        id: nanoid(6),
        imageFile: result.files.first.bytes!,
        verificationStatus: VerificationStatus.pending.name,
      );

      if(foundReq.uploadedReqEntity != null){
        uploadedReq = foundReq.uploadedReqEntity!.copyWith(imageFile: result.files.first.bytes!);
      }

      final newReq = foundReq.copyWith(uploadedReqEntity: uploadedReq);

      feeCat.value.requirementEntities![index] = newReq;

      notifyListeners();

      _uploadDocumentToFirebase(uploadedReq);
    }
  }

  void _uploadDocumentToFirebase(UploadedReqEntity uploadedReq) async {
    String url = await ref.read(firebaseStorageNotifierProvider).uploadImage(uploadedReq.imageFile!, prefixPath: 'uploads/${uploadedReq.requirementID}/${uploadedReq.id}');

    uploadedReq = uploadedReq.copyWith(imageUrl: url);

    _saveDataToDatabase(uploadedReq);
  }

  Future<bool> _saveDataToDatabase(UploadedReqEntity uploadedReq) async {
    String userUid = FirebaseAuth.instance.currentUser!.uid;

    try {
      return await ref.read(addDataToFireStore(FireStoreParams(
        collectionName: FireStoreCollectionStrings.uploadedRequirements,
        uid: '$userUid-${uploadedReq.requirementID}-${uploadedReq.id}',
        data: uploadedReq.toMap(),
      )).future);
    } catch (e, stack) {
      debugPrintStack(stackTrace: stack);
      return false;
    }
  }

  Future<Uint8List> loadImage(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return Uint8List.fromList(response.bodyBytes);
      } else {
        // Handle error, e.g., image not found
        print('Failed to load image: ${response.statusCode}');
        return Uint8List(0);
      }
    } catch (error) {
      // Handle network error
      print('Network error: $error');
      throw Exception(error);
    }
  }
}