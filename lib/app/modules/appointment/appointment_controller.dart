import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../base_controller/base_controller.dart';
import '../../core/language_and_localization/app_strings.dart';
import '../../data/models/home_service.dart';
import '../../data/models/m_appointment.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/appointment_repository.dart';

class AppointmentController extends BaseController {
  final AppointmentRepository _appointmentRepository = AppointmentRepository();

  static AppUser? user;
  AppointmentStatus appointmentStatus = AppointmentStatus.confirmed;

  int _currentPageIndex = 0;

  int get getCurrentIndex => _currentPageIndex;

  late PageController pageController;

  List<AppointmentGroup> appointmentGroup=[];

  changePageIndex(int newValue) {
    //if(newValue!=2){
    _currentPageIndex = newValue;

    updateIndex(newValue); //}
  }

  Rx<int> index = 0.obs;

  @override
  var busy = false;

  List<Appointment> appointments = [];
  List<Appointment> currentAppointments = [];

  updateIndex(int i) {
    index.value = i;
    currentAppointments.clear();

    switch (i) {
      case 0:
        {
          // scheduled
          currentAppointments.addAll(appointments
              .where((element) => (element.state.toLowerCase() == states[0]))
              .toList());
        }
        break;
      case 1:
        {
          //
          //conform
          currentAppointments.addAll(appointments
              .where((element) => !states.contains(element.state.toLowerCase()))
              .toList());
        }
        break;

      case 2:
        {
          //completed
          currentAppointments.addAll(appointments
              .where((element) => (element.state.toLowerCase() == states[1] ||
                  element.state.toLowerCase() == states[2]))
              .toList());
        }
        break;

      case 3:
        {
          //canceled
          currentAppointments.addAll(appointments
              .where((element) => (element.state.toLowerCase() == states[3]))
              .toList());
        }
        break;
    }

    update();
  }

  updateAppointmentStatus(AppointmentStatus apStatus) {
    // appointmentStatus = apStatus;
    //
    // currentAppointments.clear();
    //
    // switch (apStatus) {
    //   case AppointmentStatus.underReview:
    //     {
    //       // scheduled
    //       currentAppointments.addAll(appointments
    //           .where((element) => (element.state.toLowerCase() == states[0]||element.state == states[4]))
    //           .toList());
    //     }
    //     break;
    //   case AppointmentStatus.confirmed:
    //     {
    //       //
    //       //conform
    //       if (arg.code == 'tele') {
    //         currentAppointments.addAll(appointments
    //             .where((element) =>
    //                 !states.contains(element.state.toLowerCase()) ||
    //                 element.state.toLowerCase() == 'start')
    //             .toList());
    //       } else {
    //         currentAppointments.addAll(appointments
    //             .where(
    //                 (element) => confirmedStates.contains(element.state.toLowerCase()))
    //             .toList());
    //       }
    //     }
    //     break;
    //
    //   case AppointmentStatus.completed:
    //     {
    //       //completed
    //       currentAppointments.addAll(appointments
    //           .where((element) => (element.state.toLowerCase() == states[1] ||
    //               element.state.toLowerCase() == states[2]))
    //           .toList());
    //     }
    //     break;
    //
    //   case AppointmentStatus.canceled:
    //     {
    //       //canceled
    //       currentAppointments.addAll(appointments
    //           .where((element) => (element.state.toLowerCase() == states[3]))
    //           .toList());
    //     }
    //     break;
    // }

    appointmentGroup=groupByData(appointments);

    update();
  }

  updateBusy(bool b) {
    busy = b;
    update();
  }

  HomeService arg = Get.arguments as HomeService;

  getAppointments() async {
    updateBusy(true);

    var code = 'tele';
    if (arg.code == 'hhc' ||
        arg.code == 'MH' ||
        arg.code == 'GCP' ||
        arg.code == 'SM') {
      code = 'hhc';
    } else {
      code = arg.code;
    }

    appointments = await _appointmentRepository.getAppointmentList1(
        type: code, patientId: user!.id.toString());


    // logger.i("length ${appointments.length}");

    currentAppointments.clear();
    updateAppointmentStatus(appointmentStatus);
    //   currentAppointments=appointments.where((element) => status[0]== element.state.toLowerCase()).toList();

    updateBusy(false);
    update();
  }

  List<String> states = [
    'scheduled',
    'completed',
    'visit_done',
    'canceled',
    'requestCancellation',
  ];
  List<String> confirmedStates = [
    'head_doctor',
    'team',
    'head_nurse',
    'operation_manager',
  ];

  bool isMeetPossible(String currentStatus) {
    return states.contains(currentStatus.toLowerCase());
  }

  bool audioGranted = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    pageController = PageController(initialPage: getCurrentIndex);
    getAppointments();
  }

  microphoneGranted() async {
    audioGranted = await Permission.microphone.request().isGranted;
  }




  List< AppointmentGroup> groupByData(List<Appointment> files) {
    final groups = groupBy(files, (Appointment e) {
      var d=(e.appointmentDate);
      return DateTime(d.year,d.month,d.day);
    });
    appointmentGroup.clear();
    groups.forEach((key, value) {

      appointmentGroup.add(AppointmentGroup(dateTime: key,appointments: value));

    });
    appointmentGroup.sort((a, b) =>  a.dateTime .compareTo(b.dateTime));
    return  appointmentGroup.reversed.toList();
  }

  String dateConverter(DateTime myDate) {
    String date='Today';

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    final dateToCheck = myDate;
    final checkDate = DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
    if (checkDate == today) {
      date = AppStrings.today;
    } else if (checkDate == yesterday) {
      date = AppStrings.yesterday;
    }
    else {
      date = DateFormat("d MMM yyyy",Get.locale.toString()).format(myDate);
    }
    return date;
  }


}

enum AppointmentStatus { underReview, confirmed, completed, canceled }
