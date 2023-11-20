import 'package:equatable/equatable.dart';

class StudentEntity extends Equatable {
  final String? fullName, uid, email, matric, faculty, department, createdBy;
  final String? dateTime;
  final String? cashInWallet;
  final bool? isSubscribed;


  const StudentEntity({this.dateTime, this.cashInWallet, this.uid, this.fullName, this.email, this.matric, this.faculty, this.department, this.createdBy, this.isSubscribed});

  StudentEntity.fromMap(Map<dynamic, dynamic> list)
      : matric = list["matric"],
        email = list["email"],
        uid = list["uid"],
        cashInWallet = list["cashInWallet"],
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
      "cashInWallet": cashInWallet,
      "dateTime": dateTime,
      "fullname": fullName,
      "faculty": faculty,
      "createdBy": createdBy,
      "isSubscribed": isSubscribed,
      "department": department,
    };
  }

  StudentEntity copyWith(
      {String? matric, email, uid, cashInWallet, dateTime,
        String? fullName, isSubscribed, createdBy, department, faculty}) {
    return StudentEntity(
      matric: matric ?? this.matric,
      email: email ?? this.email,
      uid: uid ?? this.uid,
      cashInWallet: cashInWallet ?? this.cashInWallet,
      dateTime: dateTime ?? this.dateTime,
      isSubscribed: isSubscribed ?? this.isSubscribed,
      createdBy: createdBy ?? this.createdBy,
      department: department ?? this.department,
      faculty: faculty ?? this.faculty,
      fullName: fullName ?? this.fullName,
    );
  }

  @override
  List<Object?> get props => [
    fullName, email, uid, cashInWallet, matric, faculty, department,
    createdBy, isSubscribed, dateTime
  ];
}