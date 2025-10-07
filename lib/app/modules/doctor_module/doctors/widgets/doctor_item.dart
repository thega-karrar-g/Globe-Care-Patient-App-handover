import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/assets_helper/app_images.dart';
import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../core/theme_helper/app_colors.dart';
import '../../../../core/theme_helper/app_styles.dart';
import '../../../../data/constants/booking_constants.dart';
import '../../../../data/models/m_doctors.dart';
import '../../../../data/models/nurse_service.dart';
import '../../../../global_widgets/shared/ui_helpers.dart';
import '../../../../global_widgets/ui.dart';
import '../../../../routes/app_route_names.dart';
import '../doctors_controller.dart';

class DoctorItemList extends StatelessWidget {
  DoctorItemList({Key? key, this.doctor}) : super(key: key);
  final Doctor? doctor;

  bool ar = Get.locale.toString() == 'ar';

  @override
  Widget build(BuildContext context) {
    var isHVD = DoctorsController.doctorType == 'HVD';


    return GestureDetector(
      onTap: () {
        BookingConstants.price = double.parse(
            isHVD ? doctor!.hvdPrice.toString() : doctor!.telePrice.toString());
        BookingConstants.consultancyType = (doctor!.consultancyType.toString());
        BookingConstants.doctorId = (doctor!.id!);

        if (isHVD) {
          BookingConstants.serviceName = AppStrings.homeVisitDoctor.tr;
          BookingConstants.service = NurseService(
              name: AppStrings.homeVisitDoctor,
              nameAr: 'زيارة طبيب بالمنزل',
              price: BookingConstants.price.toString());
        } else {
          BookingConstants.service = NurseService(
              name: AppStrings.telemedicine,
              nameAr: 'استشارة طبية فيديو',
              price: BookingConstants.price.toString());
        }

        //  print(doctor!.image!.replaceAll('https', 'http'));
        Get.toNamed(AppRouteNames.doctorSchedule, arguments: doctor);
      },
      child: Container(
        //  height: 90,
        decoration: BoxDecoration(
            color: AppColors.primaryColorOpacity,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.h),
              bottomRight: Radius.circular(15.h),
              topLeft: Radius.circular(15.h),
              bottomLeft: Radius.circular(15.h),
            )),
        margin: EdgeInsets.symmetric(vertical: 5.h),
        child: Row(
          children: [
            UiHelper.horizontalSpaceTiny,
            Column(
              children: [
                UiHelper.verticalSpaceSmall,
                UiHelper.verticalSpaceTiny,
                Container(
                  child: Ui.circularImg(
                      url: doctor!.image!,
                      margin: 0,
                      errorImg: AppImages.placeHolder,
                      size: 60,
                      radius: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        // topRight: Radius.circular(ar?20: 0),
                        // topLeft: Radius.circular(ar?0:20),
                        // bottomRight: Radius.circular(20),
                        // bottomLeft: Radius.circular(20),
                        ),
                  ),
                ),
              ],
            ),
            UiHelper.horizontalSpaceTiny,
            Expanded(
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      decoration: BoxDecoration(
                          color: AppColors.primaryColorOpacity,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(ar ? 0 : 15.h),
                            bottomRight: Radius.circular(ar ? 0 : 15.h),
                            topLeft: Radius.circular(ar ? 15.h : 0),
                            bottomLeft: Radius.circular(ar ? 15.h : 0),
                          )),
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                            //     height: 75,
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      ar ? doctor!.nameAr! : doctor!.name!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppStyles.primaryStyle(
                                          bold: true, fontSize: 12),
                                    )),
                                  ],
                                ),
                                UiHelper.verticalSpace(7),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      ' ${ar ? doctor!.jobTitleAr! : doctor!.jobTitle!} ',
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppStyles.subTitleStyle(
                                          bold: true, size: 11),
                                    )),
                                  ],
                                ),
                                UiHelper.verticalSpace(7),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      ar
                                          ? doctor!.specialityAr!
                                          : doctor!.speciality!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppStyles.subTitleStyle(
                                          bold: true, size: 10),
                                    )),
                                  ],
                                ),
                                UiHelper.verticalSpace(5),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      '${ar ? doctor!.employerAr : doctor!.employer!}   ',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppStyles.primaryStyle(
                                          bold: false, fontSize: 10),
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          )),
                          UiHelper.horizontalSpace(5),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5.h, horizontal: 10.w),
                            decoration: BoxDecoration(
                                color: AppColors.primaryColorGreen,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(ar ? 0 : 5.h),
                                  bottomLeft: Radius.circular(ar ? 0 : 5.h),
                                  bottomRight: Radius.circular(ar ? 5.h : 0),
                                  topRight: Radius.circular(ar ? 5.h : 0),
                                )),
                            child: Text(
                              '${isHVD ? doctor!.hvdPrice! : doctor!.telePrice!}   ${AppStrings.currency.tr}',
                              style: AppStyles.whiteStyle(bold: true, size: 12),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
