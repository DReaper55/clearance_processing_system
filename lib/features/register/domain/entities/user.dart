import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? fullName, uid, email, role, faculty, department, createdBy;
  final String? dateTime;
  final bool? isSubscribed;


  const UserEntity({this.dateTime, this.uid, this.fullName, this.email, this.role, this.faculty, this.department, this.createdBy, this.isSubscribed});

  UserEntity.fromMap(Map<dynamic, dynamic> list)
      : role = list["role"],
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
      "role": role,
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
    fullName, email, uid, role, faculty, department,
    createdBy, isSubscribed, dateTime
  ];
}