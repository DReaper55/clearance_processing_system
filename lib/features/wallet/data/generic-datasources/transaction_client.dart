import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:clearance_processing_system/core/utils/keys.dart';

class TransactionClient {
  Future<http.Response> initializeTransaction({
    required String email,
    required String amount,
    String? subAccountCode
  }) async {
    amount = "${double.parse(amount) * 100}";

    Map bodyData = {
      "email": email,
      'channels': ['card'],
      "amount": amount
    };
    if (subAccountCode != null) {
      bodyData.addAll({'subaccount': subAccountCode});
    }

    String body = jsonEncode(bodyData);

    Map<String, String> headers = {
      'Authorization': 'Bearer ${dotenv.env[Keys.payStackSk]}',
      'Content-Type': 'application/json'
    };
    var httpClient = http.Client();
    var uri = Uri.https('api.paystack.co', '/transaction/initialize');
    var response = await httpClient.post(uri, headers: headers, body: body);

    httpClient.close();

    return response;
  }

  Future<http.Response> verifyTransaction({required String reference}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer sk_test_547631aa8507cfa5841d9d608e7fd832687b92f7'
    };

    /*Map<String, String> headers = {
      'Authorization': 'Bearer ${dotenv.env[Keys.payStackSk]}'
    };*/

    var httpClient = http.Client();
    var uri = Uri.https('api.paystack.co', '/transaction/verify/$reference');
    var response = await httpClient.get(uri, headers: headers);

    httpClient.close();

    return response;
  }

  Future<http.Response> createCharge({required String email, required String amount, String? authCode}) async {
    amount = "${double.parse(amount) * 100}";
    Map<String, dynamic> bodyData = {"email": email, "amount": amount};

    if (authCode != null) {
      bodyData.addAll({'authorization_code': authCode});
    }

    String body = jsonEncode(bodyData);

    Map<String, String> headers = {
      'Authorization': 'Bearer ${dotenv.env[Keys.payStackSk]}',
      'Content-Type': 'application/json'
    };
    var httpClient = http.Client();
    var uri = Uri.https('api.paystack.co', '/charge');
    var response = await httpClient.post(uri, headers: headers, body: body);

    httpClient.close();

    return response;
  }

}
