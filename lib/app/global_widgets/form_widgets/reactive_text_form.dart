import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:globcare/app/core/language_and_localization/app_strings.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../core/theme_helper/app_colors.dart';
import '../../core/theme_helper/app_styles.dart';
import '../../modules/auth/auth_controller.dart';
import '../../utils/reg_exp.dart';
import '../shared/ui_helpers.dart';
import '../ui.dart';

class ReactiveTextForm {
  static reactiveTextFieldAuth(
      {String formControlName = '',
      preventSpace = false,
      isLocation = false,
      bool isPhone = false,
      IconData iconData = Icons.person,
      Color iconColor = AppColors.filedBg,
      String validationMessage = '',
      String validationMessagePassword = '',
      String lable = '',
      TextStyle lableStyle = const TextStyle(),
      Color fillColor = AppColors.registerFiled,
      bool isNumber = false,
      isPassword = false,
      OutlineInputBorder outlineInputBorder = const OutlineInputBorder(),
      Widget? locationBtn}) {
    final double paddingHeight = 20.0.h;

    return GetBuilder<AuthController>(builder: (logic) {
      return Container(
        padding: EdgeInsets.symmetric(
          vertical: 5.h,
        ),
        child: ReactiveTextField<String>(
          formControlName: formControlName,
          // validationMessages: (control) => {
          //   ValidationMessage.required:
          //       lable.tr + ' ' + AppStrings.mustNotEmpty.tr,
          //   if (isPassword)
          //     ValidationMessage.minLength: AppStrings.passwordLengthHint.tr,
          //   // 'unique': 'This email is already in use',
          // },
          textInputAction: TextInputAction.next,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          inputFormatters: [
            if (isNumber) FilteringTextInputFormatter.digitsOnly,
            if (preventSpace)
              FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s")),
            if (isPhone) LengthLimitingTextInputFormatter(10),
          ],
          style: lableStyle,
          obscureText: isPassword ? !logic.hidePassword : false,
          cursorColor: AppColors.primaryColorGreen,
          onEditingComplete: (t) {},
          decoration: InputDecoration(
            labelText: lable.tr,
            labelStyle: lableStyle,
            hintStyle: lableStyle,
            filled: true,
            fillColor: fillColor,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 18.w, vertical: paddingHeight),
            hintText: lable.tr,
            errorStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
            errorBorder: outlineInputBorder,
            //  hintStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
            //  prefixIcon:!isLocation ?Icon(iconData, color: iconColor):null,
            //prefixIcon:UiHelper.horizontalSpace(5),
            suffixIcon: isPassword
                ? GestureDetector(
                    onTap: () {
                      logic.updatePassword(!logic.hidePassword);
                    },
                    child: Icon(
                      logic.hidePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColors.primaryColorGreen,
                    ),
                  )
                : isLocation
                    ? locationBtn
                    : null,

            border: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            enabledBorder: outlineInputBorder,
          ),
        ),
      );
    });
  }

  static registerTextField(
      {String formControlName = '',
      preventSpace = false,
      isLocation = false,
      bool isPhone = false,
      IconData iconData = Icons.person,
      Color iconColor = AppColors.filedBg,
      String validationMessage = '',
      String validationMessagePassword = '',
      String lable = '',
      TextStyle lableStyle = const TextStyle(),
      Color fillColor = AppColors.registerFiled,
      bool isNumber = false,
      isPassword = false,
      OutlineInputBorder outlineInputBorder = const OutlineInputBorder(),
      Widget? locationBtn,
      Function? changePassword,
      bool hidePassword = true}) {
    const double paddingHeight = 20.0;

    return Container(
      decoration: Ui.getBoxDecorationLogin(),
      padding: EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: ReactiveTextField<String>(
        formControlName: formControlName,
        // validationMessages: (control) => {
        //   ValidationMessage.required:
        //       lable.tr + ' ' + AppStrings.mustNotEmpty.tr,
        //   if (isPassword)
        //     ValidationMessage.minLength: AppStrings.passwordLengthHint.tr,
        //   // 'unique': 'This email is already in use',
        // },
        textInputAction: TextInputAction.next,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        inputFormatters: [
          if (isNumber) FilteringTextInputFormatter.digitsOnly,
          if (preventSpace)
            FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s")),
          if (isPhone) LengthLimitingTextInputFormatter(10),
        ],
        style: lableStyle,
        obscureText: isPassword ? hidePassword : false,
        cursorColor: AppColors.primaryColorGreen,
        onEditingComplete: (t) {},
        decoration: InputDecoration(
          labelText: lable.tr.capitalizeFirst,
          labelStyle: AppStyles.subTitleStyle(),
          hintStyle:
              TextStyle(color: AppColors.primaryColorGreen.withOpacity(0.7)),
          // filled: true,
          // fillColor: fillColor ,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 12, vertical: paddingHeight),
          hintText: lable.tr,
          errorStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
          //  hintStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
          //  prefixIcon:!isLocation ?Icon(iconData, color: iconColor):null,
          //prefixIcon:UiHelper.horizontalSpace(5),
          suffixIcon: isPassword
              ? GestureDetector(
                  onTap: () {
                    if (changePassword != null) {
                      changePassword();
                    }
                    //  logic.updatePassword(!logic.hidePassword);
                  },
                  child: Icon(
                    hidePassword ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.primaryColorGreen,
                  ),
                )
              : isLocation
                  ? locationBtn
                  : null,

          border: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  static reactiveTextFieldWithUnderline(
      {String formControlName = '',
      IconData iconData = Icons.person,
      Color iconColor = AppColors.filedBg,
      String validationMessage = '',
      String lable = '',
      TextStyle lableStyle = const TextStyle(),
      Color fillColor = AppColors.white,
      bool isNumber = false,
      isPassword = false,
      OutlineInputBorder outlineInputBorder = const OutlineInputBorder()}) {
    const double paddingHeight = 25.0;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
      child: Column(
        children: [
          ReactiveTextField<String>(
            formControlName: formControlName,
            // validationMessages: (control) => {
            //   ValidationMessage.required:
            //       lable.tr + ' ' + AppStrings.mustNotEmpty.tr,
            //   if (isPassword)
            //     ValidationMessage.minLength: AppStrings.passwordLengthHint,
            //   // 'unique': 'This email is already in use',
            // },
            textInputAction: TextInputAction.next,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            inputFormatters: [
              if (isNumber) FilteringTextInputFormatter.digitsOnly
            ],
            style: lableStyle,
            decoration: InputDecoration(
                labelText: lable.tr,
                labelStyle: lableStyle,
                filled: true,
                fillColor: fillColor,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 12, vertical: paddingHeight),
                hintText: '',
                errorStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                errorBorder: outlineInputBorder,
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                prefixIcon: Icon(iconData, color: iconColor),
                border: outlineInputBorder,
                focusedBorder: outlineInputBorder,
                enabledBorder: outlineInputBorder,
                focusedErrorBorder: outlineInputBorder,
                disabledBorder: outlineInputBorder),
          ),
          Container(
            height: 2,
            width: Get.width,
            margin: EdgeInsets.symmetric(horizontal: 20),
            color: AppColors.dividerColor,
          )
        ],
      ),
    );
  }

  static reactiveTextFieldNoIcon(
      {String formControlName = '',
      preventSpace = false,
      Color iconColor = AppColors.filedBg,
      String lable = '',
      TextStyle lableStyle = const TextStyle(),
      Color fillColor = AppColors.registerFiled,
      bool isNumber = false,
      isPassword = false,
      OutlineInputBorder outlineInputBorder = const OutlineInputBorder()}) {
    const double paddingHieght = 20.0;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: ReactiveTextField<String>(
        formControlName: formControlName,
        // validationMessages: (control) => {
        //   ValidationMessage.required:
        //       lable.tr + ' ' + AppStrings.mustNotEmpty.tr,
        //   if (isPassword)
        //     ValidationMessage.minLength: AppStrings.passwordLengthHint,
        //   // 'unique': 'This email is already in use',
        // },
        textInputAction: TextInputAction.next,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        inputFormatters: [
          if (isNumber) FilteringTextInputFormatter.digitsOnly,
          if (preventSpace)
            FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))
        ],
        obscureText: isPassword,
        style: lableStyle,
        decoration: InputDecoration(
          labelText: lable.tr,
          labelStyle: lableStyle,
          filled: true,
          fillColor: fillColor,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 12, vertical: paddingHieght),
          hintText: '',
          errorStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
          errorBorder: outlineInputBorder,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
          border: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          enabledBorder: outlineInputBorder,
        ),
      ),
    );
  }

  static reactiveTextFieldProfile(
      {String formControlName = '',
      IconData iconData = Icons.person,
      Color iconColor = AppColors.filedBg,
      String validationMessage = '',
      String lable = '',
      TextStyle lableStyle = const TextStyle(),
      Color fillColor = AppColors.white,
      bool isNumber = false,
      isPassword = false,
      OutlineInputBorder outlineInputBorder = const OutlineInputBorder()}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 2.w),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          lable.tr,
                          style: AppStyles.subTitleStyle(),
                        )),
                      ],
                    ),
                    //  Spacer(),
                  ],
                )),
            UiHelper.horizontalSpaceMedium,
            Expanded(
              flex: 11,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: ReactiveTextField<String>(
                      formControlName: formControlName,
                      // validationMessages: (control) => {
                      //   ValidationMessage.required:
                      //       lable.tr + ' ' + AppStrings.mustNotEmpty.tr,
                      //   if (isPassword)
                      //     ValidationMessage.minLength:
                      //         AppStrings.passwordLengthHint,
                      //   // 'unique': 'This email is already in use',
                      // },
                       textInputAction: TextInputAction.next,
                      keyboardType:
                          isNumber ? TextInputType.number : TextInputType.text,
                      inputFormatters: [
                        if (isNumber) FilteringTextInputFormatter.digitsOnly
                      ],
                      style: AppStyles.primaryStyle(fontSize: 15),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    height: 2.h,
                    width: Get.width.w,
                    //margin: EdgeInsets.symmetric(horizontal: 20),
                    color: AppColors.primaryColorGreen,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static reactiveTextField(
      {String formControlName = '',
      preventSpace = false,
      int length = 10,
      bool isAlphanumeric = false,
      isLocation = false,
      bool isPhone = false,
      bool isName = false,
      IconData iconData = Icons.person,
      Color iconColor = AppColors.filedBg,
      String validationMessage = '',
      String validationMessagePassword = '',
      String lable = '',
      TextStyle lableStyle = const TextStyle(),
      Color fillColor = AppColors.registerFiled,
      bool isNumber = false,
      isPassword = false,
      isSSN = false,
      OutlineInputBorder outlineInputBorder = const OutlineInputBorder(),
      Widget? locationBtn}) {
    final double paddingHeight = 20.0.h;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 5.h,
      ),
      child: ReactiveTextField<String>(
        formControlName: formControlName,
        // validationMessages: (control) => {
        //   ValidationMessage.required:
        //       lable.tr + ' ' + AppStrings.mustNotEmpty.tr,
        //   if (isPassword)
        //     ValidationMessage.minLength: AppStrings.passwordLengthHint.tr,
        //   // 'unique': 'This email is already in use',
        // },
        textInputAction: TextInputAction.next,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        inputFormatters: [
          if (isAlphanumeric)
            FilteringTextInputFormatter.allow(RegExp(RegExps.alphanumeric)),
          if (isNumber) FilteringTextInputFormatter.digitsOnly,
          if (preventSpace)
            FilteringTextInputFormatter.deny(RegExp(RegExps.hasSpace)),
          if (isPhone || isAlphanumeric)
            LengthLimitingTextInputFormatter(length),
          if (isSSN) FilteringTextInputFormatter.allow(RegExp(RegExps.isSSN)),
          if (isName)
            FilteringTextInputFormatter.allow(RegExp(
              RegExps.isName,
              dotAll: true,
            )),
        ],
        style: lableStyle,
        cursorColor: AppColors.primaryColorGreen,
        onEditingComplete: (t) {},
        decoration: InputDecoration(
          labelText: lable.tr,
          labelStyle: lableStyle,
          hintStyle: lableStyle,
          filled: true,
          fillColor: fillColor,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 18.w, vertical: paddingHeight),
          hintText: lable.tr,
          errorStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
          errorBorder: outlineInputBorder,
          //  hintStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
          //  prefixIcon:!isLocation ?Icon(iconData, color: iconColor):null,
          //prefixIcon:UiHelper.horizontalSpace(5),

          border: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          enabledBorder: outlineInputBorder,
        ),
      ),
    );
  }

  static reactiveRegisterTextField(
      {String formControlName = '',
      preventSpace = false,
      int length = 10,
      isLocation = false,
      bool noStartZero = false,
      bool isPhone = false,
      bool isName = false,
      IconData iconData = Icons.person,
      Color iconColor = AppColors.filedBg,
      String validationMessage = '',
      String validationMessagePassword = '',
      String label = '',
      String hint = '',
      TextStyle lableStyle = const TextStyle(),
      Color fillColor = AppColors.registerFiled,
      bool isNumber = false,
      isPassword = false,
      isSSN = false,
      OutlineInputBorder outlineInputBorder = const OutlineInputBorder(),
      Function? onTab}) {
    final double paddingHeight = 20.h;

    return Container(
      // height: 80,
      decoration: Ui.getBoxDecorationLogin(),
      child: ReactiveTextField<String>(

        autofocus: false,
        formControlName: formControlName,

        validationMessages: {
          ValidationMessage.required: (error) => AppStrings.mustNotEmpty.tr,
          ValidationMessage.minLength: (error) => validationMessage.tr
        },
        // validationMessages: (control) => {
        //   ValidationMessage.required:
        //       label.tr + ' ' + AppStrings.mustNotEmpty.tr,
        // },
        onTap: (t) {
          if (onTab != null) {
            onTab();
          }
        },
        style: AppStyles.primaryStyleGreen(),
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
         // errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,

          labelText: label.tr.capitalizeFirst,
          labelStyle: AppStyles.subTitleStyle(),
          // filled: true,

          //  fillColor: AppColors.filedBg ,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 12.w, vertical: paddingHeight),
          hintText: hint.isNotEmpty ? ' ( ${hint.tr} ) ' : label.tr,
          errorStyle: TextStyle(color: AppColors.red.withOpacity(0.7)),
          hintStyle: AppStyles.subTitleStyle(),




          // errorText: validationMessage.tr,
          // errorBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10.r),
          //   borderSide: BorderSide(color: AppColors.red.withOpacity(.5))
          // )
          // prefixIcon: Icon(Icons.call,
          //
          //     color: Colors.white),
        ),
        textInputAction: TextInputAction.next,
        keyboardType: (isNumber || isSSN || isPhone)
            ? TextInputType.number
            : TextInputType.text,
        inputFormatters: [
          if (isNumber || isSSN || isPhone)
            FilteringTextInputFormatter.digitsOnly,
          if (preventSpace)
            FilteringTextInputFormatter.deny(RegExp(RegExps.hasSpace)),
          // if(isNumber||isSSN||isPhone)
          LengthLimitingTextInputFormatter(length),
          if (isSSN) FilteringTextInputFormatter.allow(RegExp(RegExps.isSSN)),

          if (noStartZero)
            FilteringTextInputFormatter.allow(RegExp(RegExps.nonStartZero)),

          if (isPhone)
            FilteringTextInputFormatter.allow(RegExp(RegExps.isPhone)),

          if (isName)
            FilteringTextInputFormatter.allow(RegExp(
              RegExps.isName,
              dotAll: true,
            )),
        ],
      ),
    );
  }

  static reactiveRegisterPasswordTextField({
    String formControlName = '',
    preventSpace = false,
    int length = 10,
    isLocation = false,
    bool isPhone = false,
    bool isName = false,
    bool hidePassword = false,
    AuthController? logic,
    IconData iconData = Icons.person,
    Color iconColor = AppColors.filedBg,
    String validationMessage = '',
    String validationMessagePassword = '',
    String label = '',
    TextStyle lableStyle = const TextStyle(),
    Color fillColor = AppColors.registerFiled,
    bool isNumber = false,
    isPassword = false,
    isSSN = false,
    OutlineInputBorder outlineInputBorder = const OutlineInputBorder(),
  }) {
    final double paddingHeight = 20.h;

    return Container(
      decoration: Ui.getBoxDecorationLogin(),
      child: ReactiveTextField<String>(
        formControlName: formControlName,
        obscureText: logic!.hidePassword,


        validationMessages: {
          ValidationMessage.required: (error) => AppStrings.mustNotEmpty.tr,
          ValidationMessage.minLength: (error) => validationMessage.tr,
          ValidationMessage.pattern: (error) =>  AppStrings.passwordPatternHint.tr,

        },

        // validationMessages: (control) => {
        //   'required': AppStrings.password.tr + ' ' + AppStrings.mustNotEmpty.tr,
        //   'minLength': AppStrings.passwordLengthHint.tr,
        // },
        style: AppStyles.primaryStyleGreen(),
        textInputAction: TextInputAction.done,
        inputFormatters: [
          LengthLimitingTextInputFormatter(12),

          // FilteringTextInputFormatter.allow(logic.passwordRegex,),

        ],
        decoration: InputDecoration(
          //  filled: true,

          //fillColor: AppColors.filedBg ,
          border: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,

          labelText: label.tr.capitalizeFirst,
          labelStyle: AppStyles.subTitleStyle(),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 12.w, vertical: paddingHeight),
          hintText: '••••••••••••',
          errorStyle: TextStyle(color: Colors.red.withOpacity(0.7)),
          hintStyle:
              TextStyle(color: AppColors.primaryColorGreen.withOpacity(0.7)),
          // prefixIcon: Icon(Icons.lock,
          //     color: AppColors.primaryColorGreen),
          suffixIcon: IconButton(
            onPressed: () {
              // logic.hidePassword =
              // !logic.hidePassword;
              logic.updatePassword(!logic.hidePassword);
            },
            color: Colors.white,
            icon: Icon(
              logic.hidePassword ? Icons.visibility_off : Icons.visibility,
              color: AppColors.primaryColorGreen,
            ),
          ),
        ),
      ),
    );
  }

  static reactiveTextFieldSleepQu(
      {String formControlName = '',
      double widthTitle = 65,
      bool noStartZero = false,
      preventSpace = false,
      isLocation = false,
      bool isPhone = false,
      IconData iconData = Icons.person,
      Color iconColor = AppColors.filedBg,
      String validationMessage = '',
      String validationMessagePassword = '',
      String lable = '',
      TextStyle lableStyle = const TextStyle(),
      Color fillColor = AppColors.registerFiled,
      bool isNumber = false,
      isPassword = false,
      isSSN = false,
      OutlineInputBorder outlineInputBorder = const OutlineInputBorder(),
      int length = 3}) {
    final double paddingHeight = 20.0.h;
    final double radius = 10.0.h;
    var ar = Get.locale.toString() == 'ar';
    return Expanded(
      child: Container(
        height: 55.h,
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryColor),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(ar ? radius + 3.h : 0),
              topRight: Radius.circular(ar ? 0 : radius + 3.h),
              bottomLeft: Radius.circular(radius + 3.h),
              bottomRight: Radius.circular(radius + 3.h),
            )),
        //padding: EdgeInsets.symmetric(vertical: 5,),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Container(
                      width: widthTitle.w,
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(ar ? radius.h : 0),
                            topRight: Radius.circular(ar ? 0 : radius.h),
                            bottomLeft: Radius.circular(radius.h),
                            bottomRight: Radius.circular(radius.h),
                          )),
                      child: Text(
                        lable,
                        textAlign: TextAlign.center,
                        style: AppStyles.whiteStyle(
                            size: 10, bold: true, height: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                  child: ReactiveTextField<String>(
                    formControlName: formControlName,
                    // validationMessages: (control) => {
                    //   ValidationMessage.required:
                    //       lable.tr + ' ' + AppStrings.mustNotEmpty.tr,
                    //   if (isPassword)
                    //     ValidationMessage.minLength:
                    //         AppStrings.passwordLengthHint.tr,
                    //   // 'unique': 'This email is already in use',
                    // },
                    textInputAction: TextInputAction.next,
                    keyboardType:
                        isNumber ? TextInputType.number : TextInputType.text,
                    inputFormatters: [
                      if (isNumber) FilteringTextInputFormatter.digitsOnly,
                      if (preventSpace)
                        FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s")),
                      if (isPhone) LengthLimitingTextInputFormatter(length),
                      if (isSSN)
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^[12][0-9]*$')),
                      if (noStartZero)
                        FilteringTextInputFormatter.allow(
                            RegExp(RegExps.nonStartZero)),
                    ],
                    style: lableStyle,
                    cursorColor: AppColors.primaryColorGreen,
                    onEditingComplete: (t) {},
                    decoration: InputDecoration(
                      //  labelText: lable.tr,
                      labelStyle: lableStyle,
                      hintStyle: lableStyle,
                      filled: true,
                      fillColor: fillColor,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 5.w, vertical: paddingHeight),
                      //  hintText: lable.tr,
                      errorStyle:
                          TextStyle(color: Colors.white.withOpacity(0.7)),
                      errorBorder: InputBorder.none,
                      //  hintStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
                      //  prefixIcon:!isLocation ?Icon(iconData, color: iconColor):null,
                      //prefixIcon:UiHelper.horizontalSpace(5),

                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


 // static String _passwordPatternError='Password must have at least:\n'
 //      '- 1 uppercase letter\n'
 //      '- 1 lowercase letter\n'
 //      '- 1 number\n'
 //      '- 1 special character\n'
 //      '- Minimum length of 8 characters';


}
