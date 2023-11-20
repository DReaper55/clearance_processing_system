import 'dart:io';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class UploadedReqEntity extends Equatable {
  final String? id, imageUrl, verificationStatus, requirementID;
  final String? dateTime;
  final Uint8List? imageFile;


  const UploadedReqEntity({this.dateTime, this.imageFile, this.imageUrl, this.id, this.verificationStatus, this.requirementID});

  UploadedReqEntity.fromMap(Map<dynamic, dynamic> list)
      : requirementID = list["requirementID"],
        verificationStatus = list["verificationStatus"],
        imageFile = list["imageFile"],
        imageUrl = list["imageUrl"],
        dateTime = list["dateTime"],
        id = list["id"];


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "requirementID": requirementID,
      "verificationStatus": verificationStatus,
      "imageUrl": imageUrl,
      "dateTime": dateTime,
      "id": id,
    };
  }

  UploadedReqEntity copyWith(
      {String? requirementID, verificationStatus, imageUrl, dateTime,
        String? id, Uint8List? imageFile}) {
    return UploadedReqEntity(
      requirementID: requirementID ?? this.requirementID,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      imageUrl: imageUrl ?? this.imageUrl,
      imageFile: imageFile ?? this.imageFile,
      dateTime: dateTime ?? this.dateTime,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [
    id, verificationStatus, imageUrl, requirementID, dateTime
  ];
}