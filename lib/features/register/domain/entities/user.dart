import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? fullName, email, role, faculty, department, createdBy;
  final bool? isSubscribed;


  const User({this.fullName, this.email, this.role, this.faculty, this.department,
    this.createdBy, this.isSubscribed});

  User.fromMap(Map<dynamic, dynamic> list)
      : role = list["role"],
        email = list["email"],
        fullName = list["fullname"],
        department = list["department"],
        faculty = list["faculty"],
        createdBy = list["createdBy"],
        isSubscribed = list["isSubscribed"];


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "role": role,
      "email": email,
      "fullname": fullName,
      "faculty": faculty,
      "createdBy": createdBy,
      "isSubscribed": isSubscribed,
      "department": department,
    };
  }

  @override
  List<Object?> get props => [
    fullName, email, role, faculty, department,
    createdBy, isSubscribed
  ];
}