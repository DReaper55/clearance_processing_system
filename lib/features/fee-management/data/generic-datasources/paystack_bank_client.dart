
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:clearance_processing_system/core/utils/keys.dart';

class PayStackBankClient {
  Future<http.Response> getBanks() async {
    Map<String, String> headers = {
      'Authorization': 'Bearer ${dotenv.env[Keys.payStackSk]}',
    };
    var httpClient = http.Client();
    var uri = Uri.https('api.paystack.co', '/bank', {'country': 'nigeria'});
    var response = await httpClient.get(uri, headers: headers);

    httpClient.close();
    return response;
  }

  Future<http.Response> verifyAccountNumber({required String accountNumber, required String bankCode}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer ${dotenv.get(Keys.payStackSk)}'
    };

    var httpClient = http.Client();
    var uri = Uri.https('api.paystack.co', "/bank/resolve",
        {'account_number': accountNumber, 'bank_code': bankCode});
    var response = await httpClient.get(uri, headers: headers);

    httpClient.close();
    return response;
  }
}
