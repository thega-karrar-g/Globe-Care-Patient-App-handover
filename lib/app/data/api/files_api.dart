import 'package:dio/dio.dart';

import 'app_urls.dart';
import 'base_api.dart';

class FilesApi extends BaseApi {
  static final _filesApi = FilesApi._internal();

  factory FilesApi() {
    return _filesApi;
  }

  FilesApi._internal();

  var prescriptions =
      AppUrls.getUrl(AppUrls.prescriptions, withExtension: true);

  Future<Response?> getFiles(
      {String id = '', String url = AppUrls.prescriptionUrls}) async {
    try {
      var response = await api.dioGet(url + id);

      return response;
    } catch (e) {
      return null;

      //
    }
  }
}
