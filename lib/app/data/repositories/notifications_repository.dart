
import 'dart:developer';

import 'package:dio/dio.dart';

import '../api/api_keys.dart';
import '../api/app_urls.dart';
import '../api/base_api.dart';
import '../api/files_api.dart';
import '../models/file_model.dart';
import '../models/notification_model.dart';

class NotificationsRepository extends BaseApi{
  static final _notificationsRepository = NotificationsRepository._internal();

  factory NotificationsRepository() {
    return _notificationsRepository;
  }
  var failResponse= {ApiKeys.responseSuccess:0,ApiKeys.responseMessage:'There is a problem \nour team will fix it asap'};

  NotificationsRepository._internal();


  Future<List<NotificationModel>> getNotificationList() async {
    try {
      var response = await api.dioGet(AppUrls.getNotificationList+currentUser!.id);
      // print(response!.statusCode);

      if(response ==null){
        return [];
      }

      var jsonData = response.data;
// log(jsonData.toString());
      if (jsonData[ApiKeys.responseSuccess] == 1) {
        var d = jsonData['data'] as List;
        var dd = d.map((dr) {
          return NotificationModel.fromJson((dr));
        }).toList();

        return dd;
      } else {
        return [];
      }
    }on DioException catch (e) {
      logger.i(e.toString());
      return [];
    }
  }
  Future<dynamic> updateNotification(Map<String, dynamic> data) async {

    try {
      var response = await api.dioPost(endPath: AppUrls.updateNotification,body:  data);


      return response!.data;
    } catch (_) {
      return failResponse;
    }
  }

}
