import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:globcare/app/global_widgets/shared/ui_helpers.dart';

import '../../core/theme_helper/app_colors.dart';
import '../../core/theme_helper/app_styles.dart';

class RadioFormBuilder extends StatelessWidget {
  const RadioFormBuilder({Key? key,this.title='',this.formKey='',this.initialValue='',this.paddingV=5,this.paddingH=15,this.marginV=0,this.isRequired=true,this.enabled=true,this.values= const{},required this.onChange}) : super(key: key);

  final String title,formKey,initialValue;
 final Map<String,String>  values;
 final Function(String) onChange;
 final double paddingV,paddingH,marginV;
 final bool isRequired,enabled;

  @override
  Widget build(BuildContext context) {
    return  RadioTheme(
      data: RadioThemeData(

fillColor: MaterialStateColor.resolveWith((states) => AppColors.primaryColor)

      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical:marginV.h ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.question_mark_sharp,color: AppColors.primaryColor,),
                UiHelper.horizontalSpaceSmall,

                Flexible(child: Text(title.tr,style: AppStyles.primaryStyle(fontSize: 13),)),
              ],
            ),
            UiHelper.verticalSpaceSmall,
            FormBuilderRadioGroup<String>(
              name: formKey,
              decoration: InputDecoration(
                // labelText: title.tr,

                labelStyle: AppStyles.primaryStyle(bold: true,fontSize: 13,color: AppColors.primaryColorGreen),
                // fillColor: Colors.red,
                // focusColor: Colors.blue,
                // hoverColor: Colors.yellow,

                floatingLabelAlignment: FloatingLabelAlignment.start,
                fillColor: AppColors.primaryColor,

                contentPadding: EdgeInsets.symmetric(vertical: paddingV.h,horizontal: paddingH.w),


                alignLabelWithHint: false,

                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide:  BorderSide(color: AppColors.primaryColor.withOpacity(.1)),
                  gapPadding: 0,
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide:  BorderSide(color: AppColors.primaryColor.withOpacity(.5)),
                  // gapPadding: 30.w
                ),
              ),

              wrapSpacing: 0,
              wrapRunSpacing: 0,


              enabled: enabled,


              onChanged: ( v){
                onChange(v as String);
              },


              wrapAlignment: WrapAlignment.spaceEvenly,
              wrapRunAlignment: WrapAlignment.spaceBetween,
              validator: FormBuilderValidators.compose([
                if (isRequired) FormBuilderValidators.required(),

              ]),
              activeColor: AppColors.primaryColor,



              options: values.keys.map((e) => FormBuilderFieldOption(

                value: e,child: Text(values[e].toString().tr,textAlign: TextAlign.center,style:AppStyles.primaryStyle(color:AppColors.primaryColor,fontSize: 13),),

              )).toList(),
              initialValue: initialValue.isNotEmpty?initialValue: null ,

            ),
          ],
        ),
      ),
    );
  }
}
