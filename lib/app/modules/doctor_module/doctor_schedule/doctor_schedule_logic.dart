import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:globcare/app/utils/group_by.dart';
import '../../../base_controller/base_controller.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../data/constants/booking_constants.dart';
import '../../../data/eunums/enums.dart';
import '../../../data/models/m_doctors.dart';
import '../../../data/models/schedule_model.dart';
import '../../../data/repositories/doctor_repository.dart';
import '../../../routes/app_route_names.dart';
import '../../booking_home_modules/patient_data/patient_data_logic.dart';

class DoctorScheduleLogic extends BaseController {
  final DoctorRepository _doctorRepository = DoctorRepository();
  DateTime selectedDay = DateTime.now();

  int currentIndex = 0;

  List<ScheduleModel> scheduleList = [], list = [];

  String selectedSlot = '';

  var doctor = Get.arguments as Doctor;

  int infoIndex = 0;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    PatientDataLogic.chooseDateType = ChooseDateType.doctor;
    setBusy(true);
    BookingConstants.doctorName = doctor.name!;
    BookingConstants.doctor = doctor;

// if(DoctorsController.doctorType=='TD') {
//   BookingVars.price = double.parse(doctor.telePrice.toString());
// }
// else{
//   BookingVars.price = double.parse(doctor.hvdPrice.toString());
//
// }

    list = await _doctorRepository.getScheduleList(id: '${doctor.id}');

    var l = list.groupBy((p0) => p0.date).entries.toList();

    for (var element in l) {
      List<String> t = [];
      for (var s in element.value) {
        if (s.date == element.key) {
          t.addAll(s.times!);
        }
      }

      scheduleList.add(ScheduleModel(date: element.key, times: t));
    }

    if (scheduleList.isNotEmpty) {
      selectedDay = scheduleList[0].date;
    }

    setBusy(false);
  }

  changeDay(int index) {
    selectedDay = scheduleList[index].date;
    currentIndex = index;

    BookingConstants.appointmentDate = selectedDay;
    var hour=int.parse(selectedSlot.split(':')[0]);
    var min=int.parse(selectedSlot.split(':')[1]);


    BookingConstants.appointmentDate=DateTime(selectedDay.year,selectedDay.month,selectedDay.day,hour,min);

    update();
  }

  changeSlot(String time) {
    selectedSlot = time;
    var hour=int.parse(time.split(':')[0]);
    var min=int.parse(time.split(':')[1]);

    BookingConstants.appointmentDate =
        selectedDay;
    BookingConstants.appointmentDate=DateTime(selectedDay.year,selectedDay.month,selectedDay.day,hour,min);

    update();
  }

  checkSlot(String time, DateTime date) =>
      time == selectedSlot && date == selectedDay;

  void navToPatientData() {
    if (scheduleList.isNotEmpty && selectedSlot.isNotEmpty) {
      Get.toNamed(AppRouteNames.patientData);

      //   print(BookingVars.appointmentDate);
    } else {
      buildFailedSnackBar(msg: AppStrings.selectTimeMsg.tr);
    }
  }

  changeInfoIndex(int i) {
    infoIndex = i;
    update();
  }
}
