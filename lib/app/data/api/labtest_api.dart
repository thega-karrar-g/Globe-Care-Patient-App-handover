import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'app_urls.dart';
import 'base_api.dart';

class LabTestApi extends BaseApi {
  static final _labTestApi = LabTestApi._internal();

  factory LabTestApi() {
    return _labTestApi;
  }

  LabTestApi._internal();

  var labTests = AppUrls.getUrl(AppUrls.labTests, withExtension: true);

  //var labTests = AppUrls.labTests;

  Future<Response?> getLabTest() async {
    try {
      var response = await api.dioGet(labTests);

      return response;
    } catch (e) {
      return null;

      //
    }
  }

  Future<Response?> getlabTest1() async {
    try {
      var response = await api.dioGet(labTests);

      return response;
    } catch (e) {
      return null;

      //
    }
  }
}
