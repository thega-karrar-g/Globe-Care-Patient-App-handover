import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_colors.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../routes/app_route_names.dart';
import '../auth_controller.dart';
import '../widgets/reactive_login_form.dart';

class LoginPage extends GetView<AuthController> {
  // final controller = Get.find<DoctorsController>();
  @override
  final controller = Get.put(AuthController());

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          minimum: UiHelper.safeAreaPadding,
          child: SingleChildScrollView(
            child: Column(
              children: [
                UiHelper.verticalSpace(30),
                ReactiveLoginForm(
                  title: AppStrings.welcome,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.offAllNamed(AppRouteNames.homeTabs);

                        //  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                      },
                      child: Text(
                        AppStrings.guest.tr,
                        style: AppStyles.primaryStyle(bold: true, fontSize: 15),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Divider(
                      color: AppColors.subTitleColor,
                    )),
                    UiHelper.horizontalSpaceMedium,
                    Text(
                      AppStrings.or.tr,
                      style: AppStyles.primaryStyle(bold: true),
                    ),
                    UiHelper.horizontalSpaceMedium,
                    Expanded(
                        child: Divider(
                      color: AppColors.subTitleColor,
                    )),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        //  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                      },
                      child: Text(
                        AppStrings.doNotHaveAccount.tr,
                        style: AppStyles.primaryStyle(bold: true, fontSize: 15,opacity: .7),
                      ),
                    ),
                    UiHelper.horizontalSpace(5),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRouteNames.register);

                        //  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                      },
                      child: Text(
                        AppStrings.signUp.tr,
                        style: AppStyles.primaryStyle(bold: true, fontSize: 15),
                      ),
                    ),
                  ],
                ),
                UiHelper.verticalSpaceLarge,
              ],
            ),
          ),
        ));
  }
}
