import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../core/theme_helper/app_colors.dart';
import '../../../../core/theme_helper/app_styles.dart';
import '../../../../data/constants/booking_constants.dart';
import '../../../../global_widgets/audio/record_widget.dart';
import '../../../../global_widgets/ui.dart';

class NotesWidget extends StatelessWidget {
   NotesWidget({Key? key,required this.focusNode}) : super(key: key);

 final  FocusNode focusNode;

 final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.h)),
    borderSide: BorderSide(color: AppColors.registerFiled),
  );
  final double paddingHeight = 25.0.h;
  final labelStyle = TextStyle(
      color: AppColors.subTitleColor,
      fontWeight: FontWeight.bold,
      fontSize: 13.sp);
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Ui.titleGreenUnderLine(AppStrings.audioNote.tr,
          bottomPadding: 8),

      Container(
          padding: EdgeInsets.symmetric(
              horizontal: 5.w, vertical: 5.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.h),
              color: AppColors.primaryColorOpacity),
          child: RecoredWidget()),
      SizedBox(
        height: 20.h,
      ),

      Ui.titleGreenUnderLine(AppStrings.textNote.tr,
          bottomPadding: 8),

      TextFormField(
        textInputAction: TextInputAction.newline,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        focusNode: focusNode,
        style: Ui.labelStyle,
        controller: BookingConstants.patientComment,
        decoration: InputDecoration(
          //  labelText: lable.tr,
          labelStyle: AppStyles.subTitleStyle(bold: true),
          filled: true,
          fillColor: AppColors.primaryColorOpacity,
          contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w, vertical: 10.h),
          hintText: AppStrings.textNoteHint.tr,
          errorStyle: TextStyle(
              color: Colors.white.withOpacity(0.7)),
          errorBorder: outlineInputBorder,
          hintStyle: AppStyles.subTitleStyle(
            bold: true,
          ),
          border: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          enabledBorder: outlineInputBorder,
        ),
      ),

      SizedBox(
        height: 20.h,
      ),

    ],);
  }
}
