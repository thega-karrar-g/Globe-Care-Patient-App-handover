import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'app_urls.dart';
import 'base_api.dart';

class PaymentApi extends BaseApi {
  static final _paymentApi = PaymentApi._internal();

  factory PaymentApi() => _paymentApi;

  PaymentApi._internal();

  Future<Response?> getRequestedPayment() async {
    try {
      var response = await api.dioGet(
        AppUrls.requestedPayment + currentUser!.id,
      );
      return response;
    } on DioException catch (_) {
      //
      return null;
    }
  }

  Future<Response?> setRequestedPaymentStatus(
      { required Map<String, dynamic> body}) async {
    try {
      var response = await api.dioPost(endPath:  AppUrls.paymentChecker.toString(), body: body);
      return response;
    } on DioException catch (_) {
      //
      return null;
    }
  }

  Future<Response?> getInsuranceCompanies() async {
    try {
      var response = await api.dioGet(
        AppUrls.insurance,
      );
      return response;
    } on DioException catch (_) {
      //
      return null;
    }
  }
}
