import 'package:get/get.dart';

import 'app_urls.dart';

class HomeProvider extends GetConnect {
  static const String token = 'f17be66bfacda572e49d36ef456281d2369b67bb';

  final header = {
    'token': token,
    // 'content-type':'Application/json',
    // 'Accept':'Application/Json',
  };

  @override
  void onInit() {
    // All request will pass to jsonEncode so CasesModel.fromJson()
    httpClient.baseUrl = AppUrls.baseUrl;
    // baseUrl = 'https://api.covid19api.com'; // It define baseUrl to
    // Http and websockets if used with no [httpClient] instance

    //Autenticator will be called 3 times if HttpStatus is
    //HttpStatus.unauthorized
    httpClient.maxAuthRetries = 3;
  }

  Future<Response> httpPost(String endPath, {Map<String, dynamic>? body}) {
    return httpClient.post(endPath, body: body, headers: header);
  }

  Future<Response> httpGet(String endPath) {
    return httpClient.get(AppUrls.baseUrl + endPath, headers: header);
  }
}
