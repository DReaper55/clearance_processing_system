import 'dart:convert';

import 'package:clearance_processing_system/features/fee-management/domain/enitites/paystack_bank.dart';

import 'paystack_bank_client.dart';

abstract class PayStackBankDataSource {
  Future<List<PayStackBankEntity>> getBanks();
  Future<String> verifyAccountNumber({required String accountNumber, required String bankCode});
}

class PayStackBankDataSourceImpl implements PayStackBankDataSource{
  final PayStackBankClient payStackBankClient;

  PayStackBankDataSourceImpl(this.payStackBankClient);

  @override
  Future<List<PayStackBankEntity>> getBanks() async {
    try {
      final response = await payStackBankClient.getBanks();
      var dataMap = jsonDecode(response.body);

      List<PayStackBankEntity> bankList = [];

      if (response.statusCode == 200) {
        List bankMap = dataMap['data'];

        for (var bank in bankMap) {
          bankList.add(PayStackBankEntity.fromJson(bank));
        }
        return bankList;
      } else {
        throw Exception('Error getting banks');
      }
    } catch (e) {
      throw Exception('An error occurred');
    }
  }

  @override
  Future<String> verifyAccountNumber({required String accountNumber, required String bankCode}) async {
    try {
      final response = await payStackBankClient.verifyAccountNumber(accountNumber: accountNumber, bankCode: bankCode);
      var dataMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return dataMap['data']['account_name'];
      } else {
        throw Exception('Error verifying account number');
      }
    } catch (e) {
      throw Exception('An error occurred');
    }
  }

}
