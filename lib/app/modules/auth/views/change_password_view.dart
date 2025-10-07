import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../global_widgets/shared/my_appbar.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../global_widgets/ui.dart';
import '../auth_controller.dart';
import '../widgets/change_password_form.dart';

class ChangePasswordPage extends GetView<AuthController> {
  @override
  final controller = Get.put(AuthController());

  ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(
        child: SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Stack(
        children: [
          Column(
            children: <Widget>[
              myAppBar2(title: AppStrings.changePassword),
              UiHelper.verticalSpaceLarge,
              ChangePasswordForm(
                controller: controller,
              ),
            ],
          ),
          // Positioned(
          //
          //     top: 50,
          //     left: 10,
          //     //   right: 20,
          //     child: GestureDetector(
          //         onTap: (){
          //           Get.back();
          //         },
          //         child: Icon(Icons.arrow_back_ios_outlined,color: AppColors.primaryColor,))),
        ],
      ),
    ));
  }
}
