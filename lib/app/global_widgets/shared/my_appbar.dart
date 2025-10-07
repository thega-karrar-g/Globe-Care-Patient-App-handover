import 'dart:math' as math; // import this

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:globcare/app/base_controller/base_controller.dart';
import 'package:globcare/app/global_widgets/shared/notification_badge_widget.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../core/language_and_localization/app_strings.dart';
import '../../core/theme_helper/app_colors.dart';
import '../../core/theme_helper/app_styles.dart';
import '../../data/models/slides_model.dart';
import '../../routes/app_route_names.dart';
import '../../core/assets_helper/app_images.dart';
import '../../utils/launcher.dart';
import 'different_dialogs.dart';
import 'ui_helpers.dart';

GetStorage box = GetStorage();
final GlobalKey languageKey = GlobalKey();
final GlobalKey infoKey = GlobalKey();
final double iconSize = 30.w;
final ar = Get.locale.toString() == 'ar';

Widget myAppBar(
    {String title = '',
    double h = 40,
    Color color = AppColors.white,
    withBack = true}) {
  return Container(
    //  color: color,
    margin: EdgeInsets.only(top: h.h, bottom: 20.h),
    child: Row(
      children: [
        SizedBox(
          width: Get.width * .08,
        ),
        if (withBack)
          GestureDetector(
              onTap: () => Get.back(),
              child: Icon(
                Icons.arrow_back_ios_outlined,
                color: AppColors.primaryColor,
              )),
        SizedBox(
          width: Get.width * .1,
        ),
        Expanded(
            child: Text(
          title.tr,
          style: (
              TextStyle(color: AppColors.black, fontWeight: FontWeight.bold)),
        )),
      ],
    ),
  );
}

Widget myAppBar2(
    {String title = '',
    double h = 20,
    Color color = AppColors.white,
    withBack = true,
    bool isHome = false,
    bool showAll = false,Function? onBack,Widget? actionBesideTitle}) {

  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        //  color: color,
        margin: EdgeInsets.only(top: h.h, bottom: isHome ? 0 : 5.h),
        child: Row(
          children: [
            // SizedBox(width: Get.width*.08,),
            if (withBack)
              GestureDetector(
                  onTap: () {

                    if(onBack ==null){
                    Get.back();}
                    else{

                      onBack();

                    }


                    },
                  child: RotatedBox(
                      quarterTurns: Get.locale.toString() == 'ar' ? 2 : 0,
                      child: SvgPicture.asset(
                        AppImages.back,
                        width: iconSize,
                        height: iconSize,
                      ))),

            if (isHome)
              Image.asset(
                AppImages.logoSvg,
                width: 50.w,
                height: 50.h,
              ),

            Spacer(),

            GestureDetector(
                onTap: () {
                  Launcher.phoneCall(AppStrings.contactUsNo);
                  //  Get.toNamed(AppRouteNames.receiptPage);
                },
                //  onTap: ()=>Get.back(),
                child: Image.asset(
                  AppImages.customerService2,
                  width: 25.w,
                  height: 25.h,
                )),
            UiHelper.horizontalSpaceLarge,
            // GestureDetector(
            //     onTap: () {
            //       Get.toNamed(AppRouteNames.language);
            //     }
            //     ,
            //     //  onTap: ()=>Get.back(),
            //     child: Icon(
            //       Icons.language, color: AppColors.primaryColor,size: iconSize)),
            // UiHelper.horizontalSpaceMedium,

            NotificationBadgeWidget(),
            UiHelper.horizontalSpaceMedium,

            //  UiHelper.horizontalSpaceLarge,

            Builder(builder: (context) {
              return GestureDetector(
                  // onTap: () => Scaffold.of(context).openDrawer(),
                  onTap: () {
                    Get.offAllNamed(AppRouteNames.homeTabs);
                  },
                  child: SvgPicture.asset(
                    AppImages.home,
                    color: AppColors.primaryColor,
                    width: iconSize.w,
                    height: iconSize.h - 5.h,
                  ));
            }),
          ],
        ),
      ),
      Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: isHome ? 0 : 5.h, bottom: 5.h),
              child: Row(
                children: [
                  if (!isHome)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IntrinsicWidth(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title.tr,
                                    maxLines: 2,
                                    style: AppStyles.primaryStyle(
                                        fontSize: 18,
                                        bold: true,
                                        height: ar ? 1.3 : 1.0),
                                  ),

                                  // Text(t.last,maxLines: 2,style: AppStyles.primaryStyle(size: 20,bold: true,height: ar?1.3:1.0),),
                                  // UiHelper.verticalSpace(5),

                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(top: 5.h),
                                          height: 5.h,
                                          //  width: Get.width*.3,
                                          decoration: BoxDecoration(
                                              color:
                                                  AppColors.primaryColorGreen,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  UiHelper.verticalSpace(5.h),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // if(isHome)
                  //
                  //   Text(' , ',maxLines: 2,style: AppStyles.primaryStyle(size: 30,bold: true),),

                  if (!isHome) UiHelper.verticalSpaceSmall,

                  // if(isHome)
                  // Text(AppStrings.haveNiceDay.tr,maxLines: 2,style: AppStyles.subTitleStyle(size: 20,),),
                ],
              ),
            ),
          ),
          if(actionBesideTitle !=null)
            actionBesideTitle
        ],
      ),
      if (withBack && !isHome) UiHelper.verticalSpaceSmall,
    ],
  );
}

