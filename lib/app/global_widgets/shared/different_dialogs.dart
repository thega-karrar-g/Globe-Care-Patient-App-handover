import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
// import 'package:flutter_app_minimizer/flutter_app_minimizer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:globcare/app/data/models/request_model.dart';
import 'package:globcare/app/global_widgets/project_widget/image_widget/cached_image_widget.dart';
import 'package:globcare/app/modules/home_tabs/home_tabs_view.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../base_controller/base_controller.dart';
import '../../core/language_and_localization/app_strings.dart';
import '../../core/language_and_localization/ar.dart';
import '../../core/theme_helper/app_colors.dart';
import '../../core/theme_helper/app_styles.dart';
import '../../data/models/file_model.dart';
import '../../modules/booking_home_modules/patient_data/widgets/caregiver_contract_details.dart';
import '../../modules/doctor_module/doctors/doctors_controller.dart';
import '../../modules/my_profile_module/my_profile/my_profile_logic.dart';
import '../../modules/qr_scanner/qr_scanner_view.dart';
import '../../modules/webview/webview_page.dart';
import '../../routes/app_route_names.dart';
import '../../core/assets_helper/app_anim.dart';
import '../../core/assets_helper/app_images.dart';
import '../../data/api/app_urls.dart';
import '../../utils/download_controller.dart';
import '../../utils/launcher.dart';
import '../form_widgets/reactive_text_form.dart';
import '../ui.dart';
import 'ui_helpers.dart';

class DifferentDialog {
  DifferentDialog._();

  static bool isShowing = false;
  static bool canPop = true;

