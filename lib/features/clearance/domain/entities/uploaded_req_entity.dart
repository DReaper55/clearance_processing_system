import 'dart:io';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class UploadedReqEntity extends Equatable {
  final String? id, imageUrl, verificationStatus, requirementID, userID;
  final String? dateTime;
  final bool? isStudentPaid;
  final Uint8List? imageFile;


  const UploadedReqEntity({this.dateTime, this.isStudentPaid, this.imageFile, this.userID, this.imageUrl, this.id, this.verificationStatus, this.requirementID});

  UploadedReqEntity.fromMap(Map<dynamic, dynamic> list)
      : requirementID = list["requirementID"],
        verificationStatus = list["verificationStatus"],
        userID = list["userID"],
        isStudentPaid = list["isStudentPaid"],
        imageFile = list["imageFile"],
        imageUrl = list["imageUrl"],
        dateTime = list["dateTime"],
        id = list["id"];


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "requirementID": requirementID,
      "verificationStatus": verificationStatus,
      "userID": userID,
      "imageUrl": imageUrl,
      "dateTime": dateTime,
      "id": id,
    };
  }

  UploadedReqEntity copyWith(
      {String? requirementID, userID, verificationStatus, imageUrl, dateTime,
        String? id, bool? isStudentPaid, Uint8List? imageFile}) {
    return UploadedReqEntity(
      requirementID: requirementID ?? this.requirementID,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      userID: userID ?? this.userID,
      isStudentPaid: isStudentPaid ?? this.isStudentPaid,
      imageUrl: imageUrl ?? this.imageUrl,
      imageFile: imageFile ?? this.imageFile,
      dateTime: dateTime ?? this.dateTime,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [
    id, verificationStatus, imageUrl, userID, requirementID, dateTime
  ];
}