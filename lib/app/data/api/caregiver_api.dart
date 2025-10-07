import 'package:dio/dio.dart';
import '../../base_controller/base_controller.dart';
import 'app_urls.dart';
import 'base_api.dart';
import 'package:http/http.dart' as http;

class CaregiverApi extends BaseApi {
  static final _serviceApi = CaregiverApi._internal();

  factory CaregiverApi() => _serviceApi;

  CaregiverApi._internal();

  Future<Response?> getServices() async {
    try {
      var response = await api.dioGet(AppUrls.services,);
      return response;
    } on DioException catch (_) {

      //
    }
    return null;
  }


  Future<Response?> getVitalList() async {
    try {
      var response = await api.dioGet(AppUrls.getVitalSigns+BaseController.recordId.toString(),);
      return response;
    } on DioException catch (_) {

      //
    }
    return null;
  }
  Future<Response?> getObservationList() async {
    try {
      var response = await api.dioGet(AppUrls.getObservationList+BaseController.recordId.toString(),);
      return response;
    } on DioException catch (_) {

      //
    }
    return null;
  }


  Future<Response?> getPainPresentList() async {
    try {
      var response = await api.dioGet(AppUrls.getPainPresent+BaseController.recordId.toString(),);
      return response;
    } on DioException catch (_) {

      //
    }
    return null;
  }
  Future<Response?> getPrescribedMedicineList() async {
    try {
      var response = await api.dioGet(AppUrls.getPrescribedMedicine+BaseController.recordId.toString(),);
      return response;
    } on DioException catch (_) {

      //
    }
    return null;
  }
  Future<Response?> getPrescribedMedicineTimesList({String medicineId=''}) async {
    try {
      var response = await api.dioPost( endPath:  AppUrls.getPrescribedMedicineTimes,body: {'medicine_id':medicineId,'record_id':BaseController.recordId.toString()});
      return response;
    } on DioException catch (_) {

      //
    }
    return null;
  }

  //getRecordFile
  Future<Response?> getRecordFile(String patientId) async {
    try {
      var response = await api.dioGet(AppUrls.getRecordFile+patientId);
      return response;
    } on DioException catch (_) {

      //
    }
    return null;
  }
  Future<Response?> getMedicineSlots() async {
    try {
      var response = await api.dioGet(AppUrls.getMedicineSlots+BaseController.recordId.toString(),);
      return response;
    } on DioException catch (_) {

      //
    }
    return null;
  }


  Future<Response?> addPainPresent(Map<String, dynamic> data) async {
    try {
      var response = await api.dioPost( endPath:  AppUrls.addPain.toString(),body: data);
      return response;
    } on DioException catch (_) {

      //
    }
    return null;
  }


  Future<Response?> addVital(Map<String, dynamic> data) async {
    //try {
      var response = await api.dioPost( endPath:  AppUrls.addVital,body: data);
      return response;
    // } on DioException catch (_) {
    //
    //   //
    // }
    // return null;
  }
  Future<Response?> updateMedicineStatus(Map<String, dynamic> data) async {
    //try {
      var response = await api.dioPost( endPath:  AppUrls.updateMedicineState,body: data);
      return response;
    // } on DioException catch (_) {
    //
    //   //
    // }
    // return null;
  }



  Future<Response?> addObservation(Map<String, dynamic> data) async {
    //try {
      var response = await api.dioPost( endPath:  AppUrls.addObservation,body: data);
      return response;
    // } on DioException catch (_) {
    //
    //   //
    // }
    // return null;
  }
}