Widget myAppBarPayment(
    {String title = '',
    double h = 20,
    Color color = AppColors.white,
    withBack = true,
    bool isHome = false,
    bool showAll = false}) {

  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        //  color: color,
        margin: EdgeInsets.only(top: h, bottom: isHome ? 0 : 5.h),
        child: Row(
          children: const [
            // // SizedBox(width: Get.width*.08,),
            // if(withBack)
            //   GestureDetector(
            //       onTap: () => Get.back(),
            //       child: RotatedBox(
            //           quarterTurns: Get.locale.toString() == 'ar' ? 2 : 0,
            //           child: SvgPicture.asset(AppImages.back))),
            //
            // if(isHome) Image.asset(
            //   AppImages.logoSvg, width: 50, height: 50,)
            // ,
            //
            //
            // Spacer(),
            //
            //
            // GestureDetector(
            //     onTap: () {
            //       Get.toNamed(AppRouteNames.language);
            //     }
            //     ,
            //     //  onTap: ()=>Get.back(),
            //     child: Icon(
            //       Icons.language, color: AppColors.primaryColor,)),
            // UiHelper.horizontalSpaceLarge,
            //
            // GestureDetector(
            //     onTap: () {
            //       //  Get.to(PaymentWebviewPage());
            //       //BookInvoiceLogic().performtrxn();
            //       //AppointmentBaseController().performtrxn(transType: 'applepay',orderId: '121');
            //      // AppointmentBaseController().soonMessage();
            //
            //        Get.toNamed(AppRouteNames.notifications);
            //     }
            //     ,
            //     //  onTap: ()=>Get.back(),
            //     child: SvgPicture.asset(AppImages.notification)),
            // UiHelper.horizontalSpaceLarge,
            //
            //
            //   UiHelper.horizontalSpaceLarge,
            // GestureDetector(
            //     onTap: () {
            //       Launcher.phoneCall(AppStrings.contactUsNo);
            //       //  Get.toNamed(AppRouteNames.receiptPage);
            //     }
            //     ,
            //     //  onTap: ()=>Get.back(),
            //     child: Image.asset(AppImages.call,width: 30,height: 30,)),
            //
            //
            // Builder(
            //     builder: (context) {
            //       return GestureDetector(
            //           onTap: () => Scaffold.of(context).openDrawer(),
            //           child: SvgPicture.asset(AppImages.menu));
            //     }
            // ),
          ],
        ),
      ),
      Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: isHome ? 0 : 5.h, bottom: 5.h),
              child: Row(
                children: [
                  if (!isHome)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IntrinsicWidth(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title.tr,
                                    maxLines: 2,
                                    style: AppStyles.primaryStyle(
                                        fontSize: 20,
                                        bold: true,
                                        height: ar ? 1.3 : 1.0),
                                  ),

                                  // Text(t.last,maxLines: 2,style: AppStyles.primaryStyle(size: 20,bold: true,height: ar?1.3:1.0),),
                                  // UiHelper.verticalSpace(5),

                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(top: 5),
                                          height: 5.h,
                                          //  width: Get.width*.3,
                                          decoration: BoxDecoration(
                                              color:
                                                  AppColors.primaryColorGreen,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  UiHelper.verticalSpace(5.h),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // if(isHome)
                  //
                  //   Text(' , ',maxLines: 2,style: AppStyles.primaryStyle(size: 30,bold: true),),

                  if (!isHome) UiHelper.verticalSpaceSmall,

                  // if(isHome)
                  // Text(AppStrings.haveNiceDay.tr,maxLines: 2,style: AppStyles.subTitleStyle(size: 20,),),
                ],
              ),
            ),
          ),
        ],
      ),
      if (withBack && !isHome) UiHelper.verticalSpaceSmall,
    ],
  );
}

