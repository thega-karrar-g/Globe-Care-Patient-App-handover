import 'package:dio/dio.dart';

import 'app_urls.dart';
import 'base_api.dart';

class ServiceApi extends BaseApi {
  static final _serviceApi = ServiceApi._internal();

  factory ServiceApi() => _serviceApi;

  ServiceApi._internal();

  Future<Response?> getServices() async {
    try {
      var response = await api.dioGet(
        AppUrls.services,
      );
      return response;
    } on DioException catch (e) {

      // logger.i(e.message);
      //
    }
    return null;
  }
}
