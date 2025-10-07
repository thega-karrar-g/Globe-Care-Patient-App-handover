import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../data/models/user_model.dart';
import '../services/session_service.dart';
import 'helpers_methods.dart';

class BaseController extends GetxController with HelpersMethod {
  static int? doctorId = 1;
  static  int recordId=0;

  static String appointmentDate = '',
      location = '',
      paymentType = '',
      service = '';

  var authService = Get.find<SessionService>();
static int notificationCount=0;
  var logger = Logger(
    printer: PrettyPrinter(
      colors: true,
      printEmojis: false,
      printTime: false,
    ),
  );

  bool _busy = false;

  bool get busy => _busy;

  void setBusy(bool value, {bool notify = true}) {
    _busy = value;
    if (notify) update();
  }

  AppUser? get currentUser {
    return Get.find<SessionService>().currentUser;
  }

  bool get checkUserSignIn {
    return Get.find<SessionService>().checkUserSignIn();
  }

  bool get checkGuestSignIn {
    return Get.find<SessionService>().checkGuestSignIn();
  }

  logUserOut() {
    return Get.find<SessionService>().signOut();
  }

  final TextEditingController searchController = TextEditingController();

  search({String txt = ''}) {}
}
