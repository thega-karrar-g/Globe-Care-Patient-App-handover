import 'package:get/get.dart';

import '../../../base_controller/base_controller.dart';
import '../../../data/constants/booking_constants.dart';
import '../../../data/eunums/enums.dart';
import '../../../data/models/nurse_service.dart';
import '../../../data/repositories/service_repository.dart';
import '../../../routes/app_route_names.dart';
import '../../../core/assets_helper/app_images.dart';
import '../patient_data/patient_data_logic.dart';

class ServiceDetailsLogic extends BaseController {
  static String serviceCode = 'MH';
  static String icon = AppImages.homeVisitDoctor;

  final ServiceRepository _serviceRepository = ServiceRepository();

  List<NurseService> services = [];

  NurseService? nurseService;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    BookingConstants.reset();


    BookingConstants.showFiles = true;

    BookingConstants.isPcr = false;
    BookingConstants.discountCategory = 'hhc';

    setBusy(true);
    services = await _serviceRepository.getServicesList(serviceType:serviceCode);
    BookingConstants.doctorName = '';
    BookingConstants.paymentAppointmentType = PaymentAppointmentTypes.hhc;

    for (var element in services) {
      if (element.type == serviceCode) {
        nurseService = element;
        break;
      }
    }
    setBusy(false);

    update();
  }

  navToNext() {
    final ar = Get.locale.toString() == 'ar';

    BookingConstants.price = double.parse(nurseService!.price);

    BookingConstants.serviceId = nurseService!.id;
    BookingConstants.serviceName = ar ? nurseService!.nameAr : nurseService!.name;
    BookingConstants.appointmentType = '-hhc';
    BookingConstants.serviceCode = '';
    BookingConstants.doctor.name = '';
    BookingConstants.doctor.nameAr = '';
    BookingConstants.service = nurseService!;

    if (nurseService!.code == 'IVT') {
      BookingConstants.serviceCode = 'IVT';
    }

    if (nurseService!.code == 'SM') {
      PatientDataLogic.chooseDateType = ChooseDateType.hide;

      Get.toNamed(AppRouteNames.patientData, arguments: nurseService!.code);
    } else if (nurseService!.code == 'Car') {
      PatientDataLogic.chooseDateType = ChooseDateType.hide;

      Get.toNamed(AppRouteNames.patientData, arguments: nurseService!.code);
    }
    else {
      PatientDataLogic.chooseDateType = ChooseDateType.other;

      Get.toNamed(AppRouteNames.patientData, arguments: nurseService!.code);
    }
  }

  bool showPrice() {
    var t = ['SM', 'Car'];
    var s = !t.contains(nurseService!.code);

    return s;
  }
}
