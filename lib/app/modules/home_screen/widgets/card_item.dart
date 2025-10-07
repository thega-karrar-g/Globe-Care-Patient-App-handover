import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme_helper/app_styles.dart';
import '../../../data/models/home_service.dart';

class CardItem extends StatelessWidget {
  CardItem({Key? key, this.homeService, this.primary = false,required this.onTab})
      : super(key: key);

  bool primary = true;
  HomeService? homeService;
Function onTab;
  @override
  Widget build(BuildContext context) {
    return Container(
      //  elevation: 0.1,
      decoration: BoxDecoration(
          //  color:
          //  primary?
          //  AppColors.primaryColor.withOpacity(.05)
          //:AppColors.primaryColorGreen.withOpacity(.05),
          //,
          borderRadius: BorderRadius.circular(10)),

      child: InkWell(
        onTap: () {
        onTab();
        },
        child: Stack(
          children: [
            // Positioned.fill(
            //
            //     child: Image.asset(
            //      // primary?AppImages.maskPrimaryPng : AppImages.maskGreenPng
            //       AppImages.maskPrimaryPng
            //
            //       ,width: Get.width/2,height: 200,fit: BoxFit.fill,)),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(0.0),
                  // color: AppColors.primaryColorGreen,
                  alignment: Alignment.center,
                  // height: 60,
                  //  width: 60,
                  child: Image.asset(
                    homeService!.icon,
                    //     color:primary? AppColors.primaryColor:AppColors.primaryColorGreen,
                    //   color: AppColors.primaryColor,
                    width: primary ? 75.w : 65.w,
                    height: primary ? 75.h : 65.h,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Expanded(
                  child: Container(
                    //     color: AppColors.primaryColorOpacity,
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(homeService!.name.tr,
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyles.primaryStyle(
                                  bold: true,
                                  fontSize: primary ? 12 : 10,
                                  height: 1.5)
                              //  :AppStyles.primaryStyleGreen(bold: true,size: 10.sp,height: 1.5),
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
