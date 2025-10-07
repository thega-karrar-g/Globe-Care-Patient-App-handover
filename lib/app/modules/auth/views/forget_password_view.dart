import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../global_widgets/shared/ui_helpers.dart';
import '../auth_controller.dart';
import '../widgets/reactive_forget_password_form.dart';
import '../widgets/verify_code_widget.dart';

class ForgetPasswordPage extends GetView<AuthController> {
  // final controller = Get.find<DoctorsController>();
  @override
  final controller = Get.put(AuthController());

  ForgetPasswordPage({Key? key}) : super(key: key);

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
                GetBuilder<AuthController>(builder: (controller) {
                  return controller.showForgotPasswordForm ? ReactiveForgetPasswordForm(title: '') :VerifyCodeWidget(logic: controller,isRegister: false,)  ;
                }),
                SizedBox(
                  height: 16.h,
                ),
                UiHelper.verticalSpaceLarge,
              ],
            ),
          ),
        ));
  }
}