Widget myAppBarHome(
    {String title = '',
    double h = 20,
    Color color = AppColors.white,
    withBack = true,
    bool isHome = false,
    bool showAll = false}) {

  return ShowCaseWidget(builder: (context) {
    if (box.read('langHint') == null) {
      WidgetsBinding.instance.addPostFrameCallback(
              (_) => ShowCaseWidget.of(context).startShowCase([languageKey]));

      box.write('langHint', true);
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          //  color: color,
          margin: EdgeInsets.only(top: h.h, bottom: isHome ? 0 : 5.h),
          child: Row(
            children: [
              // SizedBox(width: Get.width*.08,),
              if (withBack)
                GestureDetector(
                    onTap: () => Get.back(),
                    child: RotatedBox(
                        quarterTurns: Get.locale.toString() == 'ar' ? 2 : 0,
                        child: SvgPicture.asset(
                          AppImages.back,
                          width: iconSize,
                          height: iconSize,
                        ))),

              if (isHome)
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRouteNames.aboutUs);
                  },
                  child: Image.asset(
                    AppImages.logoSvg,
                    width: 50.w,
                    height: 50.h,
                  ),
                ),

              Spacer(),

              // GestureDetector(
              //     onTap: () {
              //       Launcher.phoneCall(AppStrings.contactUsNo);
              //     //  Get.toNamed(AppRouteNames.receiptPage);
              //     }
              //     ,
              //     //  onTap: ()=>Get.back(),
              //     child: Image.asset(AppImages.hotLine,width: 30,height: 30,)),
              GestureDetector(
                  onTap: () {
                    Launcher.openWhatsApp(AppStrings.whatsappNo);
                    // Get.toNamed(AppRouteNames.verify);
                  },
                  //  onTap: ()=>Get.back(),
                  child: Image.asset(
                    AppImages.whatsappPng,
                    width: 25.w,
                    height: 25.h,
                  )),

              UiHelper.horizontalSpaceLarge,
              GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRouteNames.language);
                  },
                  //  onTap: ()=>Get.back(),
                  child: Icon(
                    Icons.language,
                    color: AppColors.primaryColor,
                    size: iconSize,
                  )),
              UiHelper.horizontalSpaceLarge,

             NotificationBadgeWidget(),
              UiHelper.horizontalSpaceLarge,

              //  UiHelper.horizontalSpaceLarge,

              Builder(builder: (context) {
                return GestureDetector(
                    onTap: () => Scaffold.of(context).openDrawer(),
                    child: SvgPicture.asset(
                      AppImages.menu,
                      width: iconSize,
                      height: iconSize,
                    ));
              }),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: isHome ? 0 : 5, bottom: 5),
                child: Row(
                  children: [
                    if (!isHome)
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 5.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IntrinsicWidth(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title.tr,
                                      maxLines: 2,
                                      style: AppStyles.primaryStyle(
                                          fontSize: 20,
                                          bold: true,
                                          height: ar ? 1.3 : 1.0),
                                    ),

                                    // Text(t.last,maxLines: 2,style: AppStyles.primaryStyle(size: 20,bold: true,height: ar?1.3:1.0),),
                                    // UiHelper.verticalSpace(5),

                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(top: 5.h),
                                            height: 5,
                                            //  width: Get.width*.3,
                                            decoration: BoxDecoration(
                                                color:
                                                AppColors.primaryColorGreen,
                                                borderRadius:
                                                BorderRadius.circular(20)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    UiHelper.verticalSpace(5),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    // if(isHome)
                    //
                    //   Text(' , ',maxLines: 2,style: AppStyles.primaryStyle(size: 30,bold: true),),

                    if (!isHome) UiHelper.verticalSpaceSmall,

                    // if(isHome)
                    // Text(AppStrings.haveNiceDay.tr,maxLines: 2,style: AppStyles.subTitleStyle(size: 20,),),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (withBack && !isHome) UiHelper.verticalSpaceSmall,
      ],
    );
  });
}

