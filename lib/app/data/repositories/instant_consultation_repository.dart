
import 'package:dio/dio.dart';

import '../api/api_keys.dart';
import '../api/app_urls.dart';
import '../api/base_api.dart';
import '../api/request_api.dart';
import '../models/request_model.dart';

class InstantConsultationRepository extends BaseApi{
  static final instantConsultationRepository = InstantConsultationRepository._internal();

  factory InstantConsultationRepository() {
    return instantConsultationRepository;
  }
  var failResponse= {ApiKeys.responseSuccess:0,ApiKeys.responseMessage:'There is a problem \nour team will fix it asap'};

  InstantConsultationRepository._internal();

  final RequestApi _requestService = RequestApi();

  Future<List<RequestModel>> getRequestList({String id = ''}) async {
    try {
      var response = await _requestService.getRequests(id: id);

      if (response!.data[ApiKeys.responseSuccess] == 1) {
        var d = response.data['data'] as List;
        //   log(response.data.toString());
        var dd = d.map((dr) {
          return RequestModel.fromJson((dr));
        }).toList();

        return dd;
      } else {
        return [];
      }
    } catch (e) {
      print('err   ***************************  ${e.toString()}');
      return [];
    }
  }

  Future<dynamic> updateFcmToken(Map<String, String> data) async {

    try {
      var response = await _requestService.updateFcmToken(data);


      return response!.data;
    } catch (_) {
      return failResponse;
    }
  }
  Future<dynamic> setPaymentStatus(Map<String, String> data) async {

    try {

      var response = await _requestService.setPaymentStatus(data);

      return response!.data;
    } catch (_) {
      return failResponse;
    }
  }

  Future<dynamic> createInstantCon(Map<String, String> data) async {
    try {
      var response = await api.dioPost(
        endPath:
        AppUrls.createInstantCon,
        body: data,
      );

      // logger.i(response);


      if(response ==null){
        return;
      }

      if(response.statusCode ==200){

        return response.data;}
      else{
        return failResponse;
      }    }on DioException catch (e) {


      logger.e(e.message);
      return failResponse;
    }
  }
  Future<dynamic> checkDiscountCode(Map<String, String> data) async {
    try {
      print(data);
      var response = await api.dioPost( endPath:  AppUrls.checkDiscountCode, body: data,);

      if(response ==null){
        return;
      }

      if(response.statusCode ==200){

      return response.data;}
      else{
        return failResponse;
      }


    } catch (_) {
      return failResponse;
    }
  }



  Future<dynamic> rateConsultation(Map<String, String> data) async {

    try {
      var response = await _requestService.rateConsultation(data);


      return response!.data;
    } catch (_) {
      return failResponse;
    }
  }
}
