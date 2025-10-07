import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../base_controller/base_controller.dart';
import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../data/constants/booking_constants.dart';
import '../../../../data/models/schedule_model.dart';
import '../../../../data/repositories/appointment_repository.dart';
import '../../../../routes/app_route_names.dart';
import '../../../../utils/time_helper.dart';

class ChooseDateLogic extends BaseController {
  int infoIndex = 0;

  final AppointmentRepository _appointmentRepository = AppointmentRepository();

  changeInfoIndex(int index) {
    infoIndex = index;
    update();
  }

  DateTime selectedDay = DateTime.now();
  var weekDays = List<DateTime>.generate(
      7, (i) => DateTime.now().add(Duration(days: 0)).add(Duration(days: i)));

// changeDay(DateTime dateTime){
//   selectedDay=dateTime;
//   var d=       DateFormat('EEEE').format(selectedDay);
//
//   updateSlots(day: d);
//   update();
// }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    setBusy(true);

    String hvp = await _appointmentRepository.getHomeVisitFee();
    BookingConstants.homeVisitPrice = double.parse(hvp).toInt();

    scheduleList = await _appointmentRepository.getPCRPeriodList();
    if (scheduleList.isNotEmpty) {
      changeDay(0);
    }
    setBusy(false);
  }

  List<String> doctorSlots = [];

  DateTime selectedTime = DateTime.now();

  updateSlots({String day = ''}) {
    doctorSlots.clear();

    var isToday = false;

    if (DateFormat('EEEE').format(DateTime.now()) == day) {
      isToday = true;
    }

    doctorSlots.addAll(TimeHelper.getSlots(
        start: isToday ? DateTime.now().hour + 1 : 8, end: 22, step: 60));
    update();
  }

  // updateAppointmentDate(String time) {
  //   DateTime end = DateFormat("HH:mm a").parse(time);
  //
  //   selectedTime = DateFormat('HH:mm a').format(end);
  //
  //   var appointmentDate = DateTime(selectedDay.year, selectedDay.month,
  //       selectedDay.day, end.hour, end.minute, 0);
  //
  //   selectedTime = DateFormat('yyyy-M-d HH:mm:ss').format(appointmentDate);
  //   BookingVars.appointmentDate = selectedTime;
  //
  //   update();
  // }

  checkTime(String time) {
    DateTime end = DateFormat("HH:mm a").parse(time);

    var appointmentDate = DateTime(selectedDay.year, selectedDay.month,
        selectedDay.day, end.hour, end.minute, 0);

    return DateFormat('yyyy-M-d HH:mm:ss').format(appointmentDate);
  }

  navToPatientData() {
    try {
      if (selectedSlot.isNotEmpty) {
        Get.toNamed(AppRouteNames.fillData, arguments: Get.arguments);
      } else {
        buildFailedSnackBar(msg: AppStrings.selectTimeMsg.tr);
      }
    } catch (e) {
      buildFailedSnackBar(msg: AppStrings.selectTimeMsg.tr);
    }
  }

////////////////////////

  int currentIndex = 0;

  List<ScheduleModel> scheduleList = [], list = [];

  static String selectedSlot = '';

  changeDay(int index) {
    selectedDay = scheduleList[index].date;
    currentIndex = index;

    BookingConstants.appointmentDate = (selectedDay);

    update();
  }

  changeSlot(String time) {
    selectedSlot = time;

    BookingConstants.hour = time;

    BookingConstants.appointmentDate = (selectedDay);
    BookingConstants.appointmentDate ;

    update();
  }

  checkSlot(String time, DateTime date) =>
      time == selectedSlot && date == selectedDay;
}
