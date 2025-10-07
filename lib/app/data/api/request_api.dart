import 'package:dio/dio.dart' ;

import 'app_urls.dart';
import 'base_api.dart';

class RequestApi extends BaseApi {
  static final _appointmentApi = RequestApi._internal();

  factory RequestApi() {
    return _appointmentApi;
  }

  RequestApi._internal();

  var appointment = (AppUrls.teleAppointments);

  Future<Response?> getAppointments({String type = 'tele'}) async {
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

        default:
          {
            url = AppUrls.teleAppointments;
          }
      }

      var response = await api.dioGet(url + currentUser!.id);

      return response;
    } catch (e) {
      //
      return null;
    }
  }

  Future<Response?> getRequests({String id = ''}) async {
    try {
      var response = await api.dioGet(AppUrls.getInstantConsultation + id);

      return response;
    } catch (e) {
      return null;

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

  Future<Response?> updateFcmToken(Map<String, String> data) async {
    try {
      var response = await api.dioPost(
        endPath:
        AppUrls.updateFcmToken,
        body: data,
      );

      return response;
    } catch (e) {
      //
      print(e.toString());

      return null;
    }
  }
  Future<Response?> setPaymentStatus(Map<String, String> data) async {
    try {
      var response = await api.dioPost(
        endPath:
        AppUrls.setPaymentStatus,
        body: data,
      );

      return response;
    } catch (e) {
      //
      print(e.toString());

      return null;
    }
  }

  Future<Response?> createInstantCon(Map<String, String> data) async {
    try {
      var response = await api.dioPost(
        endPath:
        AppUrls.createInstantCon,
        body: data,
      );

      return response;
    } catch (e) {
      //
      // print(e.toString());

      return null;
    }
  }

  Future<Response?> makeBookingWithFileDio(Map<String, String> data) async {
    // try {
    var response = await api.dioPost(
      body: data,
    );

    return response;
    // } catch (e) {
    //   //
    //   print(e.toString());
    //   return null;
    //
    // }
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

  Future<Response?> requestCaregiver(data) async {
    try {
      var response = await api.dioPost( endPath:   AppUrls.requestCaregiver, body: data);

      return response;
    } catch (e) {
      //
      return null;
    }
  }

  Future<Response?> contactUs(data) async {
    try {
      var response = await api.dioPost(  endPath:  AppUrls.contactUs, body: data);

      return response;
    } catch (e) {
      //
      return null;
    }
  }

  Future<Response?> rateConsultation(Map<String, String> data) async {
    try {
      var response = await api.dioPost(
        endPath:
        AppUrls.rateInstantCon,
        body: data,
      );

      return response;
    } catch (e) {
      //
      print(e.toString());

      return null;
    }
  }
}
