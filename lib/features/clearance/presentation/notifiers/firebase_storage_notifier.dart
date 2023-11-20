import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final firebaseStorageNotifierProvider =
    ChangeNotifierProvider((ref) => FirebaseStorageNotifier(ref));

class FirebaseStorageNotifier extends ChangeNotifier {
  final Ref ref;

  FirebaseStorageNotifier(this.ref);

  Future<String> uploadImage(Uint8List image, {String? prefixPath}) async {
    prefixPath = prefixPath ?? 'profileImage';

    Reference ref =
    FirebaseStorage.instance.ref().child(prefixPath);
    await ref.putData(image);
    String imageUrl = await ref.getDownloadURL();
    return imageUrl;
  }

  Future<void> deleteFilesFromStorage({String? imageUrl})async {
    if(imageUrl != null){
      _deleteFile(imageUrl);
    }
  }

  _deleteFile(String url) async {
    final reference = FirebaseStorage.instance.refFromURL(url);

    try {
      await reference.delete();
    } catch (error){
      print('Error deleting file: $url - $error');
    }
  }
}