Widget myAppBarLocation(
    {String title = '',
    double h = 20,
    Color color = AppColors.white,
    withBack = true,
    bool isHome = false,
    bool showAll = false}) {


  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        //  color: color,
        margin: EdgeInsets.only(top: h.h, bottom: isHome ? 0 : 5),
        child: Row(
          children: [
            // SizedBox(width: Get.width*.08,),
            if (withBack)
              GestureDetector(
                  onTap: () => Get.back(),
                  child: RotatedBox(
                      quarterTurns: Get.locale.toString() == 'ar' ? 2 : 0,
                      child: SvgPicture.asset(AppImages.back,
                          width: iconSize, height: iconSize))),

            if (isHome)
              Image.asset(
                AppImages.logoSvg,
                width: 50.w,
                height: 50.h,
              ),

            Spacer(),

            // Showcase(
            //   description: AppStrings.languageHint.tr,
            //   descTextStyle:AppStyles.primaryStyle(),
            //   radius: BorderRadius.circular(30),
            //   overlayPadding: EdgeInsets.all(15),
            //   key: languageKey,
            //   contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 20),
            //   child: GestureDetector(
            //       onTap: (){
            //
            //
            //
            //         Get.toNamed(AppRouteNames.language);
            //       }
            //       ,
            //       //  onTap: ()=>Get.back(),
            //       child: Icon(Icons.language,color: AppColors.primaryColor,)),
            // ),
            // UiHelper.horizontalSpaceLarge,

            NotificationBadgeWidget(),
            UiHelper.horizontalSpaceLarge,

            //  UiHelper.horizontalSpaceLarge,

            Builder(builder: (context) {
              return GestureDetector(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: SvgPicture.asset(
                    AppImages.menu,
                    width: iconSize,
                    height: iconSize,
                  ));
            }),
          ],
        ),
      ),
      Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: isHome ? 0 : 5.h, bottom: 5.h),
              child: Row(
                children: [
                  if (!isHome)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IntrinsicWidth(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title.tr,
                                    maxLines: 2,
                                    style: AppStyles.primaryStyle(
                                        fontSize: 20,
                                        bold: true,
                                        height: ar ? 1.3 : 1.0),
                                  ),

                                  // Text(t.last,maxLines: 2,style: AppStyles.primaryStyle(size: 20,bold: true,height: ar?1.3:1.0),),
                                  // UiHelper.verticalSpace(5),

                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(top: 5.h),
                                          height: 5.h,
                                          //  width: Get.width*.3,
                                          decoration: BoxDecoration(
                                              color:
                                                  AppColors.primaryColorGreen,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  UiHelper.verticalSpace(5),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // if(isHome)
                  //
                  //   Text(' , ',maxLines: 2,style: AppStyles.primaryStyle(size: 30,bold: true),),

                  if (!isHome) UiHelper.verticalSpaceSmall,

                  // if(isHome)
                  // Text(AppStrings.haveNiceDay.tr,maxLines: 2,style: AppStyles.subTitleStyle(size: 20,),),
                ],
              ),
            ),
          ),
        ],
      ),
      if (withBack && !isHome) UiHelper.verticalSpaceSmall,
    ],
  );
}

