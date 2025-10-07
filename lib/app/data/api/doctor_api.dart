import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'app_urls.dart';
import 'base_api.dart';

class DoctorApi extends BaseApi {
  static final _doctorApi = DoctorApi._internal();

  factory DoctorApi() => _doctorApi;

  DoctorApi._internal();

  var doctorsUrl = AppUrls.doctors;

  Future<Response?> getDoctors({String drType = 'TD'}) async {
    try {
      doctorsUrl += drType;
      print(doctorsUrl);
      var response = await api.dioGet(
        doctorsUrl,
      );
      return response;
    } on DioException catch (_) {
      return null;

      //
    }
  }

  Future<Response?> getDoctors1({String drType = 'TD'}) async {


//    print('****************************************  type  ${AppUrls.doctors}$drType');
    try {

      String url=AppUrls.doctors;

      // if(drType =="TD"){

        url+="?role_type=$drType";
      // }

      // print("************************************  $url");
      var response = await api.dioGet(url);
      // print(response.data.toString());
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<Response?> getScheduleList({String id = 'TD'}) async {
    try {
      var response = await api.dioGet(AppUrls.doctorSchedule + id);
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }
}
