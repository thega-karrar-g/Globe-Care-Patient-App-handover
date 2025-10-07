import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_colors.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../global_widgets/shared/my_appbar.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../global_widgets/ui.dart';
import 'edit_profile_logic.dart';
import 'widgets/edit_profile_form.dart';

class EditProfilePage extends StatelessWidget {
  final EditProfileLogic logic = Get.put(EditProfileLogic());
  final double paddingHeight = 25.0.h;

  final String fullNameKey = 'name';
  final String emailKey = 'name';
  final String ssnKey = 'ssn';

  final labelStyle = TextStyle(
      color: AppColors.black54, fontWeight: FontWeight.bold, fontSize: 13.sp);
  final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(25.w)),
    borderSide: BorderSide(color: AppColors.registerFiled),
  );

  EditProfilePage({Key? key}) : super(key: key);

  FormGroup buildForm() => fb.group(<String, Object>{
        fullNameKey: FormControl<String>(
          value: logic.currentUser!.name,
          validators: [
            Validators.required,
          ],
        ),

        emailKey: FormControl<String>(
          value: logic.currentUser!.email,
          validators: [
            Validators.required,
          ],
        ),

        ssnKey: FormControl<String>(
          value: logic.currentUser!.ssn,
          validators: [Validators.required, Validators.number()],
        ),
        // 'dob': FormControl<DateTime>(),
      });

  final TextStyle style =
      (TextStyle(color: AppColors.white));
  var img = '';

  final radius = 50.0.w;

  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(child: SizedBox(
      // color: AppColors.bodyBgColor.withOpacity(.9),
      child: GetBuilder<EditProfileLogic>(builder: (logic) {
        if (logic.currentUser!.imageUrl!.isNotEmpty &&
            logic.currentUser!.imageUrl!.length > 10) {
          img = logic.currentUser!.imageUrl!.replaceAll('https', 'http');
        }
        print('*******************  img:$img');
        // logic.clearImageCache();

        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Column(
            children: [
              myAppBar2(
                title: AppStrings.editProfile,
              ),
              UiHelper.verticalSpaceLarge,
              GestureDetector(
                onTap: () {
                  logic.pickImage();
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          //color: AppColors.primaryColorOpacity,
                          borderRadius: BorderRadius.circular(100.w)
                          // shape: BoxShape.circle
                          ),
                      child: Ui.circularImg(
                        url: img,
                        size: 80,
                        radius: 10.w,
                        margin: 0,
                      ),
                    ),
                    Positioned.fill(
                        bottom: 0,
                        child: Align(
                            alignment: Get.locale.toString() == 'ar'
                                ? Alignment.bottomLeft
                                : Alignment.bottomRight,
                            child: Container(
                              padding: EdgeInsets.all(5.w),
                              //  height: 25,
                              decoration: BoxDecoration(
                                  color: AppColors.primaryColorGreen,
                                  borderRadius: BorderRadius.circular(10.w)),
                              child: Icon(
                                Icons.edit,
                                size: 18.w,
                                color: AppColors.white,
                              ),
                            ))),
                  ],
                ),
              ),
              UiHelper.verticalSpaceMedium,
              Text(
                AppStrings.editImage.tr,
                style: AppStyles.primaryStyle(),
              ),
              UiHelper.verticalSpaceLarge,
              Expanded(child: SingleChildScrollView(child: EditProfileForm()))
            ],
          ),
        );
      }),
    ));
  }
}
