import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme_helper/app_colors.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../data/models/home_service.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../doctor_module/doctors/doctors_controller.dart';
import '../service_details/service_details_logic.dart';

class HomeVisitItem extends StatelessWidget {
  HomeVisitItem({Key? key, this.homeService}) : super(key: key);

  final HomeService? homeService;

  final ar = Get.locale.toString() == 'ar';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (homeService!.code != 'HHCD') {
          ServiceDetailsLogic.serviceCode = homeService!.code;
          Get.toNamed(homeService!.next);
        } else {
          DoctorsController.doctorType = homeService!.code;
          Get.toNamed(homeService!.next);
        }
      },
      child: Container(
        height: 100,
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: AppColors.primaryColorOpacity,
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            UiHelper.horizontalSpaceMedium,
            Expanded(
                child: Column(
              children: [
                UiHelper.verticalSpaceMedium,
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      homeService!.name.tr,
                      style: AppStyles.primaryStyle(bold: true, fontSize: 16),
                    )),
                  ],
                ),
                UiHelper.verticalSpaceSmall,
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      homeService!.description.tr,
                      maxLines: 2,
                      style: AppStyles.primaryStyle(
                          bold: false, fontSize: 15, opacity: .7),
                    )),
                  ],
                ),
              ],
            )),
            UiHelper.horizontalSpaceSmall,
            Container(
              alignment: Alignment.center,
              width: 40,
              height: 100,
              decoration: BoxDecoration(
                  color: AppColors.primaryColorGreen,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(ar ? 0 : 15),
                    bottomRight: Radius.circular(ar ? 0 : 15),
                    topLeft: Radius.circular(ar ? 15 : 0),
                    bottomLeft: Radius.circular(ar ? 15 : 0),
                  )),
              child: CircleAvatar(
                radius: 15,
                backgroundColor: AppColors.white,
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.primaryColorGreen,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
