import 'dart:convert';

import '../api/payment_api.dart';
import '../models/insurance.dart';
import '../models/requested_payment.dart';

class PaymentRepository {
  static final _paymentRepository = PaymentRepository._internal();

  factory PaymentRepository() {
    return _paymentRepository;
  }

  PaymentRepository._internal();

  final PaymentApi _paymentApi = PaymentApi();

  Future<List<RequestedPayment>> getRequestedPaymentList() async {
    var response = await _paymentApi.getRequestedPayment();

    try{

    var jsonData =response!.data;

    var d = jsonData['data'] as List;

    return d.map((dr) {
      return RequestedPayment.fromJson((dr));
    }).toList();

    }catch(_){
      return [];
    }
  }

  Future<dynamic> setRequestedPaymentStatus(
      {required Map<String, dynamic> body}) async {

    try {
      var response = await _paymentApi.setRequestedPaymentStatus(body: body);

      var jsonData = response!.data;


      return jsonData;
    } catch (_) {
      return {"success": 0};
    }
  }

  Future<List<Insurance>> getInsuranceList() async {
    var response = await _paymentApi.getRequestedPayment();

    try {
      var jsonData = response!.data;

      var d = jsonData['data'] as List;

      return d.map((dr) {
        return Insurance.fromJson((dr));
      }).toList();
    } catch (_) {
      return [];
    }
  }
}
