import 'dart:math';

import 'package:dio/dio.dart' ;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:globcare/app/base_controller/base_controller.dart';
// import 'package:http/http.dart' as http;

import 'app_urls.dart';
import 'base_api.dart';

class AppointmentApi extends BaseApi {
  static final _appointmentApi = AppointmentApi._internal();

  factory AppointmentApi() {
    return _appointmentApi;
  }

  AppointmentApi._internal();


  var appointment = (AppUrls.teleAppointments);
  var appointmentCount = (AppUrls.appointmentsCount);

  Future<Response?> getAppointments(
      {String type = 'tele', String patientId = ''}) async {
    try {
      String url = AppUrls.teleAppointments;
      switch (type) {
        case 'hhc':
          {
            url = AppUrls.hhcAppointments;
          }
          break;
        case 'tele':
          {
            url = AppUrls.teleAppointments;
          }
          break;

        case 'phy':
          {
            url = AppUrls.physiotherapyAppointments;
          }
          break;

        case 'hvd':
          {
            url = AppUrls.hvdAppointments;
          }
          break;

        case 'pcr':
          {
            url = AppUrls.pcrAppointments;
          }
          break;

        default:
          {
            url = AppUrls.teleAppointments;
          }
      }
      var id = patientId.isNotEmpty ? patientId : currentUser!.id;
      var response = await api.dioGet(url + id);

      return response;
    } catch (e) {
      //
      return null;
    }
  }

  Future<Response?> getAppointments1() async {
    try {
      var response = await api.dioGet(appointment);

      return response;
    } catch (e) {
      return null;

      //
    }
  }

  Future<Response?> getAppointmentsTypes({String patientId = ''}) async {
    try {
      var response = await api.dioGet(appointmentCount + patientId);

      return response;
    } catch (e) {
      return null;

      //
    }
  }

  Future<Response?> getPrice({String url = AppUrls.homeVisitFee}) async {
    try {
    var response = await api.dioGet(url);

    return response;
    } catch (e) {
      //
    }
  }

  Future<Response?> getPeriods({String url = AppUrls.periodsHHC}) async {
    // try {
    var response = await api.dioGet(url);

    return response;
    // } catch (e) {
    //   //
    // }
  }

  Future<Response?> getPCRPeriods(
      {String url = AppUrls.periodsHHC}) async {
    // try {
    var response = await api.dioGet(url);

    return response;
    // } catch (e) {
    //   //
    // }
  }

  var bookings = AppUrls.createAppointment;

  Future<Response?> setPaymentStatus(Map<String, dynamic> data,
      {String url = AppUrls.setPaymentStatus}) async {
    try {

      var response = await api.dioPost(endPath:  url, body: data,);

      return response;
    } catch (e) {
      //
      print(e.toString());

      return null;
    }
  }

  Future<Response?> requestCancelAppointment(Map<String, String> data) async {
    try {
      var response = await api.dioPost(endPath:
        AppUrls.requestCancelAppointment,
        body: data,
      );

      return response;
    } catch (e) {
      //
      print(e.toString());

      return null;
    }
  }

  Future<Response?> createAppointment(Map<String, String> data) async {
    try {
    var response = await api.dioPost(
      body: data,
    );


    return response;
    } catch (e) {
      //
      print(e.toString());
      return null;

    }
  }

  Future<Response?> requestSleepMedicine(data) async {
    try {
      var response =
          await api.dioPost( endPath:  AppUrls.requestSleepMedicine, body: data);

      return response;
    } catch (e) {
      //
      return null;
    }
  }
  Future<Response?> appointmentCheckDiscount(data) async {
    // try {
      var response = await api.dioPost(endPath:  AppUrls.appointmentCheckDiscount, body: data);

      return response;
    // } catch (e) {
    //   //
    //   return null;
    // }
  }

  Future<Response?> requestCaregiver(data) async {
    try {
      var response = await api.dioPost(endPath:  AppUrls.requestCaregiver, body: data);

      return response;
    } catch (e) {
      //
      return null;
    }
  }

  Future<Response?> contactUs(data) async {
    try {
      var response = await api.dioPost(endPath:  AppUrls.contactUs, body: data);

      return response;
    } catch (e) {
      //
      return null;
    }
  }
}
