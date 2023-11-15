import 'package:equatable/equatable.dart';

class FeeEntity extends Equatable {
  final String? title, feeID, postedBy, amount, accountName, accountNumber, bankName, bankCode;
  final String? departmentsToPay;
  final String? dateTime;


  const FeeEntity({this.departmentsToPay, this.bankCode, this.dateTime, this.amount, this.accountName, this.feeID, this.title, this.postedBy, this.accountNumber, this.bankName});

  FeeEntity.fromMap(Map<dynamic, dynamic> list)
      : accountNumber = list["accountNumber"],
        postedBy = list["postedBy"],
        departmentsToPay = list["departmentsToPay"],
        amount = list["amount"],
        feeID = list["feeID"],
        dateTime = list["dateTime"],
        title = list["title"],
        accountName = list["accountName"],
        bankCode = list["bankCode"],
        bankName = list["bankName"];


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "accountNumber": accountNumber,
      "postedBy": postedBy,
      "feeID": feeID,
      "departmentsToPay": departmentsToPay,
      "amount": amount,
      "accountName": accountName,
      "bankCode": bankCode,
      "dateTime": dateTime,
      "title": title,
      "bankName": bankName,
    };
  }

  @override
  List<Object?> get props => [
    title, postedBy, feeID, departmentsToPay, amount, bankCode, accountName, accountNumber, bankName, dateTime
  ];
}