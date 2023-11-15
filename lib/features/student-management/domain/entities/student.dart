import 'package:equatable/equatable.dart';

class StudentEntity extends Equatable {
  final String? fullName, uid, email, matric, faculty, department, createdBy;
  final String? dateTime;
  final bool? isSubscribed;


  const StudentEntity({this.dateTime, this.uid, this.fullName, this.email, this.matric, this.faculty, this.department, this.createdBy, this.isSubscribed});

  StudentEntity.fromMap(Map<dynamic, dynamic> list)
      : matric = list["matric"],
        email = list["email"],
        uid = list["uid"],
        dateTime = list["dateTime"],
        fullName = list["fullname"],
        department = list["department"],
        faculty = list["faculty"],
        createdBy = list["createdBy"],
        isSubscribed = list["isSubscribed"];


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "matric": matric,
      "email": email,
      "uid": uid,
      "dateTime": dateTime,
      "fullname": fullName,
      "faculty": faculty,
      "createdBy": createdBy,
      "isSubscribed": isSubscribed,
      "department": department,
    };
  }

  @override
  List<Object?> get props => [
    fullName, email, uid, matric, faculty, department,
    createdBy, isSubscribed, dateTime
  ];
}