  static showProgressDialogOld(
      {String? msg, bool isDismissible = false}) async {
    Get.dialog(
      WillPopScope(
        onWillPop: () {
          return Future.value(canPop);
        },
        child: AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: SizedBox(
            width: Get.mediaQuery.size.width / 2,
            //  height: 100,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                    height: Get.height / 4,
                    child: Lottie.asset(AppAnim.loader)),

                // Row(
                //   children: [
                //
                //
                //     UiHelper.horizontalSpaceMedium,
                //     Expanded(
                //         child: Text(
                //       msg ?? AppStrings.pleaseWait.tr.capitalizeFirst!,
                //       textAlign: TextAlign.center,
                //       style: Get.textTheme.subtitle1!.copyWith(
                //         color: Colors.black,
                //       ),
                //     )),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: isDismissible,
    );
  }

  static showAnimatedProgressDialog(
      {String? msg, bool isDismissible = false}) async {
    Get.dialog(
        WillPopScope(
          onWillPop: () {
            return Future.value(canPop);
          },
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            content: SizedBox(
              width: Get.mediaQuery.size.width / 2,
              //  height: 100,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                      height: Get.height / 4,
                      child: Lottie.asset(AppAnim.loader)),

                  // Row(
                  //   children: [
                  //
                  //
                  //     UiHelper.horizontalSpaceMedium,
                  //     Expanded(
                  //         child: Text(
                  //       msg ?? AppStrings.pleaseWait.tr.capitalizeFirst!,
                  //       textAlign: TextAlign.center,
                  //       style: Get.textTheme.subtitle1!.copyWith(
                  //         color: Colors.black,
                  //       ),
                  //     )),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ));
  }

  static showImageDialog(
      {String? msg, bool isDismissible = true, File? file}) async {
    Get.dialog(
        WillPopScope(
          onWillPop: () {
            return Future.value(canPop);
          },
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            content: SizedBox(
              width: Get.mediaQuery.size.width / 2,
              //  height: 100,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.clear,
                        color: AppColors.primaryColor,
                      )),

                  UiHelper.verticalSpaceMedium,

                  SizedBox(
                    height: Get.height * .5,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          File(file!.path),
                          fit: BoxFit.contain,
                          alignment: Alignment.center,
                        )),
                  ),

                  // Row(
                  //   children: [
                  //
                  //
                  //     UiHelper.horizontalSpaceMedium,
                  //     Expanded(
                  //         child: Text(
                  //       msg ?? AppStrings.pleaseWait.tr.capitalizeFirst!,
                  //       textAlign: TextAlign.center,
                  //       style: Get.textTheme.subtitle1!.copyWith(
                  //         color: Colors.black,
                  //       ),
                  //     )),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ));
  }




  static showJitsiAndroid14ImageHintDialog(
      {String? msg, bool isDismissible = true,required Function onContinue}) async {
    Get.dialog(
        WillPopScope(
          onWillPop: () {
            return Future.value(canPop);
          },
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            content: SizedBox(
              width: Get.width*.7,
              //  height: 100,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  UiHelper.verticalSpaceMedium,

                  Text(AppStrings.whenContinueToJitsiAndroid14.tr,textAlign: TextAlign.center,style: AppStyles.primaryStyle(fontSize: 14),),


                  SizedBox(
                   height: Get.height * .4,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          AppImages.jitsiAndroid14Hint,
                          fit: BoxFit.contain,
                          alignment: Alignment.center,
                        )),
                  ),

                  UiHelper.verticalSpaceMedium,
                  Row(children: [

                    Expanded(child: Ui.primaryButton(
                        title: AppStrings.continueTo.tr,
                        onTab: (){
                          Get.back();
                          onContinue();

                    }))

                  ],)


                  // Row(
                  //   children: [
                  //
                  //
                  //     UiHelper.horizontalSpaceMedium,
                  //     Expanded(
                  //         child: Text(
                  //       msg ?? AppStrings.pleaseWait.tr.capitalizeFirst!,
                  //       textAlign: TextAlign.center,
                  //       style: Get.textTheme.subtitle1!.copyWith(
                  //         color: Colors.black,
                  //       ),
                  //     )),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ));
  }


  static showProgressDownloadDialog(
      {String? msg,
        bool isDismissible = false,
        required FileModel file,
        }) async {



    return Get.dialog(
        WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            content: SizedBox(
              width: Get.mediaQuery.size.width / 2,
              //  height: 100,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GetBuilder<DownloadController>(builder: (logic) {

                    //  logic.downloaded=true;
                    // logic.progress=0;
                    if (logic.progress == 100) {
                      logic.progress = 0;
                      logic.downloaded=false;
                      Get.back(result: true);
                    }
                    if (!logic.downloaded) {
                      logic.downloadFile(
                          url: file.link, fileName: file.name);
                    }
                    return SizedBox(
                      width: Get.mediaQuery.size.width / 2,
                      //  height: 100,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          UiHelper.verticalSpaceLarge,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(

                                  onTap:(){
                                    Get.back();
                                  },
                                  child: Icon(Icons.close,color: AppColors.primaryColor,size: 30.sp,))

                            ],),
                          UiHelper.verticalSpaceLarge,
                          CircularPercentIndicator(
                            radius: 90.0,
                            lineWidth: 8.0,
                            percent: logic.progress < 100
                                ? logic.progress / 100
                                : 1,
                            center: Text(
                              "${logic.progress.toStringAsFixed(0)}%",
                              style: AppStyles.primaryStyle(bold: true),
                            ),
                            progressColor: AppColors.primaryColor,
                            fillColor: AppColors.white,
                            backgroundColor: AppColors.primaryColorOpacity,

                            //   backgroundColor: AppColors.primaryColorOpacity,
                            //  progressColor: AppColors.primaryColor,
                          ),
                          UiHelper.verticalSpaceLarge,
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        )
    );
  }

  static showUpdateAppDialog({String? msg, bool isDismissible = false}) async {
    Get.dialog(WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.h)),
        content: SizedBox(
          width: Get.width * .8,
          //  height: 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              UiHelper.verticalSpaceLarge,
              SizedBox(
                  height: Get.height / 4,
                  child: Lottie.asset(Platform.isIOS
                      ? AppAnim.updateIOS
                      : AppAnim.updateAndroid)),
              Padding(
                padding: EdgeInsets.only(bottom: 30.h),
                child: Row(
                  children: [
                    UiHelper.horizontalSpaceMedium,
                    Expanded(
                        child: Text(
                          msg ?? AppStrings.newFeatures.tr.capitalizeFirst!,
                          textAlign: TextAlign.center,
                          style:
                          AppStyles.primaryStyle(fontSize: 20, height: 1.3),
                        )),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Ui.primaryTextButton(
                        title: AppStrings.notNow,
                        onTab: () {
                          if (Platform.isAndroid) {
                            SystemNavigator.pop();
                          } else if (Platform.isIOS) {
                            exit(0);
                          }
                          // FlutterAppMinimizer.minimize();
                        }),
                  ),
                  UiHelper.horizontalSpaceMedium,
                  Expanded(
                    flex: 2,
                    child: Ui.primaryButton(
                        title: AppStrings.update,
                        onTab: () {
                          Launcher.launchInBrowser(Platform.isIOS
                              ? AppUrls.appleStoreUrl
                              : AppUrls.googlePlayUrl,externalApp: true);

                          //  Get.back();
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    )
    );
  }

  static showScanQRDialog({String? msg, bool isDismissible = false}) async {
    Get.dialog(
        WillPopScope(
          onWillPop: () {
            return Future.value(canPop);
          },
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            content: SizedBox(
              width: Get.width * .6,
              //  height: 100,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [UiHelper.verticalSpaceLarge, QrScannerPage()],
              ),
            ),
          ),
        )
    );
  }

  static showProgressDialog({String msg='', bool isDismissible = false}) async {
    Get.dialog(WillPopScope(
      onWillPop: () {
        return Future.value(canPop);
      },
      child: AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        content: SizedBox(
          width: Get.mediaQuery.size.width / 2,
          //  height: 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  height: Get.height / 4,
                  child: Lottie.asset(AppAnim.loaderGetData)),

              if(msg.isNotEmpty)
              Row(
                children: [


                  UiHelper.horizontalSpaceMedium,
                  Expanded(
                      child: Text(
                    msg.tr ,
                    textAlign: TextAlign.center,
                    style: Get.textTheme.titleMedium!.copyWith(
                      color: Colors.black,
                    ),
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    )
    );
  }

  static showThankMsgDialog({String? msg, bool isDismissible = false}) async {
    Get.dialog(
        WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            content: SizedBox(
              width: Get.mediaQuery.size.width / 2,
              //  height: 100,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 10.h, horizontal: 15.w),
                    decoration: BoxDecoration(
                      // color: AppColors.primaryColorOpacity,
                        borderRadius: BorderRadius.circular(10.h)),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 5.w),
                      decoration: BoxDecoration(
                        //  color: AppColors.primaryColorOpacity,
                          borderRadius: BorderRadius.circular(10.h)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  AppStrings.rateThankMsg.tr,
                                  textAlign: TextAlign.center,
                                  style: AppStyles.primaryStyle(
                                      fontSize: 15, bold: false, height: 1.5),
                                ),
                              )
                            ],
                          ),
                          UiHelper.verticalSpaceLarge,
                          Row(
                            children: [
                              Expanded(
                                  child: Ui.primaryButton(
                                      title: AppStrings.backToHome,
                                      color: AppColors.primaryColorGreen,
                                      onTab: () {
                                        Get.offAllNamed(AppRouteNames.homeTabs);
                                      })),
                              // UiHelper.horizontalSpaceMedium,
                              // Expanded(child: Ui.primaryButtonOutlined(title: AppStrings.notNow,marginV: 5,fontSize: 15,paddingV: 10,color: AppColors.primaryColorOpacity,onTab: (){
                              //   InstantConsultationLogic.rate='';
                              //   logic.rateConsultation();
                              //
                              // }))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  static showPaymentLoading({String? msg, bool isDismissible = false}) async {

    // final ShowLoader showLoader = ShowLoader();
    //
    // showLoader.show();
    //
    // // change the loader
    // Future.delayed(const Duration(seconds: 4), () {
    //   // you don't need to add the time of delay, this is just for the demo
    //   showLoader.update(
    //     "There is no user record corresponding to this identifier. The user may have been deleted.",
    //     Icons.error,
    //     colors: Colors.red,
    //   );
    // });
    //
    Get.dialog(
      WillPopScope(
        onWillPop: () {
          return Future.value(true);
        },
        child: AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: SizedBox(
            width: Get.mediaQuery.size.width / 2,
            //  height: 100,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () {
                      //Get.offAllNamed(AppRouteNames.home);

                      // Get.back();
                    },
                    child: Lottie.asset(
                      AppAnim.paymentLoading,
                      width: Get.width * .2,
                      height: Get.width * .2,
                    )),
                SizedBox(
                  height: 20,
                ),
                Text(
                  AppStrings.paymentLoading.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.subTitleColor,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
      // context: Get.context!,
      // barrierDismissible: isDismissible,

    );
  }

  static showBackPaymentDialog(
      {String? msg, bool isDismissible = false, Function? onCancel, }) async {
    Get.dialog(
        WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.cancelPayment.tr,
                  style: AppStyles.primaryStyle(bold: true, fontSize: 15),
                ),
                UiHelper.verticalSpaceLarge,
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Ui.primaryButton2(
                        title: AppStrings.yes,

                        marginH: 5,
                        radius: 5,
                        onTab: () {
                          if (onCancel != null) {
                            onCancel();
                          }
                        },
                      ),
                    ),
                    UiHelper.horizontalSpaceMedium,

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border:
                              Border.all(color: AppColors.subTitleColor)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Text(
                            AppStrings.no.tr,
                            textAlign: TextAlign.center,
                            style: AppStyles.subTitleStyle(bold: true),
                          ),
                        ),
                      ),
                    ),

                    // UiHelper.horizontalSpaceMedium,
                    // Expanded(
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       Get.offAllNamed(AppRouteNames.homeTabs);
                    //
                    //     },
                    //     child: Container(
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(5),
                    //           color: AppColors.primaryColor,
                    //           border:
                    //           Border.all(color: AppColors.primaryColor)),
                    //
                    //       padding: EdgeInsets.symmetric(
                    //           horizontal: 10, vertical: 5),
                    //       child: Text(
                    //         AppStrings.payLater.tr,
                    //         style: AppStyles.primaryStyle(bold: true,color: AppColors.white),
                    //       ),
                    //     ),
                    //   ),
                    // ),

                  ],
                )
              ],
            ),
            contentPadding:
            EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          ),
        ));
  }

  static showDefaultProgressDialog(
      {String? msg, bool isDismissible = false}) async {
    Get.defaultDialog(
      content: SizedBox(
        width: Get.mediaQuery.size.width,
        //  height: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                height: Get.height / 3,
                child: Lottie.asset(AppAnim.lottieProgress)),

            // Row(
            //   children: [
            //
            //
            //     UiHelper.horizontalSpaceMedium,
            //     Expanded(
            //         child: Text(
            //       msg ?? AppStrings.pleaseWait.tr.capitalizeFirst!,
            //       textAlign: TextAlign.center,
            //       style: Get.textTheme.subtitle1!.copyWith(
            //         color: Colors.black,
            //       ),
            //     )),
            //   ],
            // ),
          ],
        ),
      ),
      //  backgroundColor: AppColors.white.withOpacity(.5),
      radius: 50,
      title: '',
      middleText: '',
      barrierDismissible: isDismissible,
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
    );
  }

  static hideProgressDialog() async {
    Future.delayed(Duration(seconds: 1), () {
      Get.back();

      // if (_isShowing ) {
      //   _canPop = true;
      //   Get.back();
      // }
    });
  }

  static showSnackBar(
      {required String message,
        String? buttonTitle,
        Function? onTabMainButton,
        bool success = false,
        bool showIcon = false,
        SnackPosition? snackPosition,
        int duration = 5}) {
    if (Get.isSnackbarOpen) {
      Get.back();
    }

    GetSnackBar(
      message: message,
      isDismissible: true,

      icon: showIcon
          ? Icon(
        success ? Icons.check_circle : Icons.cancel,
        color: success ? Colors.green : Colors.red,
      )
          : null,
      snackPosition: snackPosition ?? SnackPosition.TOP,

      borderRadius: 8.0.h,
      backgroundColor: AppColors.primaryColor.withOpacity(.9),
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 32.h),
      duration: Duration(seconds: duration),
      snackStyle: SnackStyle.FLOATING,
      shouldIconPulse: true,
      // dismissDirection: SnackDismissDirection.HORIZONTAL,
      mainButton: buttonTitle != null && onTabMainButton != null
          ? TextButton(
        onPressed: () {
          if (Get.isSnackbarOpen) {
            Get.back();
          }
          onTabMainButton.call();
        },
        child: Text(
          buttonTitle,
          style:AppStyles.primaryStyle(color: Colors.white, fontSize: 16),
        ),
      )
          : null,
    ).show();
  }

  static showServiceInfoSnackBar({
    required String description,
    String title = '',
    String image = '',
    SnackPosition? snackPosition,
    int duration = 5,
  }) {
    if (Get.isSnackbarOpen) {
      Get.back();
    }

    return GetSnackBar(
      message: description,
      isDismissible: true,
      icon: null,
      snackPosition: snackPosition ?? SnackPosition.TOP,

      borderRadius: 8.0,
      backgroundColor: AppColors.primaryColorOpacity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      duration: Duration(seconds: duration),
      snackStyle: SnackStyle.FLOATING,
      shouldIconPulse: true,
      titleText: null,
      animationDuration: Duration(milliseconds: 1500),
      dismissDirection: DismissDirection.vertical,
      messageText: SizedBox(
        // height: Get.height*.7,
        child: Column(
          children: [
            UiHelper.verticalSpaceMedium,
            Row(
              children: [
                Ui.titleGreenUnderLine(title),
              ],
            ),
            UiHelper.verticalSpaceMedium,
            Text(
              description,
              style: AppStyles.primaryStyle(),
            ),
            UiHelper.verticalSpaceMedium,
            Image.asset(
              image,
              height: Get.height * .25,
            ),
            UiHelper.verticalSpaceLarge,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(
                  Icons.arrow_upward_sharp,
                  color: AppColors.primaryColor,
                  size: 50,
                ),
              ],
            ),
          ],
        ),
      ),
      // dismissDirection: SnackDismissDirection.HORIZONTAL,
      mainButton: null,
    ).show();
  }

  static showServiceInfoSnackBar2({
    required String description,
    String title = '',
    String image = '',
    SnackPosition? snackPosition,
    int duration = 5,
  }) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: SizedBox(
          height: Get.height * .7,
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                UiHelper.verticalSpaceMedium,
                Row(
                  children: [
                    Ui.titleGreenUnderLine(title),
                  ],
                ),
                UiHelper.verticalSpaceMedium,
                Text(
                  description,
                  style: AppStyles.primaryStyle(),
                ),
                UiHelper.verticalSpaceMedium,
                Image.asset(
                  image,
                  height: Get.height * .25,
                ),
                UiHelper.verticalSpaceLarge,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.arrow_upward_sharp,
                      color: AppColors.primaryColor,
                      size: 50,
                    ),
                  ],
                ),
              ],
            ),
          ),
        )));
  }

  static changeLangDialog() async {
    // int initialValue = Get.locale == const Locale('ar') ? 1 : 2;
    Get.dialog(
      SimpleDialog(
        title: Text(
          AppStrings.changeLanguage.tr.capitalizeFirst!,
          style: const TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        contentPadding: EdgeInsets.zero,
        // insetPadding: EdgeInsets.zero,
        titlePadding: const EdgeInsets.all(8.0),
        // children: [
        // FormBuilderRadioGroup<int>(
        //   name: 'lang',
        //   initialValue: initialValue,
        //   onChanged: (int value) {
        //     if (value == 1) {
        //       Get.find<AppLanguage>().changeLanguage(Locale('ar'));
        //     } else {
        //       Get.find<AppLanguage>().changeLanguage(Locale('en'));
        //     }
        //     if (Get.isDialogOpen) Get.back();
        //   },
        //   orientation: OptionsOrientation.vertical,
        //   decoration: InputDecoration(
        //     border: InputBorder.none,
        //     fillColor: Get.theme.scaffoldBackgroundColor,
        //     contentPadding: EdgeInsets.zero,
        //   ),
        //   options: [
        //     FormBuilderFieldOption(
        //       value: 1,
        //       child: Text(
        //         'العربية',
        //         style: Get.theme.textTheme.bodyText2,
        //       ),
        //     ),
        //     FormBuilderFieldOption(
        //       value: 2,
        //       child: Text(
        //         'English',
        //         style: Get.theme.textTheme.bodyText2,
        //       ),
        //     ),
        //   ],
        // ),
        // ],
      ),
    );
  }

  static singOutAlertDialog(
      {String? dialogTitle,
        String? alertText,
        String? okButtonText,
        String? cancelButtonTex,
        required VoidCallback onOkButtonClicked}) async {
    Get.dialog(
      SimpleDialog(
        title: Text(
          dialogTitle ?? AppStrings.signOut.tr.capitalizeFirst!,
          style: const TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        contentPadding: EdgeInsets.zero,
        // insetPadding: EdgeInsets.all(32),
        titlePadding: const EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              alertText ?? AppStrings.signOutAlert.tr.capitalizeFirst!,
              style: AppStyles.primaryStyle(
                bold: true,
              ),
            ),
          ),
          UiHelper.verticalSpaceMedium,
          Row(
            // mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Get.theme.primaryColor, padding: const EdgeInsets.all(16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      )),
                  onPressed: onOkButtonClicked,
                  child: Text(
                    okButtonText ?? AppStrings.continueText.tr.capitalizeFirst!,
                    style: AppStyles.primaryStyle(
                      // color: Colors.grey.shade400,
                      color: Get.theme.disabledColor,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Get.theme.primaryColor, padding: const EdgeInsets.all(16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      )),
                  onPressed: () => Get.back(),
                  child: Text(
                    cancelButtonTex ?? AppStrings.cancel.tr.capitalizeFirst!,
                    style: AppStyles.primaryStyle(),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  static showRegisterSuccessDialog(
      {String? msg, bool isDismissible = false}) async {
    isShowing = true;

    Get.defaultDialog(
      content: SizedBox(
        width: Get.width * .7,
        height: Get.height * .5,

        //  height: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () {
                  Get.offAllNamed(AppRouteNames.login);

                  // Get.back();
                },
                child: SvgPicture.asset(
                  AppImages.registerDialog,
                  width: Get.width * .5,
                  height: Get.height * .3,
                )),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                AppStrings.accountCreated.tr,
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 13,
                    fontWeight: FontWeight.normal),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              AppStrings.successfully.tr,
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      //  backgroundColor: AppColors.white.withOpacity(.5),
      radius: 50,
      title: '',
      middleText: '',
      barrierDismissible: false,
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
    );
  }

  static showPaymentSuccessDialog(
      {String? msg, bool isDismissible = false}) async {
    isShowing = true;
//        filter: ImageFilter  .blur(sigmaX: 1,sigmaY: 1,tileMode: TileMode.clamp,

    Get.defaultDialog(
      content: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 1,
          sigmaY: 1,
          tileMode: TileMode.clamp,
        ),
        child: SizedBox(
          width: Get.width * .95,
          height: Get.height * .55,

          //  height: 100,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () {
                      Get.offAllNamed(AppRouteNames.homeTabs);

                      // Get.back();
                    },
                    child: SvgPicture.asset(
                      AppImages.sucessPayment,
                      width: Get.width * .2,
                      height: Get.width * .2,
                    )),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    AppStrings.successfully.tr,
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  AppStrings.paymentSuccess.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.subTitleColor,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: 20,
                ),
                Ui.primaryButton(
                    title: 'Back to Home',
                    color: AppColors.primaryColorGreen,
                    radius: 10,
                    onTab: () {
                      Get.offAllNamed(AppRouteNames.homeTabs);
                    })
              ],
            ),
          ),
        ),
      ),
      //  backgroundColor: AppColors.white.withOpacity(.5),
      radius: 20,
      title: '',
      middleText: '',
      barrierDismissible: false,
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
    );
  }

  static showPaymentSuccessDialog2(
      {String msg = AppStrings.paymentSuccess,
        bool isDismissible = false}) async {
    isShowing = true;
//        filter: ImageFilter  .blur(sigmaX: 1,sigmaY: 1,tileMode: TileMode.clamp,

    Get.generalDialog(
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: AppColors.primaryColor.withOpacity(.7),
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (ctx, anim1, anim2) => AlertDialog(
        content: SizeTransition(
          sizeFactor: CurvedAnimation(
            parent: anim1,
            curve: Curves.easeInSine,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              width: Get.width * .95,
              height: Get.height * .55,

              //  height: 100,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          //Get.offAllNamed(AppRouteNames.home);

                          // Get.back();
                        },
                        child: SvgPicture.asset(
                          AppImages.sucessPayment,
                          width: Get.width * .2,
                          height: Get.width * .2,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        AppStrings.successfully.tr,
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      msg.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.subTitleColor,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Ui.primaryButton(
                        title: AppStrings.backToHome.tr,
                        color: AppColors.primaryColor,
                        radius: 10,
                        onTab: () {
                          Get.offAllNamed(AppRouteNames.homeTabs);
                        })
                  ],
                ),
              ),
            ),
          ),
        ),
        elevation: 2,
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
        filter:
        ImageFilter.blur(sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
        child: FadeTransition(
          opacity: anim1,
          child: child,
        ),
      ),
    );
  }

  static showPaymentLoading2(
      {String msg = AppStrings.paymentSuccess,
        bool isDismissible = false}) async {
    isShowing = true;
//        filter: ImageFilter  .blur(sigmaX: 1,sigmaY: 1,tileMode: TileMode.clamp,

    Get.generalDialog(
      barrierDismissible: false,
      barrierLabel: '',
      barrierColor: AppColors.primaryColor.withOpacity(.7),
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (ctx, anim1, anim2) => AlertDialog(
        content: SizeTransition(
          sizeFactor: CurvedAnimation(
            parent: anim1,
            curve: Curves.easeInSine,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              width: Get.width * .95,
              height: Get.height * .55,

              //  height: 100,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          //Get.offAllNamed(AppRouteNames.home);

                          // Get.back();
                        },
                        child: Lottie.asset(
                          AppAnim.paymentLoading,
                          width: Get.width * .2,
                          height: Get.width * .2,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppStrings.cancelPayment.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.subTitleColor,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Ui.primaryButton(
                        title: AppStrings.backToHome.tr,
                        color: AppColors.primaryColor,
                        radius: 10,
                        onTab: () {
                          Get.offAllNamed(AppRouteNames.homeTabs);
                        })
                  ],
                ),
              ),
            ),
          ),
        ),
        elevation: 2,
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
        filter:
        ImageFilter.blur(sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
        child: FadeTransition(
          opacity: anim1,
          child: child,
        ),
      ),
    );
  }

  static showRegisterSuccessDialog3(
      {String msg = AppStrings.paymentSuccess,
        bool isDismissible = false}) async {
    isShowing = true;
//        filter: ImageFilter  .blur(sigmaX: 1,sigmaY: 1,tileMode: TileMode.clamp,

    Get.generalDialog(
      barrierDismissible: false,
      barrierLabel: '',
      barrierColor: AppColors.primaryColor.withOpacity(.7),
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (ctx, anim1, anim2) => AlertDialog(
        content: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            width: Get.width * .95,
            height: Get.height * .55,

            //  height: 100,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.offAllNamed(AppRouteNames.login);

                        // Get.back();
                      },
                      child: Lottie.asset(AppAnim.success2,
                          width: 100, height: 100)),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    AppStrings.accountCreated.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.subTitleColor,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      AppStrings.successfully.tr,
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Ui.primaryButton(
                      title: AppStrings.logIn.tr,
                      color: AppColors.primaryColorGreen,
                      radius: 10,
                      onTab: () {
                        Get.offAllNamed(AppRouteNames.login);
                      })
                ],
              ),
            ),
          ),
        ),
        elevation: 2,
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
        filter:
        ImageFilter.blur(sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
        child: FadeTransition(
          opacity: anim1,
          child: child,
        ),
      ),
    );
  }

  static showRegisterSuccessDialog2(
      {String msg = AppStrings.paymentSuccess,
        bool isDismissible = false}) async {
    isShowing = true;
//        filter: ImageFilter  .blur(sigmaX: 1,sigmaY: 1,tileMode: TileMode.clamp,

    Get.generalDialog(
      barrierDismissible: false,
      barrierLabel: '',
      barrierColor: AppColors.primaryColor.withOpacity(.7),
      transitionDuration: Duration(milliseconds: 800),
      pageBuilder: (ctx, anim1, anim2) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AlertDialog(
          content: SizeTransition(
            sizeFactor: CurvedAnimation(
              parent: anim1,
              curve: Curves.easeInSine,
            ),
            // axis: Axis.horizontal,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                width: Get.width * .95,
                height: Get.height * .55,

                //  height: 100,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                          onTap: () {
                            Get.offAllNamed(AppRouteNames.login);

                            // Get.back();
                          },
                          child: Lottie.asset(AppAnim.success2,
                              width: 100, height: 100)),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        AppStrings.accountCreated.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.subTitleColor,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          AppStrings.successfully.tr,
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Ui.primaryButton(
                          title: AppStrings.logIn.tr,
                          color: AppColors.primaryColorGreen,
                          radius: 10,
                          onTab: () {
                            Get.offAllNamed(AppRouteNames.login);
                          })
                    ],
                  ),
                ),
              ),
            ),
          ),
          elevation: 2,
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
        filter:
        ImageFilter.blur(sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
        child: FadeTransition(
          opacity: anim1,
          child: child,
        ),
      ),
    );
  }

  static showEditProfileSuccessDialog(
      {String msg = AppStrings.profileUpdated,
        bool isDismissible = false}) async {
    isShowing = true;
//        filter: ImageFilter  .blur(sigmaX: 1,sigmaY: 1,tileMode: TileMode.clamp,

    return Get.generalDialog(
      barrierDismissible: false,
      barrierLabel: '',
      barrierColor: AppColors.primaryColor.withOpacity(.7),
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (ctx, anim1, anim2) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AlertDialog(
          content: SizeTransition(
            sizeFactor: CurvedAnimation(
              parent: anim1,
              curve: Curves.easeInSine,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                width: Get.width * .95,
                height: Get.height * .55,

                //  height: 100,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                          onTap: () {
                            // Get.back();
                          },
                          child: Lottie.asset(AppAnim.success2,
                              width: 100, height: 100)),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        msg.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.subTitleColor,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          AppStrings.successfully.tr,
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Ui.primaryButton(
                          title: AppStrings.back.tr,
                          color: AppColors.primaryColorGreen,
                          radius: 10,
                          onTab: () {
                            Get.back(result: true);
                            //        Get.offAllNamed(AppRouteNames.home);
                          })
                    ],
                  ),
                ),
              ),
            ),
          ),
          elevation: 2,
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
        filter:
        ImageFilter.blur(sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
        child: FadeTransition(
          opacity: anim1,
          child: child,
        ),
      ),
    );
  }

  static showRequestServiceSuccessDialog(
      {String msg = AppStrings.requestSuccessMsg,
        bool isDismissible = false,
        isBack = false,
        String backRoute = AppRouteNames.homeTabs}) async {
    isShowing = true;
//        filter: ImageFilter  .blur(sigmaX: 1,sigmaY: 1,tileMode: TileMode.clamp,

    return Get.generalDialog(
      barrierDismissible: false,
      barrierLabel: '',
      barrierColor: AppColors.primaryColor.withOpacity(.7),
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (ctx, anim1, anim2) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AlertDialog(
          content: SizeTransition(
            sizeFactor: CurvedAnimation(
              parent: anim1,
              curve: Curves.easeInSine,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                width: Get.width * .95,
                // height: Get.height * .55,

                //  height: 100,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 20,
                      ),

                      GestureDetector(
                          onTap: () {
                            // Get.back();
                          },
                          child: Lottie.asset(AppAnim.success2,
                              width: 100, height: 100)),

                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        msg.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.subTitleColor,
                            fontSize: 16,
                            height: 1.5,
                            fontWeight: FontWeight.normal),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 20),
                      //   child: Text(AppStrings.successfully.tr,style: TextStyle(color: AppColors.primaryColor,fontSize: 25,fontWeight: FontWeight.bold),),
                      // ),
                      // SizedBox(height: 20,),

                      Ui.primaryButton(
                          title: AppStrings.back.tr,
                          color: AppColors.primaryColorGreen,
                          radius: 10,
                          onTab: () {
                            if (isBack) {
                              Get.back(result: true);
                            } else {
                              Get.offAllNamed(AppRouteNames.homeTabs);
                            } //
                            //
                          })
                    ],
                  ),
                ),
              ),
            ),
          ),
          elevation: 2,
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
        filter:
        ImageFilter.blur(sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
        child: FadeTransition(
          opacity: anim1,
          child: child,
        ),
      ),
    );
  }

  static showTeleCallDialog(
      {String msg = '', url = '', bool isDismissible = false}) async {
    isShowing = true;
//        filter: ImageFilter  .blur(sigmaX: 1,sigmaY: 1,tileMode: TileMode.clamp,

    Get.generalDialog(
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: AppColors.primaryColor.withOpacity(.7),
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (ctx, anim1, anim2) => AlertDialog(
        content: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            width: Get.width * .95,
            //  height: Get.height*.3,

            //  height: 100,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.password.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        ' : ${msg.tr}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Ui.primaryButton(
                      title: AppStrings.startMeeting,
                      color: AppColors.primaryColorGreen,
                      radius: 10,
                      onTab: () {
                        Launcher.launchInBrowser(url);
                        //  Get.offAllNamed(AppRouteNames.home);
                      })
                ],
              ),
            ),
          ),
        ),
        elevation: 2,
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
        filter:
        ImageFilter.blur(sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
        child: FadeTransition(
          opacity: anim1,
          child: child,
        ),
      ),
    );
  }

  static showCompleteDataDialog(
      {String? msg, bool isDismissible = false}) async {
    const nameKey = 'name';
    const ssnKey = 'ssn';
    final labelStyle = TextStyle(
        color: AppColors.subTitleColor,
        fontWeight: FontWeight.bold,
        fontSize: 13);
    final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(color: AppColors.subTitleColor),
    );
    FormGroup buildForm() => fb.group(<String, Object>{
      nameKey: FormControl<String>(
        validators: [
          Validators.required,
        ],
      ),
      ssnKey: FormControl<String>(),
      'rememberMe': false,
    });

    isShowing = true;
