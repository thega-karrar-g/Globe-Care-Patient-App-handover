import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:globcare/app/modules/booking_home_modules/patient_data/patient_data_logic.dart';

import '../../../../core/assets_helper/app_images.dart';
import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../core/theme_helper/app_colors.dart';
import '../../../../core/theme_helper/app_styles.dart';
import '../../../../data/constants/booking_constants.dart';
import '../../../../global_widgets/shared/ui_helpers.dart';
import '../../../../global_widgets/ui.dart';
import 'file_item.dart';

class SelectAttachment extends StatelessWidget {
  const SelectAttachment({Key? key,required this.logic}) : super(key: key);
final PatientDataLogic logic;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Ui.titleGreenUnderLine(
                AppStrings.attachments.tr,
                bottomPadding: 8),
          ],
        ),
        Container(
          width: Get.width,
          decoration: BoxDecoration(
              color: AppColors.primaryColorOpacity,
              borderRadius:
              BorderRadius.circular(10.h)),
          height: 80.h,
          // color: AppColors.registerFiled,

          child: Row(
            children: [
              Expanded(
                child: Container(
                  // width: Get.width*.7,
                  padding: EdgeInsets.symmetric(
                      horizontal: 15.w, vertical: 5.h),
                  decoration: BoxDecoration(
                      color:
                      AppColors.primaryColorOpacity,
                      borderRadius:
                      BorderRadius.circular(10.h)),

                  child: Container(
                    //height: 60,
                    //  width: 60,
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(10.h),
                        border: Border.all(
                            color: AppColors
                                .primaryColorOpacity)),
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.bottomSheet(
                                  Padding(
                                    padding: EdgeInsets
                                        .symmetric(
                                        horizontal:
                                        50.w,
                                        vertical:
                                        30.h),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child:
                                            GestureDetector(
                                              onTap: () {
                                                logic
                                                    .pickCamera();
                                              },
                                              child: Row(
                                                children: [
                                                  SvgPicture
                                                      .asset(
                                                    AppImages
                                                        .camera,
                                                    height:
                                                    25.h,
                                                    width:
                                                    20.w,
                                                  ),
                                                  UiHelper
                                                      .horizontalSpaceSmall,
                                                  Text(
                                                    AppStrings
                                                        .openCamera
                                                        .tr,
                                                    style: AppStyles.primaryStyle(
                                                        fontSize:
                                                        12,
                                                        bold:
                                                        true),
                                                  ),
                                                ],
                                              ),
                                            )),
                                        Expanded(
                                            child:
                                            GestureDetector(
                                              onTap: () {
                                                logic
                                                    .pickFiles();
                                              },
                                              child: Row(
                                                children: [
                                                  SvgPicture
                                                      .asset(
                                                    AppImages
                                                        .files,
                                                    height:
                                                    25.h,
                                                    width:
                                                    25.w,
                                                  ),
                                                  UiHelper
                                                      .horizontalSpaceSmall,
                                                  Text(
                                                    AppStrings
                                                        .openFiles
                                                        .tr,
                                                    style: AppStyles.primaryStyle(
                                                        fontSize:
                                                        12,
                                                        bold:
                                                        true),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                  backgroundColor:
                                  AppColors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius
                                              .circular(
                                              20.h),
                                          topRight: Radius
                                              .circular(
                                              20.h))));
                              //logic.pickFiles();
                            },
                            child: SvgPicture.asset(
                              AppImages.upload,
                              width: 25.w,
                              height: 25.h,
                            )),
                        UiHelper.horizontalSpaceMedium,
                        Visibility(
                            visible: !(BookingConstants
                                .attachFile !=
                                null ||
                                BookingConstants
                                    .cameraFile !=
                                    null),
                            child: Text(
                              AppStrings
                                  .uploadAttachmentHint
                                  .tr,
                              style: AppStyles
                                  .primaryStyle(
                                  bold: true,
                                  opacity: .5),
                            )),
                        Visibility(
                          visible: BookingConstants
                              .attachFile !=
                              null ||
                              BookingConstants.cameraFile !=
                                  null,
                          child: Expanded(
                              child: ListView(
                                scrollDirection:
                                Axis.horizontal,
                                children: [
                                  if (BookingConstants
                                      .attachFile !=
                                      null)
                                    ViewFileItem(
                                      file: BookingConstants
                                          .attachFile!,
                                      onTab: () {
                                        BookingConstants
                                            .attachFile =
                                        null;
                                        logic.update();
                                      },
                                    ),
                                  if (BookingConstants
                                      .cameraFile !=
                                      null)
                                    ViewFileItem(
                                      file: BookingConstants
                                          .cameraFile!,
                                      onTab: () {
                                        BookingConstants
                                            .cameraFile =
                                        null;
                                        logic.update();
                                      },
                                    ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        UiHelper.verticalSpaceMedium,
      ],
    );
  }
}
