import 'package:equatable/equatable.dart';

class FeeEntity extends Equatable {
  final String? title, feeID, postedBy, accountName, accountNumber, bankName, bankCode;
  final String? dateTime;


  const FeeEntity({this.bankCode, this.dateTime, this.accountName, this.feeID, this.title, this.postedBy, this.accountNumber, this.bankName});

  FeeEntity.fromMap(Map<dynamic, dynamic> list)
      : accountNumber = list["accountNumber"],
        postedBy = list["postedBy"],
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
      "accountName": accountName,
      "bankCode": bankCode,
      "dateTime": dateTime,
      "title": title,
      "bankName": bankName,
    };
  }

  @override
  List<Object?> get props => [
    title, postedBy, feeID, bankCode, accountName, accountNumber, bankName, dateTime
  ];
}