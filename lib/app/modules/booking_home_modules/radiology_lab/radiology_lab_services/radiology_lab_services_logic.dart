import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../base_controller/base_controller.dart';
import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../data/constants/booking_constants.dart';
import '../../../../data/eunums/enums.dart';
import '../../../../data/models/home_service.dart';
import '../../../../data/models/nurse_service.dart';
import '../../../../data/repositories/service_repository.dart';
import '../../../../routes/app_route_names.dart';

class RadiologyLabServicesLogic extends BaseController {
  final ServiceRepository _serviceRepository = ServiceRepository();
  int index = 0;
  String code = 'R';

  GlobalKey? key = GlobalKey();
  final finalKey = GlobalKey();
  List<NurseService> _services = [],
      searchList = [],
      currentServices = [],
      selectedItems = [];

  HomeService homeService = Get.arguments;

  updateIndex(int i) {
    index = i;

    switch (i) {
      case 0:
        {
          code = 'L';
        }
        break;
      case 1:
        {
          code = 'LP';
        }
        break;
    }
    currentServices.clear();
    currentServices.addAll(_services.where((element) => element.code == code));
    searchList.clear();
    searchList.addAll(currentServices);
    key = null;

    update();
  }

  updateItems(NurseService item) {
    key = finalKey;

    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
    } else {
      if (selectedItems.isEmpty || selectedItems.length < 3) {
        selectedItems.add(item);
      } else {
        AppStrings.selectTimeMsg;
        buildFailedSnackBar(msg: AppStrings.maximumServicesMsg.tr);
      }
    }

    update();
  }

  checkItem(NurseService item) {
    return selectedItems.contains(item);
  }

  updateItemsAdd(NurseService item) {
    // key=finalKey;

    if (item.quantity < 5) {
      currentServices[currentServices.indexOf(item)].quantity++;
    }
    update();
  }

  updateItemsSub(NurseService item) {
    // key=finalKey;

    if (item.quantity > 1) {
      currentServices[currentServices.indexOf(item)].quantity--;
    }
    update();
  }

  navToTimeSlots() {


    if (selectedItems.isNotEmpty) {
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

      Get.toNamed(AppRouteNames.patientData);
    } else {
      buildFailedSnackBar(msg: AppStrings.selectMsg.tr);
    }
  }

  @override
  search({String txt = ''}) {
    searchList.clear();

    searchList.addAll(currentServices
        .where((element) =>
            element.name.toLowerCase().contains(txt.toLowerCase()) ||
            element.nameAr.contains(txt))
        .toList());

    update();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    BookingConstants.reset();

    BookingConstants.discountCategory = 'hhc';

    setBusy(true);
    _services = await _serviceRepository.getServicesList(serviceType:'');
    currentServices
        .addAll(_services.where((element) => element.code == homeService.code));

    searchList.addAll(currentServices);


    setBusy(false);
    update();
  }
}
