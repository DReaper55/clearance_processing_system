import 'package:clearance_processing_system/features/clearance/domain/entities/uploaded_req_entity.dart';
import 'package:equatable/equatable.dart';

class RequirementEntity extends Equatable {
  final String? title, feeID, postedBy, description, requirementID;
  final String? dateTime;
  final UploadedReqEntity? uploadedReqEntity;


  const RequirementEntity({this.dateTime,this.uploadedReqEntity,  this.description, this.feeID, this.title, this.postedBy, this.requirementID});

  RequirementEntity.fromMap(Map<dynamic, dynamic> list)
      : requirementID = list["requirementID"],
        postedBy = list["postedBy"],
        feeID = list["feeID"],
        dateTime = list["dateTime"],
        uploadedReqEntity = list["uploadedReqEntity"],
        title = list["title"],
        description = list["description"];


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "requirementID": requirementID,
      "postedBy": postedBy,
      "feeID": feeID,
      "description": description,
      "dateTime": dateTime,
      "title": title,
    };
  }

  RequirementEntity copyWith(
      {String? requirementID, postedBy, feeID, description, dateTime,
        String? title, UploadedReqEntity? uploadedReqEntity}) {
    return RequirementEntity(
      requirementID: requirementID ?? this.requirementID,
      postedBy: postedBy ?? this.postedBy,
      feeID: feeID ?? this.feeID,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      uploadedReqEntity: uploadedReqEntity ?? this.uploadedReqEntity,
      title: title ?? this.title,
    );
  }

  @override
  List<Object?> get props => [
    title, postedBy, feeID, description, requirementID, dateTime
  ];
}