Widget myAppBarServices(
    {String title = '',
    double h = 20,
    Color color = AppColors.white,
    withBack = true,
    bool isHome = false,
    bool showAll = false,
    String code = '',Function? onBack}) {
  var t = title.tr.toUpperCase().split(' ');
  var newTitle = '';

  if (showAll) {
    for (var element in t) {
      if (element != t.last) {
        newTitle += '$element ';
      }
    }
  } else {
    newTitle = t.first;

    if (t.length > 2) {
      newTitle += ' ${t[1]}';
    }
    if (!isHome) {
      // newTitle+='\n'+t.last;
    }
  }

  return ShowCaseWidget(builder: (context) {
    if (box.read('infoHint') == null) {
      WidgetsBinding.instance.addPostFrameCallback(
              (_) => ShowCaseWidget.of(context).startShowCase([infoKey]));

      box.write('infoHint', true);
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          //  color: color,
          margin: EdgeInsets.only(top: h, bottom: isHome ? 0 : 5.h),
          child: Row(
            children: [
              // SizedBox(width: Get.width*.08,),
              if (withBack)
                GestureDetector(
                    onTap: () {

                      if(onBack ==null) {
                        Get.back();
                      }
                      else{
                        onBack();
                      }


                    },
                    child: RotatedBox(
                        quarterTurns: Get.locale.toString() == 'ar' ? 2 : 0,
                        child: SvgPicture.asset(
                          AppImages.back,
                          width: iconSize,
                          height: iconSize,
                        ))),

              if (isHome)
                Image.asset(
                  AppImages.logoSvg,
                  width: 50.w,
                  height: 50.h,
                ),

              Spacer(),

              GestureDetector(
                  onTap: () {
                    Launcher.phoneCall(AppStrings.contactUsNo);
                    //  Get.toNamed(AppRouteNames.receiptPage);
                  },
                  //  onTap: ()=>Get.back(),
                  child: Image.asset(
                    AppImages.customerService2,
                    width: 25.w,
                    height: 25.h,
                  )),
              UiHelper.horizontalSpaceMedium,
              // GestureDetector(
              //     onTap: (){
              //
              //
              //
              //       Get.toNamed(AppRouteNames.language);
              //     }
              //     ,
              //     //  onTap: ()=>Get.back(),
              //     child: Icon(Icons.language,color: AppColors.primaryColor,size: iconSize,)),
              // UiHelper.horizontalSpaceMedium,

              Showcase(
                description: AppStrings.infoHint.tr,
                descTextStyle: AppStyles.primaryStyle(),
                targetBorderRadius: BorderRadius.circular(30.h),
                tooltipPadding:
                EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                key: infoKey,
                targetPadding:
                EdgeInsets.symmetric(horizontal: 5.w, vertical: 20.h),
                child: GestureDetector(
                    onTap: () {
                      //  Get.to(PaymentWebviewPage());
                      //BookInvoiceLogic().performtrxn();
                      //AppointmentBaseController().performtrxn();

                      var slide = SliderModel.slides
                          .where(
                            (element) => element.code == code,
                      )
                          .first;
                      DifferentDialog.showServiceInfoSnackBar(
                          description: slide.description.tr,
                          title: slide.title.tr,
                          image: slide.image);
                      // Get.toNamed(AppRouteNames.notifications);
                    },
                    //  onTap: ()=>Get.back(),
                    child: SvgPicture.asset(
                      AppImages.info,
                      color: AppColors.primaryColor,
                      height: iconSize,
                      width: iconSize,
                    )),
              ),
              UiHelper.horizontalSpaceMedium,

              //  UiHelper.horizontalSpaceLarge,

              Builder(builder: (context) {
                return GestureDetector(
                  // onTap: () => Scaffold.of(context).openDrawer(),

                    onTap: () {
                      Get.offAllNamed(AppRouteNames.homeTabs);
                    },
                    child: SvgPicture.asset(
                      AppImages.home,
                      color: AppColors.primaryColor,
                      width: iconSize.h - 5.h,
                      height: iconSize.h - 5.h,
                    ));
              }),
            ],
          ),
        ),

        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: isHome ? 0 : 5.h, bottom: 5.h),
                child: Row(
                  children: [
                    if (!isHome)
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              //  UiHelper.verticalSpace(5),
                              IntrinsicWidth(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title.tr,
                                      maxLines: 2,
                                      style: AppStyles.primaryStyle(
                                          fontSize: 20,
                                          bold: true,
                                          height: ar ? 1.3 : 1.0),
                                    ),
                                    UiHelper.verticalSpace(5),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(top: 5.h),
                                            height: 5.h,
                                            //  width: Get.width*.3,
                                            decoration: BoxDecoration(
                                                color:
                                                AppColors.primaryColorGreen,
                                                borderRadius:
                                                BorderRadius.circular(20)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    UiHelper.verticalSpace(5),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    // if(isHome)
                    //
                    //   Text(' , ',maxLines: 2,style: AppStyles.primaryStyle(size: 30,bold: true),),

                    if (!isHome) UiHelper.verticalSpaceSmall,

                    // if(isHome)
                    // Text(AppStrings.haveNiceDay.tr,maxLines: 2,style: AppStyles.subTitleStyle(size: 20,),),
                  ],
                ),
              ),
            ),
          ],
        ),

        if (withBack && !isHome) UiHelper.verticalSpaceSmall,

        //
        // Container(
        //   padding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
        //   decoration: BoxDecoration(
        //     color: AppColors.primaryColorOpacity,
        //     borderRadius: BorderRadius.circular(5)
        //   ),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //
        //     Text.rich(TextSpan(text:AppStrings.homeVisitPrice.tr,style: AppStyles.subTitleStyle(bold: false,size: 15),
        //
        //     children: [
        //       TextSpan(text: '100   ${AppStrings.currency.tr}',style: AppStyles.primaryStyle(bold: true))
        //     ]
        //     ))
        //
        //   ],),
        // ),
        // UiHelper.verticalSpaceMedium,
      ],
    );
  });
}

