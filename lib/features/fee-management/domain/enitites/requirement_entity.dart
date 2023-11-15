import 'package:equatable/equatable.dart';

class RequirementEntity extends Equatable {
  final String? title, feeID, postedBy, description, requirementID;
  final String? dateTime;


  const RequirementEntity({this.dateTime, this.description, this.feeID, this.title, this.postedBy, this.requirementID});

  RequirementEntity.fromMap(Map<dynamic, dynamic> list)
      : requirementID = list["requirementID"],
        postedBy = list["postedBy"],
        feeID = list["feeID"],
        dateTime = list["dateTime"],
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

  @override
  List<Object?> get props => [
    title, postedBy, feeID, description, requirementID, dateTime
  ];
}