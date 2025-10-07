import 'package:get/get.dart';
import '../../../base_controller/base_controller.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../data/constants/booking_constants.dart';
import '../../../data/eunums/enums.dart';
import '../../../data/models/home_service.dart';
import '../../../data/models/nurse_service.dart';
import '../../../data/repositories/service_repository.dart';
import '../../../routes/app_route_names.dart';
import '../patient_data/patient_data_logic.dart';

class NurseServicesLogic extends BaseController {
  final ServiceRepository _serviceRepository = ServiceRepository();

  List<NurseService> selectedItems = [];

  List<NurseService> items = [], searchList = [];



  updateItems(NurseService item) {

    // print(item.name);
 bool isCaregiverOrSleep= ['Car','SM'].contains(  homeService.code);


    if(isCaregiverOrSleep){

// print("*******************");

      if (selectedItems.contains(item)) {
        selectedItems.remove(item);
      } else {
        selectedItems.clear();

        // if (selectedItems.isEmpty) {
          selectedItems.add(item);
         // BookingConstants.price = double.parse(item.price);

          BookingConstants.service = NurseService(name: item.name,nameAr: item.nameAr,price: item.price);


        // }
      }

    }

    else {
      if (selectedItems.contains(item)) {
        selectedItems.remove(item);
      } else {
        if (selectedItems.isEmpty || selectedItems.length < 3) {
          selectedItems.add(item);
        } else {
          buildFailedSnackBar(msg: AppStrings.maximumServicesMsg.tr);
        }
      }
    }
    update();
  }

  checkItem(NurseService item) {
    return selectedItems.contains(item);
  }

  @override
  search({String txt = ''}) {
    searchList.clear();

    searchList.addAll(items
        .where((element) =>
            element.name.toString().toLowerCase().contains(txt.toLowerCase()) ||
            element.nameAr.contains(txt))
        .toList());

    update();
  }

  navToTimeSlots() {
    PatientDataLogic.chooseDateType = ChooseDateType.other;


    if(homeService.code=='Car'){
      PatientDataLogic.chooseDateType = ChooseDateType.caregiver;
    }
    if(homeService.code=='SM'){
      PatientDataLogic.chooseDateType = ChooseDateType.sleepMedicine;
    }



    if (selectedItems.isNotEmpty) {
      var services = '';
      // for (var element in selectedItems) {
      //   services+='- ${element.name} ';
      // }
      BaseController.service += ' $services';
      BookingConstants.serviceId = selectedItems[0].id;
      BookingConstants.service = selectedItems[0];
      if (selectedItems.length > 1) {
        BookingConstants.service2 = selectedItems[1];
      } else {
        BookingConstants.service2 = NurseService();
      }

      if (selectedItems.length > 2) {
        BookingConstants.service3 = selectedItems[2];
      } else {
        BookingConstants.service3 = NurseService();
      }
      BookingConstants.price = 0.0;
      for (var element in selectedItems) {
        BookingConstants.price += double.parse(element.price);
      }
      BookingConstants.paymentAppointmentType = PaymentAppointmentTypes.hhc;

      BookingConstants.serviceType = 'N';
      BookingConstants.serviceCode = '';

      BookingConstants.appointmentType = '-hhc';
      BookingConstants.doctorName = '';
      BookingConstants.doctor.name = '';
      BookingConstants.doctor.nameAr = '';


      if(homeService.code !='HHC') {
        BookingConstants.appointmentType = homeService.code;
      }
      if(homeService.code =='SM') {
        BookingConstants.discountCategory = 'sleep';
        BookingConstants.appointmentType='sleep';

        BookingConstants.paymentAppointmentType=PaymentAppointmentTypes.sleep;
      }
      if(homeService.code =='Car') {
        BookingConstants.discountCategory = 'caregiver';

        BookingConstants.appointmentType='caregiver';
        BookingConstants.paymentAppointmentType=PaymentAppointmentTypes.caregiver;

      }


      Get.toNamed(AppRouteNames.patientData);
    } else {
      buildFailedSnackBar(msg: AppStrings.selectMsg.tr);
    }
  }
  HomeService homeService = Get.arguments;

  @override
  void onInit() async {
    BookingConstants.reset();
    BookingConstants.discountCategory = 'hhc';

    if(homeService.code !='HHC') {
      BookingConstants.appointmentType = homeService.code;
    }
    if(homeService.code =='SM') {
      BookingConstants.discountCategory = 'sleep';
      BookingConstants.appointmentType='sleep';

      BookingConstants.paymentAppointmentType=PaymentAppointmentTypes.sleep;
    }
    if(homeService.code =='Car') {
      BookingConstants.discountCategory = 'caregiver';

      BookingConstants.appointmentType='caregiver';
      BookingConstants.paymentAppointmentType=PaymentAppointmentTypes.caregiver;

    }


      print('******************************************* code: ${homeService.code}');
      print('******************************************* type: ${BookingConstants.appointmentType}');

    setBusy(true);
    var data = await _serviceRepository.getServicesList(serviceType: homeService.code);

    items.addAll(data.where((element) => element.type == homeService.code));

   // print('******************************************* length data: ${data.length}');
   // print('******************************************* length items: ${items.length}');

    searchList.addAll(items);

    setBusy(false);
    update();

    super.onInit();

  }
}
