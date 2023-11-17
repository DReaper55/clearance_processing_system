import 'package:equatable/equatable.dart';

class PaymentEntity extends Equatable {
  final String? referenceCode, feeID, amount, description;
  final String? dateTime, userID;

  const PaymentEntity({
    this.feeID,
    this.userID,
    this.dateTime,
    this.amount,
    this.description,
    this.referenceCode
  });

  PaymentEntity.fromMap(Map<dynamic, dynamic> list)
      : feeID = list['feeID'],
        dateTime = list['dateTime'],
        amount = list['amount'],
        description = list['description'],
        userID = list['userID'],
        referenceCode = list['referenceCode'];


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "feeID": feeID,
      "userID": userID,
      "amount": amount,
      "description": description,
      "dateTime": dateTime,
      "referenceCode": referenceCode,
    };
  }

  @override
  List<Object?> get props => [
    dateTime,
    userID,
    feeID,
    amount,
    description,
    referenceCode
  ];
}