Widget myAppBar3(
    {String title = '',
    double h = 20,
    Color color = AppColors.white,
    withBack = true,
    bool isHome = false}) {
  var t = title.tr.toUpperCase().split(' ');

  if (t.length > 1) {
    //newTitle+='\n'+t.last;
  }

  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        //  color: color,
        margin: EdgeInsets.only(top: h.h, bottom: 0),
        child: IntrinsicHeight(
          child: Row(
            children: [
              // SizedBox(width: Get.width*.08,),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      //UiHelper.verticalSpace(8),
                      IntrinsicWidth(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title.tr,
                              maxLines: 2,
                              style: AppStyles.primaryStyle(
                                  fontSize: 20, bold: true, height: ar ? 1.0 : 1.0),
                            ),
                            UiHelper.verticalSpace(5),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 5.h),
                                    height: 5,
                                    //  width: Get.width*.3,
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColorGreen,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Launcher.phoneCall(
                              AppStrings.contactUsNo,
                            );
                            //  Get.toNamed(AppRouteNames.receiptPage);
                          },
                          //  onTap: ()=>Get.back(),
                          child: Image.asset(
                            AppImages.customerService2,
                            width: 25.w,
                            height: 25.h,
                          )),
                      UiHelper.horizontalSpaceMedium,

                      // GestureDetector(
                      //     onTap: () {
                      //       Get.toNamed(AppRouteNames.language);
                      //     }
                      //     ,
                      //     //  onTap: ()=>Get.back(),
                      //     child: Icon(
                      //       Icons.language, color: AppColors.primaryColor,size: iconSize,)),
                      // UiHelper.horizontalSpaceMedium,

                      NotificationBadgeWidget(),

                      UiHelper.horizontalSpaceMedium,

                      Builder(builder: (context) {
                        return GestureDetector(
                            onTap: () => Scaffold.of(context).openDrawer(),
                            child: SvgPicture.asset(
                              AppImages.menu,
                              width: iconSize,
                              height: iconSize,
                            ));
                      }),
                    ],
                  ),
                  Spacer()
                ],
              ),
            ],
          ),
        ),
      ),
      UiHelper.verticalSpaceSmall,
    ],
  );
}

class CallUsWidget extends StatelessWidget {
  const CallUsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        Launcher.phoneCall(AppStrings.contactUsNo);


      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        margin: EdgeInsets.only(
          top: 10,
          bottom: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //    Icon(Icons.call,color: AppColors.white,),
            Transform(
                transform: Matrix4.rotationY(
                    Get.locale.toString() == 'ar' ? math.pi : 0),
                alignment: Alignment.center,
                child: Image.asset(
                  AppImages.customerService,
                  width: 25.w,
                  height: 25.h,
                )),
            UiHelper.horizontalSpaceSmall,
            Text(
              AppStrings.callUs.tr,
              style: AppStyles.whiteStyle(bold: true),
            )
          ],
        ),
      ),
    );
  }
}
