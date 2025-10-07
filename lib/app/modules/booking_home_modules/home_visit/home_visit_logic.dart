import 'package:get/get.dart';

import '../../../core/assets_helper/app_images.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../data/models/home_service.dart';
import '../../../routes/app_route_names.dart';

class HomeVisitLogic extends GetxController {
  List homeVisitServices = [
    HomeService(
        name: AppStrings.internalMedicineSpecialistHomeVisit,
        description: 'يحضر طبيب أخصائي باطنة إلى المنزل لمعاينة الحالة ',
        icon: AppImages.woundCare,
        route: AppRouteNames.map,
        next: AppRouteNames.serviceDetails,
        code: 'IMSHV'),
    HomeService(
        name: AppStrings.generalPractitionerHomeVisi,
        description:
            'يحضر طبيب عام إلى المنزل لمعاينة الحالة ورفع التقرير إلى المختص',
        icon: AppImages.geriatricCare,
        route: AppRouteNames.map,
        next: AppRouteNames.serviceDetails,
        code: 'GPH'),
    HomeService(
        name: AppStrings.doctorVisit,
        description: 'عرض قائمة الدكاترة بحيث تمكنك من اختيار الطبيب الذي تريد',
        icon: AppImages.manHealth,
        route: AppRouteNames.map,
        next: AppRouteNames.doctors,
        code: 'HHCD'),
  ];
}
