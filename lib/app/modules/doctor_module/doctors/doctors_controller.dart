import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../base_controller/base_controller.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../data/constants/booking_constants.dart';
import '../../../data/eunums/enums.dart';
import '../../../data/models/m_doctors.dart';
import '../../../data/models/nurse_service.dart';
import '../../../data/models/slides_model.dart';
import '../../../data/repositories/doctor_repository.dart';

class DoctorsController extends BaseController {
  final DoctorRepository _doctorRepository = DoctorRepository();

  bool isGeneral = true;
  var generalType = 'GP';

  DateTime selectedValue = DateTime.now();

  int index = 0;
  List<Doctor> doctors = [];
  List<DeptDoctor> deptDoctors = [];

  List<Doctor> currentDoctors = [];
  List<String> specialties = [];

  static String doctorType = 'TD';

  Future<List<Doctor>> getDoctors() async {
    return await _doctorRepository.getDoctorsList();
  }

  var slide = SliderModel();

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    BookingConstants.reset();

    PaintingBinding.instance.imageCache.clear();

    setBusy(true);
    if (doctorType != 'TD') {
      BookingConstants.paymentAppointmentType = PaymentAppointmentTypes.hvd;

      BookingConstants.appointmentType = 'hvd';
      BookingConstants.discountCategory = 'hvd';

      BookingConstants.service = NurseService(
        name: AppStrings.homeVisitDoctor,
        nameAr: 'زيارة طبيب بالمنزل',
      );
    } else {
      BookingConstants.discountCategory = 'tele';
      BookingConstants.appointmentType = 'tele';

      BookingConstants.paymentAppointmentType = PaymentAppointmentTypes.tele;

      // slide=Slide.slides.where((element) => element.code=='TD',).first;

      // Future<Null>.delayed(Duration.zero, () {
      //   DifferentDialog.showServiceInfoSnackBar(description: slide.description!.tr,title: slide.title!.tr,image: slide.image!);
      // });

    }

    doctors = await _doctorRepository.getDoctorsList(drType: doctorType);

    if(doctorType.toLowerCase()=='hvd'){

      if(BookingConstants.branch !=null) {
        doctors =
            doctors.where((element) => element.branch.toLowerCase() ==
                BookingConstants.branch!).toList();
      }
      }

    for (var element in doctors) {

      await CachedNetworkImage.evictFromCache(element.image!);

      if (!specialties.contains(element.speciality)) {
        specialties.add(element.speciality.toString());

        deptDoctors.add(DeptDoctor(
            name: element.speciality!,
            nameAr: element.specialityAr!,
            doctors: [element]));
      } else {
        for (var d in deptDoctors) {
          if (d.name == element.speciality) {
            d.doctors.add(element);
          }
        }
      }
    }

    currentDoctors.clear();

    if (doctorType != 'TD') {
      currentDoctors.addAll(
          doctors.where((element) => element.doctorType == generalType));
    } else {
      currentDoctors.addAll(doctors);
    }

    //
    // if(specialties.isNotEmpty){
    //   updateDoctors(index);
    // }

    setBusy(false);
  }

  updateDoctors(int i) {
    index = i;
    currentDoctors.clear();
    for (var element in doctors) {
      if (element.speciality == specialties[index]) {
        currentDoctors.add(element);
      }
    }
    update();
  }

  //////////////////
  List<String> filterDoctors = [];

  updateDoctorsFilter(List<String> specialties) {
    currentDoctors.clear();

    if (specialties.isNotEmpty) {
      for (var d in doctors) {
        if (specialties.contains(d.speciality)) {
          currentDoctors.add(d);
        }
      }
    } else {
      currentDoctors.addAll(doctors);
    }

    update();
  }

  addRemoveFilter(String specialty) {
    if (filterDoctors.contains(specialty)) {
      filterDoctors.remove(specialty);
    } else {
      filterDoctors.add(specialty);
    }

    update();
  }

  bool checkFilter(String specialty) {
    return filterDoctors.contains(specialty);
  }

  updateGeneral({bool general = true}) {
    isGeneral = general;
    currentDoctors.clear();
    if (general) {
      currentDoctors.addAll(
          doctors.where((element) => element.doctorType == generalType));
    } else {
      currentDoctors.addAll(
          doctors.where((element) => element.doctorType != generalType));
    }

    deptDoctors.clear();
    specialties.clear();
    for (var element in doctors) {
      if (!specialties.contains(element.speciality)) {
        specialties.add(element.speciality.toString());

        if (element.doctorType != generalType) {
          deptDoctors
              .add(DeptDoctor(name: element.speciality!, doctors: [element]));
        }
      } else {
        for (var d in deptDoctors) {
          if (d.name == element.speciality &&
              element.doctorType != generalType) {
            d.doctors.add(element);
          }
        }
      }
    }

    update();
  }

///////////////// search

  @override
  search({String txt = ''}) {
    currentDoctors.clear();

    if (txt.trim().isNotEmpty) {
      for (var d in doctors) {
        if (d.name!.toLowerCase().contains(
              txt.toLowerCase(),
            )) {
          currentDoctors.add(d);
        }
      }
    } else {
      currentDoctors.addAll(doctors);
    }
    update();
  }

  List<String> doctorSlots = [];

  updateSlots(Doctor doctor, {String day = ''}) {
    doctorSlots.clear();
    for (var element in doctor.availableLines!) {
      if (day == element.day) {
        DateTime start = DateFormat("HH:mm").parse(element.startTime!);
        DateTime end = DateFormat("HH:mm").parse(element.endTime!);

        TimeOfDay startTimeOfDay = TimeOfDay.fromDateTime(start);

        TimeOfDay endTimeOfDay = TimeOfDay.fromDateTime(end);
        doctorSlots.addAll(getSlots(
          start: startTimeOfDay.hour,
          end: endTimeOfDay.hour - 1,
        ));
      }
    }

    update();
  }

  static Iterable<TimeOfDay> getTimes(
      TimeOfDay startTime, TimeOfDay endTime, Duration step) sync* {
    var hour = startTime.hour;
    var minute = startTime.minute;

    do {
      yield TimeOfDay(hour: hour, minute: minute);
      minute += step.inMinutes;
      while (minute >= 60) {
        minute -= 60;
        hour++;
      }
    } while (hour < endTime.hour ||
        (hour == endTime.hour && minute <= endTime.minute));
  }

  static List<String> getSlots(
      {int start = 9, int end = 11, String period = ''}) {
    // if(route == AppStrings.telemedicine) {
    final startTime = TimeOfDay(hour: start, minute: 0);
    final endTime = TimeOfDay(hour: end, minute: 45);
    final step = Duration(minutes: doctorType == 'TD' ? 15 : 60);

    final times = getTimes(startTime, endTime, step)
        .map((tod) => DateFormat('hh:mm')
            .format(DateTime(2022, 1, 1, tod.hour, tod.minute)))
        .toList();

    return times;
    //}
    // else{
    //   return [period];
    // }
  }
}
