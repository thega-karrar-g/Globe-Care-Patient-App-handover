import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../base_controller/base_controller.dart';
import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../core/theme_helper/app_colors.dart';
import '../../../../core/theme_helper/app_styles.dart';
import '../../../../data/models/home_service.dart';
import '../../../../global_widgets/shared/ui_helpers.dart';
import '../../../../routes/app_route_names.dart';
import '../../../../utils/ext_storage.dart';
import '../../../select_patient/select_patient_logic.dart';

class MedicalFileItem extends StatelessWidget {
  MedicalFileItem(
      {Key? key,
      this.homeService,
      this.userId = '',
      this.isMedicalFile = false,required this.onTab})
      : super(key: key);
  final Function onTab;

  HomeService? homeService;
  final String userId;
  final bool isMedicalFile;

  @override
  Widget build(BuildContext context) {
    return Container(
      //  elevation: 0.1,
      decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(.05),
          borderRadius: BorderRadius.circular(10)),

      child: InkWell(
        onTap: () async{
          onTab();
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Positioned.fill(
            //
            //     child: Image.asset(AppImages.maskPrimaryPng ,width: Get.width/2,height: 200,fit: BoxFit.fill,)),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UiHelper.verticalSpaceSmall,
                Container(
                  padding: EdgeInsets.all(5.0),

                  alignment: Alignment.center,
                  // height: 60,
                  //  width: 60,
                  child: Image.asset(
                    homeService!.icon,
                    // color:primary? AppColors.primaryColor:AppColors.primaryColorGreen,
                    width: 70.w,
                    height: 70.h,
                  ),
                ),
                UiHelper.verticalSpaceTiny,
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.only(right: 5.w, left: 5.w, bottom: 10.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            homeService!.name.tr,
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: homeService!.primary
                                ? AppStyles.primaryStyle(bold: true, fontSize: 12)
                                : AppStyles.primaryStyleGreen(
                                    bold: true, size: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                UiHelper.verticalSpaceMedium,
              ],
            ),

            Positioned.fill(
                bottom: -25.h,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                    width: 60.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                        color: homeService!.primary
                            ? AppColors.primaryColor
                            : AppColors.primaryColorGreen,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15.w),
                          bottomLeft: Radius.circular(15.w),
                        )),
                    child: CircleAvatar(
                      backgroundColor: AppColors.white,
                      radius: 10,
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 18.w,
                        color: homeService!.primary
                            ? AppColors.primaryColor
                            : AppColors.primaryColorGreen,
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