//        filter: ImageFilter  .blur(sigmaX: 1,sigmaY: 1,tileMode: TileMode.clamp,

    Get.generalDialog(
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: AppColors.primaryColor.withOpacity(.7),
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (ctx, anim1, anim2) => AlertDialog(
        content: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            width: Get.width * .95,
            height: Get.height * .9,

            //  height: 100,
            child: GetBuilder<MyProfileLogic>(builder: (controller) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                            onTap: () {
                              // Get.back();
                            },
                            child: SvgPicture.asset(
                              AppImages.fillOut,
                              width: Get.width * .8,
                              height: Get.height * .25,
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        UiHelper.verticalSpaceMedium,
                        ReactiveFormBuilder(
                          form: buildForm,
                          builder: (context, form, child) {
                            return Column(
                              children: [
                                ReactiveTextForm.reactiveTextField(
                                    formControlName: nameKey,
                                    validationMessage:
                                    AppStrings.fillRequiredInformation.tr,
                                    lable: AppStrings.fullName.tr,
                                    iconData: Icons.lock,
                                    lableStyle: labelStyle,
                                    fillColor: AppColors.white,
                                    outlineInputBorder: outlineInputBorder),
                                ReactiveTextForm.reactiveTextField(
                                    formControlName: ssnKey,
                                    validationMessage:
                                    AppStrings.fillRequiredInformation.tr,
                                    fillColor: AppColors.white,
                                    lable: AppStrings.idNo.tr,
                                    iconData: Icons.lock,
                                    lableStyle: labelStyle,
                                    outlineInputBorder: outlineInputBorder),
                                SizedBox(
                                  height: 30,
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          AppStrings.gender.tr.toUpperCase(),
                                          style: AppStyles.primaryStyle(
                                              bold: true, fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    Ui.greenLine(),
                                    Row(
                                      children: [
                                        genderButton(
                                            title: AppStrings.male,
                                            selected: controller.gender == 0,
                                            onTab: () {
                                              controller.updateGender(0);
                                            }),
                                        UiHelper.horizontalSpaceMedium,
                                        genderButton(
                                            title: AppStrings.female,
                                            selected: controller.gender == 1,
                                            onTab: () {
                                              controller.updateGender(1);
                                            }),
                                        UiHelper.horizontalSpaceMassive,
                                        Icon(
                                          FontAwesomeIcons.male,
                                          color: controller.gender == 0
                                              ? AppColors.primaryColor
                                              : AppColors.subTitleColor,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.female,
                                          color: controller.gender == 1
                                              ? AppColors.primaryColor
                                              : AppColors.subTitleColor,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    AppStrings.cancel,
                                    style: AppStyles.subTitleStyle(
                                        bold: true, size: 20),
                                  )),
                            ),
                            Expanded(
                              child: Ui.primaryButton(
                                  title: AppStrings.continueTo,
                                  color: AppColors.primaryColorGreen,
                                  radius: 10,
                                  onTab: () {
                                    Get.toNamed(AppRouteNames.patientData);
                                  }),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        elevation: 2,
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
        filter:
        ImageFilter.blur(sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
        child: FadeTransition(
          opacity: anim1,
          child: child,
        ),
      ),
    );
  }

  static loadingDialog() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          //  padding: EdgeInsets.symmetric(horizontal: Get.width*.1,vertical: Get.height*.2),
          // margin: EdgeInsets.symmetric(horizontal: Get.width*.2,vertical: Get.height*.2),

            decoration: BoxDecoration(
              color: AppColors.primaryGreenOpacityColor.withOpacity(.8),
            ),
            //  height: Get.height*.9,
            //width: Get.width*.8,
            child: SizedBox(
              width: 200,
              height: 200,
              child: Lottie.asset(
                AppAnim.loader,
              ),
            )),
      ],
    );
  }

  static nurseBottomSheet(
      {String instructions = '', String desc = '', String serviceName = ''}) {
    Get.bottomSheet(
        Container(
          margin: EdgeInsets.only(top: 15.h, left: 15.w, right: 15.w),
          padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 20.h),
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.h),
                  topRight: Radius.circular(25.h))),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 50.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10.h)),
                ),
                UiHelper.verticalSpaceMedium,
                Ui.titleGreenUnderLine(AppStrings.serviceDescription),
                Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 15.h),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColorOpacity,
                      borderRadius: BorderRadius.circular(15.h)),
                  child: Column(
                    children: [
                      Ui.vSpace10,
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                                desc,
                                textAlign: TextAlign.start,
                                style:
                                AppStyles.subTitleStyle(size: 15, height: 1.5),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                UiHelper.verticalSpaceMedium,
                Ui.titleGreenUnderLine(AppStrings.moreDetails),
                Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 15.h),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColorOpacity,
                      borderRadius: BorderRadius.circular(15.h)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                                instructions,
                                textAlign: TextAlign.start,
                                style:
                                AppStyles.subTitleStyle(size: 15, height: 1.5),
                              )),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        elevation: 3,
        //  isScrollControlled: true,
        backgroundColor: AppColors.primaryColorOpacity,
        enterBottomSheetDuration: Duration(milliseconds: 500),
        exitBottomSheetDuration: Duration(milliseconds: 500),
        barrierColor: null,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.h),
                topRight: Radius.circular(25.h))));
  }

  static selectedLocationBottomSheet({
    String desc = '',
  }) {
    Get.bottomSheet(
      Wrap(
        children: [
          Container(
            margin: EdgeInsets.only(top: 15, left: 15, right: 15),
            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: Column(
              children: [
                Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
                UiHelper.verticalSpaceMedium,
                Row(
                  children: [
                    Text(
                      AppStrings.selectedLocation.tr,
                      style: AppStyles.primaryStyle(bold: true, fontSize: 16),
                    ),
                  ],
                ),
                Ui.greenLine(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColorOpacity,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    children: [
                      Ui.vSpace10,
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                                desc,
                                textAlign: TextAlign.start,
                                style:
                                AppStyles.primaryStyle(fontSize: 16, opacity: .7),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                Ui.vSpace10,
                Ui.vSpace10,
              ],
            ),
          ),
        ],
      ),
      elevation: 3,
      isScrollControlled: true,
      backgroundColor: AppColors.primaryColorOpacity,
      enterBottomSheetDuration: Duration(milliseconds: 500),
      exitBottomSheetDuration: Duration(milliseconds: 500),
      barrierColor: null,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
    );
  }

  static doctorsFilterBottomSheet({List<String> specialties = const []}) {
    Get.bottomSheet(
        Container(
          margin: EdgeInsets.only(top: 15, left: 15, right: 15),
          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: GetBuilder<DoctorsController>(builder: (logic) {
            return Column(
              children: [
                Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
                UiHelper.verticalSpaceMedium,
                Row(
                  children: [
                    Text(
                      'Specialties',
                      style: AppStyles.primaryStyle(bold: true, fontSize: 16),
                    ),
                  ],
                ),
                Ui.greenLine(),
                Ui.vSpace10,
                Expanded(
                    child: ListView.builder(
                        itemCount: specialties.length,
                        itemBuilder: (bc, index) => Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: GestureDetector(
                            onTap: () {
                              logic.addRemoveFilter(specialties[index]);
                            },
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                      specialties[index],
                                      style: logic
                                          .checkFilter(specialties[index])
                                          ? AppStyles.primaryStyle(bold: true)
                                          : AppStyles.subTitleStyle(bold: true),
                                    )),
                                UiHelper.horizontalSpaceMedium,
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(5),
                                      border: Border.all(
                                          color: logic.checkFilter(
                                              specialties[index])
                                              ? AppColors.primaryColorGreen
                                              : AppColors.subTitleColor),
                                      color: logic.checkFilter(
                                          specialties[index])
                                          ? AppColors.primaryColorGreen
                                          : AppColors.white),
                                  child: Icon(
                                    Icons.check,
                                    color: logic
                                        .checkFilter(specialties[index])
                                        ? AppColors.white
                                        : AppColors.subTitleColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))),
                Ui.primaryButton(
                    title: AppStrings.save,
                    onTab: () {
                      logic.updateDoctorsFilter(logic.filterDoctors);
                      Get.back();
                    })
              ],
            );
          }),
        ),
        elevation: 3,
        //  isScrollControlled: true,
        backgroundColor: AppColors.primaryColorOpacity,
        enterBottomSheetDuration: Duration(milliseconds: 500),
        exitBottomSheetDuration: Duration(milliseconds: 500),
        barrierColor: null,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))));
  }

  static genderButton(
      {String title = '', bool selected = false, Function? onTab}) {
    return GestureDetector(
      onTap: () {
        if (onTab != null) {
          onTab();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
            color: selected
                ? AppColors.primaryColor
                : AppColors.primaryColorOpacity,
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          title.tr,
          style: selected
              ? AppStyles.whiteStyle(bold: true, size: 15)
              : AppStyles.primaryStyle(fontSize: 15, opacity: .8),
        ),
      ),
    );
  }


 static showSureDialog({required Function onSure,String actionTitle=''}){


   Get.bottomSheet(
     Padding(
       padding: EdgeInsets.symmetric(
           vertical: 50.h, horizontal: 30.w),
       child: SingleChildScrollView(
         child: Column(
           children: [
             Row(
               children: [
                 Expanded(
                     child: Text.rich(
                       TextSpan(
                           text: AppStrings
                               .areYouSure
                               .tr,
                           style: AppStyles.primaryStyle(
                               bold: false,
                               fontSize: 15,
                               color:
                               AppColors.primaryColor),
                           children: [
                             TextSpan(
                                 text:actionTitle.tr.capitalize,
                                 style: AppStyles
                                     .primaryStyle(
                                     bold: true,
                                     fontSize: 15))
                           ]),
                     )),
               ],
             ),
             UiHelper.verticalSpaceLarge,
             Row(
               children: [
                 Expanded(
                   child: Ui.primaryButton(
                       title: AppStrings.back,
                       color:
                       AppColors.red,
                       paddingV: 15,
                       fontSize: 14,
                       onTab: () {
                         Get.back();
                       }),
                 ),
                 UiHelper.horizontalSpaceMedium,
                 Expanded(
                   flex: 1,
                   child: Ui.primaryButton(
                       title: "${AppStrings.yes.tr} , ${actionTitle.tr}",
                       paddingV: 15,
                       fontSize: 14,
                       onTab: () {

                         onSure();


                       }),
                 ),
               ],
             )
           ],
         ),
       ),
     ),
     shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.only(
             topRight: Radius.circular(10.h),
             topLeft: Radius.circular(10.h))),
     backgroundColor: AppColors.white,
   );


 }
 static showCaregiverContractDialog(){


   Get.bottomSheet(
     Padding(
       padding: EdgeInsets.symmetric(
           vertical: 50.h, horizontal: 30.w),
       child: Column(
         children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [


               Expanded(child: Text( ar [AppStrings.contractData] ??'',textAlign: TextAlign.center,style: AppStyles.primaryStyle(bold: true,fontSize: 20),)),

               GestureDetector(
                 onTap: (){
                   Get.back();
                 },
                 child: CircleAvatar(backgroundColor: AppColors.primaryColor,

                 child: Icon(Icons.close,color: AppColors.white,),
                 ),
               ),
               UiHelper.horizontalSpaceLarge,


             ],
           ),
           UiHelper.verticalSpaceLarge,

           Expanded(child: SingleChildScrollView(child: CaregiverContractDetails()))


         ],
       ),
     ),
     shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.only(
             topRight: Radius.circular(10.h),
             topLeft: Radius.circular(10.h))),
     backgroundColor: AppColors.white,
     isScrollControlled: true
   );


 }

  static showNotificationReadDialog(
      {String image='',String title='',String msg='', bool isDismissible = false}) async {
    isShowing = true;

    Get.defaultDialog(
      content: SizedBox(
        width: Get.width * .8,
        // height: Get.height * .5,

        //  height: 100,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 0.h,horizontal: 20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              GestureDetector(
                  onTap: () {

                    Get.back();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppImages.close,
                        width: 40.w,
                        height:40.h,
                        colorFilter: ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                      ),
// UiHelper.horizontalSpaceSmall,
//                       Text(AppStrings.close.tr,style: AppStyles.primaryStyle(),),
                    ],
                  )),
              SizedBox(
                height: 20,
              ),



              RectangularCachedImage(imageUrl: image,height: 150,width: Get.width*.7,radius: 10,),
              UiHelper.verticalSpaceMedium,
          Text(title,style: AppStyles.primaryStyle(bold: true),textAlign: TextAlign.center,),
          UiHelper.verticalSpaceMedium,
          Text(msg,style: AppStyles.primaryStyle(bold: false),textAlign: TextAlign.center,),
            ],
          ),
        ),
      ),
      //  backgroundColor: AppColors.white.withOpacity(.5),
      radius: 10,
      title: '',
      middleText: '',
      barrierDismissible: false,
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,


    );
  }

}