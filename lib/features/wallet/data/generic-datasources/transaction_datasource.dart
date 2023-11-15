
import 'dart:convert';

import '../../domain/enitites/transaction.dart';
import 'transaction_client.dart';

abstract class TransactionDataSource {
  Future<TransactionEntity> initializeTransaction({required String email,
    required String amount,
    String? subAccountCode});

  Future<TransactionEntity> verifyTransaction({required String reference});

  Future<TransactionEntity> createCharge({required String email, required String amount, String? authCode});
}

class TransactionDataSourceImpl implements TransactionDataSource {
  final TransactionClient transactionClient;

  TransactionDataSourceImpl(this.transactionClient);

  @override
  Future<TransactionEntity> createCharge({required String email, required String amount, String? authCode}) async {
    try {
      final response = await transactionClient.createCharge(
        email: email, amount: amount, authCode: authCode,
      );

      var dataMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        String status = dataMap['data']['status'];
        String reference = dataMap['data']['reference'];

        return TransactionEntity(
          status: status,
          reference: reference,
        );
      } else {
        throw Exception('Error creating payment charge');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  @override
  Future<TransactionEntity> initializeTransaction({required String email, required String amount, String? subAccountCode}) async {
    try {
      final response = await transactionClient.initializeTransaction(
        email: email, amount: amount, subAccountCode: subAccountCode,
      );

      var dataMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        String accessCode = dataMap['data']['access_code'];
        String url = dataMap['data']['authorization_url'];
        String reference = dataMap['data']['reference'];

        return TransactionEntity(
          accessCode: accessCode,
          url: url,
          reference: reference,
        );
      } else {
        throw Exception('Error initiating payment');
      }
    } catch (e) {
      throw Exception('An error occurred');
    }
  }

  @override
  Future<TransactionEntity> verifyTransaction({required String reference}) async {
    try {
      final response = await transactionClient.verifyTransaction(
        reference: reference,
      );

      var dataMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (dataMap['data']['status'] != null) {
          String status = dataMap['data']['status'];
          String reference = dataMap['data']['reference'];
          String authCode = dataMap['data']['authorization']['authorization_code'];

          return TransactionEntity(
            status: status,
            authorizationCode: authCode,
              reference: reference
          );
        } else {
          throw Exception('No status in payload');
        }
      } else {
        throw Exception('Error verifying transaction');
      }
    } catch (e) {
      throw Exception('An error occurred, $e');
    }
  }

}
