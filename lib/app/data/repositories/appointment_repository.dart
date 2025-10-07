import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:globcare/app/data/api/api_keys.dart';
import 'package:globcare/app/data/api/base_api.dart';
import 'package:globcare/app/utils/group_by.dart';

import '../../modules/booking_home_modules/nurse_services/nurse_services_logic.dart';
import '../api/app_urls.dart';
import '../api/appointment_api.dart';
import '../constants/booking_constants.dart';
import '../eunums/enums.dart';
import '../models/count.dart';
import '../models/m_appointment.dart';
import '../models/period.dart';
import '../models/schedule_model.dart';

class AppointmentRepository  extends BaseApi{
  static final _appointmentRepository = AppointmentRepository._internal();

  factory AppointmentRepository() {
    return _appointmentRepository;
  }

  AppointmentRepository._internal();

  final AppointmentApi _appointmentService = AppointmentApi();
  var failResponse= {ApiKeys.responseSuccess:0,ApiKeys.responseMessage:'There is a problem \nour team will fix it asap'};

  Future<List<Appointment>> getAppointmentList() async {
    try {
      var response = await _appointmentService.getAppointments1();
      var d = response!.data['data'];
      var dd = d.map((dr) {
        return Appointment.fromJson((dr));
      }).toList();

      return dd;
    } catch (_) {}

    return [];
  }

  Future<Count> getAppointmentTypesCount({String patientId = ''}) async {
    try {
      var response =
          await _appointmentService.getAppointmentsTypes(patientId: patientId);
      var d = response!.data['data'];

      return Count.fromJson(d);
    } catch (_) {}

    return Count();
  }

  Future<String> getHomeVisitFee() async {
    try {
      var response = await _appointmentService.getPrice();
      var data = response!.data;

var d='0';
if(BookingConstants.paymentAppointmentType == PaymentAppointmentTypes.phy){



  d = data['data']['home_visit_fee_phy'];

}

else{
  d = data['data']['home_visit_fee'];

}


      return d.toString();
    } catch (_) {
      return '0';
    }

  }
  Future<double> getTransportFee() async {
    try {
      var response = await _appointmentService.getPrice();
      var data = response!.data;

var d=0.0;


if(data[ApiKeys.responseSuccess]==1){

  d = double.tryParse( data['data']['home_visit_fee_caregiver'].toString()) ?? 0;

}
else{
  return 0;
}


      return d;
    } catch (_) {
      return 0.0;
    }

  }

  Future<double> getInstantConsPrice() async {
    try {
      var response = await _appointmentService.getPrice(url: AppUrls.pharmacyPrice);
      if(response !=null) {
        var data = response.data;
        // print(response.body);
        var d = data['data']['instant_consultation_pharmacy'];
        // print(d);

        return double.parse(d.toString());
      }
      else{
        return 0;
      }

    } catch (_) {
      return 0;
    }

  }

  Future<List<Period>> getPeriodList({String url = ''}) async {
    try {
      var response = await _appointmentService.getPeriods(url: url);
      var data = response!.data;

      var d = data['data'] as List;
      log(d.toString());
      var dd = d.map((dr) {
        return Period.fromJson((dr));
      }).toList();

      return dd;
    } catch (_) {}

    return [];
  }

  Future<List<Appointment>> getAppointmentList1(
      {String type = 'tele', String patientId = ''}) async {
    var response = await _appointmentService.getAppointments(
        type: type, patientId: patientId);

    try {
      var jsonData = response!.data;
      var d = jsonData['data'] as List;

      log(d.toString());
      var dd = d.map((dr) {
        return Appointment.fromJson((dr));
      }).toList();

      return dd;
    } catch (_) {
      return [];
    }
  }

  Future<dynamic> createAppointment(Map<String, String> data, { Map<String,File> files=const {}  }) async {
   var failResponse= {ApiKeys.responseSuccess:0,ApiKeys.responseMessage:'There is a problem \nour team will fix it asap'};
    try {



      var url = AppUrls.createHHCAppointment;

      if (BookingConstants.appointmentType == 'phy') {
        url =  AppUrls.createAppointmentPhysiotherapy;
      }
      if (BookingConstants.appointmentType == 'hvd') {
        url =  AppUrls.createAppointmentHVD;
      }

      if (BookingConstants.appointmentType == 'tele') {
        url =  AppUrls.createAppointment;
      }
      if (BookingConstants.appointmentType == 'caregiver') {
        url = AppUrls.requestCaregiver;
      }
      if (BookingConstants.appointmentType == 'sleep') {
        url = AppUrls.requestSleepMedicine;
      }
      if (BookingConstants.appointmentType == 'pcr') {
        url =  AppUrls.createAppointmentPcr;
      }

      print("**********************   url: $url");

      var response = await api.dioPost(endPath: url,  body: data,files: files);

      // logger.e(response!.data);
      // logger.e(response.statusCode);
      if(response ==null){
        return failResponse;
      }

      if(response.statusCode ==200){

        return response.data;


      }
      else{
        return failResponse;

      }

    }on DioException  catch (e) {


      logger.e(e.response!.statusCode);
      logger.e(e.response!.data);
      logger.e(e.toString());
      return failResponse;
    }
  }


  Future<dynamic> checkDiscount(Map<String, String> data,
      ) async {

    // try {
      var response = await _appointmentService.appointmentCheckDiscount(data,);

      return response!.data;
    // } catch (_) {
    //   return {ApiKeys.responseSuccess:0};
    // }
  }


  Future<dynamic> setPaymentStatus(Map<String, dynamic> data,
      {String url = AppUrls.setPaymentStatus}) async {

    try {
      var response = await _appointmentService.setPaymentStatus(data, url: url);


      return response!.data;
    } catch (_) {
      return failResponse;
    }
  }

  Future<dynamic> requestCancelAppointment(Map<String, String> data) async {

    try {
      var response = await _appointmentService.requestCancelAppointment(data);


      return response!.data;
    } catch (_) {
      return failResponse;
    }
  }

  Future<String> requestSleepMedicine(data) async {
    var response = await _appointmentService.requestSleepMedicine(data);

    var success = response!.data!['success'] as int;

    var msg = '';
    if (success == 1) {
      msg = '${response.data!['data']['message']}';
    } else {
      msg = msg = '${response.data!['message']}';
    }

    return msg;
  }

  Future<List<ScheduleModel>> getPCRPeriodList({String url = ''}) async {
    try {
      var response =
          await _appointmentService.getPeriods(url: AppUrls.periodsPCR);
      var data = response!.data;

      var d = data['data'] as List;
      final releaseDateMap = d.groupByDate((m) => m['date']);

      List<ScheduleModel> sch = [];

      for (var element in releaseDateMap.keys) {
        var t = releaseDateMap[element]!
            .map((e) => e['hour'].toString().replaceAll('.0', ':00'))
            .toList();

        sch.add(ScheduleModel(date: DateTime.parse(element), times: t));
      }

      return sch;
    } catch (_) {}

    return [];
  }

  var d = [];
}
