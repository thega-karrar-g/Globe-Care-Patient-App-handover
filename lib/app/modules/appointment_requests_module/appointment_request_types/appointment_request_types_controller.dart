import 'package:get/get.dart';

import '../../../core/assets_helper/app_images.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../data/models/home_service.dart';
import '../caregiver_contract_requests/caregiver_contract_requests_page.dart';
import '../refund_cancel_request/refund_cancel_request_page.dart';
import '../sleep_medicine_requests/sleep_medicine_requests_page.dart';

class AppointmentRequestTypesController extends GetxController {
  List<HomeService> appointmentTypes = [

    HomeService(
        id: 1,
        name: AppStrings.caregiverContractsRequests,
        description: AppStrings.caregiverContractsRequests,
        icon: AppImages.iconCaregiver,
        route: CaregiverContractRequestsPage.routeName,
        code: 'caregiver'),
    HomeService(
        id: 1,
        name: AppStrings.sleepMedicineRequests,
        description: AppStrings.sleepMedicineRequests,
        icon: AppImages.iconSleep,
        route: SleepMedicineRequestsPage.routeName,
        code: 'sleep'),
    HomeService(
        id: 1,
        name: AppStrings.refundCancelRequests,
        description: AppStrings.refundCancelRequests,
        icon: AppImages.iconDelayCancel,
        route: RefundCancelRequestPage.routeName,
        code: 'refund'),


  ];

  onRequestTypeTab(HomeService homeService){

    if(homeService.route.isNotEmpty){
    Get.toNamed(homeService.route);}


  }

}
