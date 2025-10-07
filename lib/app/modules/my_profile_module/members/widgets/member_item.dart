import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/assets_helper/app_images.dart';
import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../core/theme_helper/app_colors.dart';
import '../../../../core/theme_helper/app_styles.dart';
import '../../../../data/models/user_model.dart';
import '../../../../global_widgets/shared/ui_helpers.dart';
import '../../../../global_widgets/ui.dart';
import '../../../../routes/app_route_names.dart';
import '../../../medical_file_module/member_medical_file/member_medical_file_view.dart';

class MemberItem extends StatelessWidget {
  const MemberItem({Key? key, required this.member}) : super(key: key);
  final AppUser member;

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      decoration: BoxDecoration(
          color: AppColors.primaryColorOpacity,
          borderRadius: BorderRadius.circular(10.h)),
      child: Row(
        children: [
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // CircleAvatar(
                    //   radius: 16.h,
                    //
                    //   backgroundColor: AppColors.primaryColor,
                    //   child: Padding(
                    //     padding:  EdgeInsets.only(bottom: 5.h),
                    //     child: Text(member.name.characters.first,textAlign: TextAlign.center,style: AppStyles.whiteStyle(bold: false,size: 15),),
                    //   ),
                    // ),

                    // UiHelper.horizontalSpaceMedium,
                    Text(
                      member.name,
                      style: AppStyles.primaryStyle(bold: true, fontSize: 15),
                    ),
                  ],
                ),
                UiHelper.verticalSpaceMedium,
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppImages.gender,
                            width: 18.w,
                            height: 18.h,
                          ),
                          UiHelper.horizontalSpaceSmall,
                          Expanded(
                              child: Text(
                            member.gender!.tr,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                AppStyles.subTitleStyle(bold: true, size: 13),
                          ))
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Text(
                            AppStrings.age.tr,
                            style: AppStyles.primaryStyle(bold: true, fontSize: 12),
                          ),
                          UiHelper.horizontalSpaceSmall,
                          Text(
                            '${member.age!.split(' ')[0]}  ${AppStrings.yearsOld.tr}',
                            style:
                                AppStyles.subTitleStyle(bold: true, size: 12),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                UiHelper.verticalSpaceMedium,
                Row(
                  children: [
                    Expanded(
                        child: Ui.primaryButtonOutlined(
                            title: AppStrings.showAppointment,
                            paddingV: 8,
                            paddingH: 5,
                            marginH: 3,
                            marginV: 3,
                            color: AppColors.primaryColorOpacity,
                            radius: 5,
                            fontSize: 11,
                            onTab: () {
                              Get.toNamed(AppRouteNames.appointmentMemberTypes,
                                  arguments: member);
                            })),

                    UiHelper.horizontalSpaceSmall,
                    Expanded(
                        child: Ui.primaryButtonOutlined(
                            title: '${AppStrings.show.tr} ${AppStrings.medicalFile.tr}',
                            paddingV: 8,
                            paddingH: 5,
                            marginH: 3,
                            marginV: 3,
                            color: AppColors.primaryColorOpacity,
                            radius: 5,
                            fontSize: 11,
                            onTab: () {
                              Get.toNamed(MemberMedicalFilePage.routeName,
                                  arguments: member);
                            })),

                    // Expanded(child: Ui.primaryButtonOutlined(title: AppStrings.delete,paddingV: 5,paddingH: 5,marginH: 3,marginV: 3,color: AppColors.primaryColorOpacity,radius: 5,fontSize: 12)),
                  ],
                )
              ],
            ),
          )),
          // Column(
          //   children: [
          //     Container(
          //       padding: EdgeInsets.symmetric(vertical: 3.h,horizontal: 10.w),
          //       decoration: BoxDecoration(color: AppColors.primaryColorGreen,
          //
          //           borderRadius: BorderRadius.only(
          //             topLeft: Radius.circular(ar?0:5.h),
          //             bottomLeft: Radius.circular(ar?0:5.h),
          //
          //
          //             bottomRight: Radius.circular(ar?5.h:0),
          //             topRight: Radius.circular(ar?5.h:0),
          //
          //           )
          //       ),
          //       child: Icon(Icons.edit,color: AppColors.white,size: 20.w,),
          //
          //     ),
          //     UiHelper.verticalSpaceMedium,
          //     Container(
          //       padding: EdgeInsets.symmetric(vertical: 3.h,horizontal: 10.w),
          //       decoration: BoxDecoration(color: AppColors.primaryColor,
          //
          //           borderRadius: BorderRadius.only(
          //             topLeft: Radius.circular(ar?0:5.h),
          //             bottomLeft: Radius.circular(ar?0:5.h),
          //
          //
          //             bottomRight: Radius.circular(ar?5.h:0),
          //             topRight: Radius.circular(ar?5.h:0),
          //
          //           )
          //       ),
          //       child: Icon(Icons.delete,color: AppColors.white,size: 20.w,),
          //
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
