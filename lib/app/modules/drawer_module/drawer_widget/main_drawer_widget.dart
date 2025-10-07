import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_colors.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../data/constants/booking_constants.dart';
import '../../../global_widgets/shared/drawer_link_widget.dart';
import '../../../global_widgets/shared/dynamic_column.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../global_widgets/ui.dart';
import '../../../routes/app_route_names.dart';
import '../../../core/assets_helper/app_images.dart';
import '../../../utils/launcher.dart';
import 'main_drawer_controller.dart';

class MainDrawerWidget extends StatelessWidget {
  const MainDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width * 0.0;

    return GetBuilder<MainDrawerWidgetController>(
      init: MainDrawerWidgetController(),
      builder: (controller) {
        return Container(
          width: Get.width * .8,
          margin: EdgeInsets.only(right: w, top: 24.h, bottom: 2.h),
          child: ClipRRect(
            borderRadius: borderRadius,
            child: Drawer(
              child: Container(
                width: Get.width * .6,
                // color: Colors.red,
                // width: 200,
                //  width: MediaQuery.of(context).size.width * 0.3,

                decoration: BoxDecoration(
                    borderRadius: borderRadius, color: AppColors.primaryColor),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned.fill(
                        //bottom: 10,
                        //  top: 200,
                        child: Align(
                      //alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        AppImages.drawerBgPng,
                        width: Get.width * .9,
                        height: Get.height,
                        fit: BoxFit.fill,
                      ),
                    )),
                    Column(
                      children: [
                        Stack(
                          children: [
                            DynamicColumn(
                              children: [
                                SizedBox(
                                  height: 40.h,
                                ),
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // UiHelper.horizontalSpaceLarge,

                                      CircleAvatar(
                                        radius: 25.h,
                                        backgroundColor: AppColors.white,
                                        child: Ui.circularImgAsset(
                                            url: AppImages.logoOnly,
                                            errorImg: AppImages.logoOnly,
                                            size: 80,
                                            margin: 3),
                                      ),
                                      // UiHelper.horizontalSpaceSmall,
                                      // Text(
                                      //   AppStrings.appTitle.tr,
                                      //   style: AppStyles.whiteStyle(bold: true,size: 15),
                                      //   maxLines: 3,
                                      //   // textAlign: TextAlign.end,
                                      // ),
                                    ],
                                  ),
                                ),
                                UiHelper.verticalSpaceMedium,
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 5.h),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 5.h),
                                  decoration: BoxDecoration(
                                      color: AppColors.drawerItemColor
                                          .withOpacity(.4),
                                      borderRadius:
                                          BorderRadius.circular(10.h)),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          AppStrings.license.tr,
                                          // maxLines: 1,
                                          // overflow: TextOverflow.fade,
                                          //softWrap: false,
                                          style: TextStyle(
                                              color:
                                                  AppColors.white.withOpacity(
                                                .7,
                                              ),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10.sp,
                                              height: 1.5),
                                        ),
                                      ),
                                      Ui.circularImgAsset(
                                          url: AppImages.mohLogo,
                                          errorImg: AppImages.mohLogo,
                                          size: 50,
                                          margin: 3),
                                    ],
                                  ),
                                ),
                                UiHelper.verticalSpaceSmall,
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.toNamed(AppRouteNames.aboutUs);
                                        },
                                        child: Container(
                                          // width: 130,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.h, horizontal: 20.w),
                                          margin: EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 20.w),
                                          decoration: BoxDecoration(
                                              color:
                                                  AppColors.primaryColorGreen,
                                              borderRadius:
                                                  BorderRadius.circular(5.h)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                AppStrings.about.tr,
                                                style: AppStyles.whiteStyle(
                                                    bold: true),
                                              ),
                                              //UiHelper.horizontalSpaceSmall,
                                              // Icon(Icons.edit,color: AppColors.white,)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        UiHelper.verticalSpaceSmall,
                        Expanded(
                          child: Container(
                            decoration:
                                BoxDecoration(color: AppColors.primaryColor),
                            child: SingleChildScrollView(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: AnimationLimiter(
                                child: DynamicColumn(children: [
                                  // listTile(AppStrings.pages),
                                  DrawerLinkWidget(
                                    icon: AppImages.home,
                                    text: AppStrings.home.tr,
                                    subtitle: 'PROFILE_HINT'.tr,
                                    onTap: () {
                                      // Get.back();
                                      if (Get.currentRoute !=
                                          AppRouteNames.homeTabs) {
                                        Get.offAllNamed(AppRouteNames.homeTabs);
                                      } else {
                                        Get.back();
                                      }
                                      //   Get.toNamed(Routes.PROFILE, arguments: authService.user.value);

                                      //  Get.find<RootController>().changePage(1);
                                    },
                                  ),

// listTile(AppStrings.applicationPreferences) ,

                                  // DrawerLinkWidget(
                                  //   icon: AppImages.language,
                                  //   text: AppStrings.language,
                                  //   subtitle: AppStrings.langHint.tr,
                                  //   onTap: () {
                                  //     Get.offAndToNamed(AppRouteNames.language);
                                  //   },
                                  // ),
                                  DrawerLinkWidget(
                                    icon: AppImages.language,
                                    text: AppStrings.ourServices,
                                    onTap: () {
                                      //  Get.to(()=>OurServices());

                                      Get.toNamed(AppRouteNames.intro);
                                    },
                                  ),
                                  DrawerLinkWidget(
                                    icon: AppImages.language,
                                    text: AppStrings.patientResponsibilities,
                                    onTap: () {
                                      Get.offAndToNamed(AppRouteNames
                                          .patientResponsibilities);
                                    },
                                  ),

                                  DrawerLinkWidget(
                                    icon: AppImages.privacy,
                                    text: AppStrings.termsAndConditions.tr,
                                    subtitle: 'PRIVACY_HINT'.tr,
                                    onTap: () {
                                      Get.toNamed(AppRouteNames.termsOfService,
                                          arguments: false);
                                      // Get.offAndToNamed(Routes.PRIVACY);
                                      //  Launcher.launchInBrowser(AppStrings.appWebUrl);
                                    },
                                  ),
                                  DrawerLinkWidget(
                                    icon: AppImages.privacy,
                                    text: AppStrings.privacyPolicy.tr,
                                    subtitle: 'PRIVACY_HINT'.tr,
                                    onTap: () {
                                      //  Get.to(StepCounterPage());
                                      // Get.offAndToNamed(Routes.PRIVACY);
                                      Get.toNamed(AppRouteNames.privacyPolicy,
                                          arguments: false);
                                    },
                                  ),
                                  // DrawerLinkWidget(
                                  //   icon: AppImages.privacy,
                                  //   text: AppStrings.changeLanguage.tr,
                                  //   subtitle: 'PRIVACY_HINT'.tr,
                                  //   onTap: () {
                                  //     //  Get.to(StepCounterPage());
                                  //     // Get.offAndToNamed(Routes.PRIVACY);
                                  //     Get.toNamed(AppRouteNames.language,);
                                  //   },
                                  // ),

                                  listTile(AppStrings.helpAndSupport),

                                  DrawerLinkWidget(
                                    icon: AppImages.help,
                                    text: AppStrings.contactUs,
                                    subtitle: 'HELP_HINT'.tr,
                                    onTap: () {
                                      Get.toNamed(AppRouteNames.contactUs);
                                      // Get.offAndToNamed(Routes.HELP);
                                      //  Launcher.launchInBrowser(AppStrings.APP_WEB_URL);
                                    },
                                  ),
                                  // DrawerLinkWidget(
                                  //   icon: AppImages.help,
                                  //   text: AppStrings.reportProblem,
                                  //   subtitle: 'HELP_HINT'.tr,
                                  //   onTap: () {
                                  //     //  Launcher.launchInBrowser(AppStrings.appWebUrl);
                                  //
                                  //     //     Get.toNamed(AppRouteNames.register);
                                  //     // Get.offAndToNamed(Routes.HELP);
                                  //     //  Launcher.launchInBrowser(AppStrings.APP_WEB_URL);
                                  //   },
                                  // ),
                                  DrawerLinkWidget(
                                    icon: AppImages.help,
                                    text: AppStrings.faq,
                                    subtitle: 'HELP_HINT'.tr,
                                    onTap: () {
                                      //  Get.toNamed(AppRouteNames.faq);
                                      controller.soonMessage();
                                      //  Launcher.launchInBrowser(AppStrings.appWebUrl);

                                      //     Get.toNamed(AppRouteNames.register);
                                      // Get.offAndToNamed(Routes.HELP);
                                      //  Launcher.launchInBrowser(AppStrings.APP_WEB_URL);
                                    },
                                  ),
                                  // DrawerLinkWidget(
                                  //   icon: AppImages.help,
                                  //   text: AppStrings.suggestion,
                                  //   subtitle: 'HELP_HINT'.tr,
                                  //   onTap: () {
                                  //     //  Launcher.launchInBrowser(AppStrings.appWebUrl);
                                  //
                                  //     //     Get.toNamed(AppRouteNames.register);
                                  //     // Get.offAndToNamed(Routes.HELP);
                                  //     //  Launcher.launchInBrowser(AppStrings.APP_WEB_URL);
                                  //   },
                                  // ),
                                ]),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                if (controller.checkUserSignIn) {
                                  BookingConstants.fromPatientData = null;
                                  controller.logUserOut();
                                } else {
                                  Get.toNamed(AppRouteNames.login);
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 20.w),
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 50.w),
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColorGreen,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.checkUserSignIn
                                          ? AppStrings.logout.tr
                                          : AppStrings.logIn.tr,
                                      style: AppStyles.whiteStyle(bold: true),
                                    ),
                                    UiHelper.horizontalSpaceSmall,
                                    SvgPicture.asset(
                                      AppImages.logout,
                                      color: AppColors.white,
                                      width: 20.w,
                                      height: 20.h,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                        UiHelper.verticalSpaceSmall,
                        GestureDetector(
                          onTap: () {
                            Launcher.launchInBrowser(AppStrings.poweredByUrl);
                          },
                          child: Text(
                            AppStrings.poweredBy.tr,
                            style: AppStyles.whiteStyle(bold: true, size: 12),
                            maxLines: 3,
                            // textAlign: TextAlign.end,
                          ),
                        ),
                        UiHelper.verticalSpace(30),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static const double radius = 80;

  BorderRadius get borderRadius {
    return Get.locale.toString() == 'ar'
        ? const BorderRadius.only(
            topLeft: Radius.circular(radius),
            bottomLeft: Radius.circular(radius),
          )
        : const BorderRadius.only(
            topRight: Radius.circular(radius),
            bottomRight: Radius.circular(radius),
          );
  }

  Widget listTile(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: Row(
        children: [
          Text(
            title.tr.toUpperCase(),
            style: AppStyles.whiteStyle(size: 13),
          ),
        ],
      ),
    );
  }
}
