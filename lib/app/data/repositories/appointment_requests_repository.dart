

import 'dart:developer';

import 'package:dio/dio.dart';

import '../api/api_keys.dart';
import '../api/app_urls.dart';
import '../api/base_api.dart';
import '../api/request_api.dart';
import '../models/caregiver_contract_model.dart';
import '../models/refund_request_model.dart';
import '../models/request_model.dart';
import '../models/sleep_medicine_model.dart';

class AppointmentRequestsRepository extends BaseApi{
  static final appointmentRequestsRepository = AppointmentRequestsRepository._internal();

  factory AppointmentRequestsRepository() {
    return appointmentRequestsRepository;
  }

  AppointmentRequestsRepository._internal();

  var failResponse= {ApiKeys.responseSuccess:0,ApiKeys.responseMessage:'There is a problem \nour team will fix it asap'};

  Future<List<CaregiverContractModel>> getCaregiverContractRequests({String id = ''}) async {
    try {
      var response = await api.dioGet(AppUrls.caregiverContractRequestList +id);
      if(response ==null){
        return [];
      }
      if (response.data[ApiKeys.responseSuccess] == 1) {
        var d = response.data['data'] as List;
          log(response.data.toString());
        var dd = d.map((dr) {
          return CaregiverContractModel.fromJson((dr));
        }).toList();

        return dd;
      } else {
        return [];
      }
    }on DioException catch (_) {
      // print('err   ***************************  ${e.toString()}');
      return [];
    }
  }





  Future<List<RefundRequestModel>> getRefundRequests({ required String id}) async {
    try {
      var response = await api.dioGet(AppUrls.refundRequestList +id);
      if(response ==null){
        return [];
      }
      if (response.data[ApiKeys.responseSuccess] == 1) {
        var d = response.data['data'] as List;
          // log(response.data.toString());
        var dd = d.map((dr) {
          return RefundRequestModel.fromJson((dr));
        }).toList();

        return dd;
      } else {
        return [];
      }
    }on DioException catch (e) {
      // print('err   ***************************  ${e.message.toString()}');
      return [];
    }
  }



  Future<List<SleepMedicineModel>> getSleepMedicineRequests({required String id}) async {
    try {
      var response = await api.dioGet(AppUrls.sleepMedicineRequestList +id);

      if(response ==null){
        return [];
      }

      if (response.data[ApiKeys.responseSuccess] == 1) {
        var d = response.data['data'] as List;
        //   log(response.data.toString());
        var dd = d.map((dr) {
          return SleepMedicineModel.fromJson((dr));
        }).toList();

        return dd;
      } else {
        return [];
      }
    } catch (e) {
      // print('err   ***************************  ${e.toString()}');
      return [];
    }
  }


  Future<dynamic> updateCaregiverContract(Map<String, dynamic> data) async {
    try {
      var response = await api.dioPost( endPath:  AppUrls.updateCaregiverContract,body: data);
      //
      if(response ==null){
        return failResponse;
      }
      return response.data;
    } catch (_) {
      return failResponse;
    }
  }


  Future<dynamic> requestSleepMedicine(Map<String, dynamic> data) async {
    try {
      var response = await api.dioPost(  endPath:  AppUrls.sleepMedicineRequestAddQuestioner,body: data);
      //
      if(response ==null){
        return failResponse;
      }

      return response.data;
    } catch (_) {
      return failResponse;
    }
  }
  Future<dynamic> requestCaregiverContract(Map<String, dynamic> data) async {
    try {
      var response = await api.dioPost( endPath:  AppUrls.caregiverContractRequestAddQuestioner,body: data);
      //
      if(response ==null){
        return failResponse;
      }
      return response.data;
    } catch (_) {
      return failResponse;
    }
  }


  Future<dynamic> createInstantCon(Map<String, String> data) async {
    try {
      // var response = await _requestService.createInstantCon(data);
      //
      // return response!.data;
    } catch (_) {
      return failResponse;
    }
  }

}
