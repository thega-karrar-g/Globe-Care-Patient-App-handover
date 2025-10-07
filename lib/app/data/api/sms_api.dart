import 'package:dio/dio.dart';

import 'app_urls.dart';
import 'base_api.dart';

class SMSApi extends BaseApi {
  static final _smsApi = SMSApi._internal();

  factory SMSApi() {
    return _smsApi;
  }

  SMSApi._internal();

  Future<Response?> sendSMS({ required Map<String, dynamic> body}) async {
    // try {
    var response = await api.dioPost(endPath:  AppUrls.sendSms, body: body);

    return response;
    // } catch (e) {
    //   return null;
    //
    //   //
    // }
  }
}
