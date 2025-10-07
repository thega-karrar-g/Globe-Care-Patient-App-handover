import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../auth_controller.dart';
import '../widgets/reactive_register_form.dart';
import '../widgets/verify_code_widget.dart';

class RegisterPage extends GetView<AuthController> {
  // final controller = Get.find<DoctorsController>();
  @override
  final controller = Get.put(AuthController());

   RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: GetBuilder<AuthController>(builder: (logic) {
          return SafeArea(
            minimum: UiHelper.safeAreaPadding,
            child: Stack(
              children: [
                Column(
                  children: [
                    UiHelper.verticalSpaceMassive,
                    Expanded(child: logic.showRegisterForm ? ReactiveRegisterForm() :VerifyCodeWidget(logic: logic,) ),
                  ],
                ),
                SizedBox(),
              ],
            ),
          );
        }));
  }
}
