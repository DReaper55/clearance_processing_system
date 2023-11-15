import 'package:equatable/equatable.dart';

class TransactionEntity extends Equatable {
  final String? url, accessCode, reference;
  final String? status, authorizationCode;

  const TransactionEntity({
    this.reference,
    this.accessCode,
    this.authorizationCode,
    this.status,
    this.url
});

  TransactionEntity.fromMap(Map<dynamic, dynamic> list)
      :reference = list['reference'],
        accessCode = list['accessCode'],
        status = list['status'],
        authorizationCode = list['authorizationCode'],
        url = list['url'];


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "reference": reference,
      "accessCode": accessCode,
      "authorizationCode": authorizationCode,
      "status": status,
      "url": url,
    };
  }

  @override
  List<Object?> get props => [
    reference,
    status,
    authorizationCode,
    accessCode,
    url
  ];
}