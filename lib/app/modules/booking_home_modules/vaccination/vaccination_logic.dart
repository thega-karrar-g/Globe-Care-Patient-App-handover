import 'package:get/get.dart';
import '../../../base_controller/base_controller.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../data/constants/booking_constants.dart';
import '../../../data/eunums/enums.dart';
import '../../../data/models/nurse_service.dart';
import '../../../data/repositories/service_repository.dart';
import '../../../routes/app_route_names.dart';
import '../patient_data/patient_data_logic.dart';

class VaccinationLogic extends BaseController {
  final ServiceRepository _serviceRepository = ServiceRepository();

  List<NurseService> selectedItems = [];

  List<NurseService> items = [];

  updateItems(NurseService item) {
    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
    } else {
      selectedItems.clear();

      selectedItems.add(item);
    }

    update();
  }

  checkItem(NurseService item) {
    return selectedItems.contains(item);
  }

  navToTimeSlots() {
    PatientDataLogic.chooseDateType = ChooseDateType.other;

    if (selectedItems.isNotEmpty) {
      BookingConstants.serviceId = selectedItems[0].id;
      BookingConstants.serviceType = 'N';
      BookingConstants.serviceCode = 'V';
      BookingConstants.service = selectedItems[0];
      BookingConstants.price = double.parse(selectedItems[0].price);
      BookingConstants.doctor.name = '';
      BookingConstants.doctor.nameAr = '';
      BookingConstants.appointmentType = '-hhc';
      BookingConstants.doctorName = '';

      Get.toNamed(AppRouteNames.patientData);
    } else {
      buildFailedSnackBar(msg: AppStrings.selectMsg.tr);
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    BookingConstants.reset();

    setBusy(true);

    var data = await _serviceRepository.getServicesList();
    BookingConstants.paymentAppointmentType = PaymentAppointmentTypes.hhc;

    items.addAll(data.where((element) => element.code == 'V'));

    setBusy(false);
    update();
  }
}
