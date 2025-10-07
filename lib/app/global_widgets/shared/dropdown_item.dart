import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import '../../core/language_and_localization/app_strings.dart';
import '../../core/theme_helper/app_colors.dart';
import '../../core/theme_helper/app_styles.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bottom_sheet_line.dart';
import 'ui_helpers.dart';

class DropDownItem extends StatelessWidget {
   DropDownItem({Key? key,required this.controller,this.reasonCtrl,required this.list,this.fillColor,required this.hint,this.title='', this.id='',required this.onSelect,this.hasReason=false,this.hasBottomBorder=false,this.fontTitleBold=true,this.fontSizeTitle=13}) : super(key: key);
  final List<Item> list;
  final  TextEditingController controller;
  final  TextEditingController? reasonCtrl;
  final Color? fillColor;
   String hint,id,title;
  final double fontSizeTitle;
   final bool hasReason,hasBottomBorder,fontTitleBold;
Function (Item)onSelect;

  @override
  Widget build(BuildContext context) {
    return   Column(
      children: [

        SizedBox(
          height: 50.h,
          child: Row(
            children: [

if(title.isNotEmpty)
              Expanded(
                  flex: 2,
                  child: Row(
                children: [


                  Expanded(child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 5.w),
                    child: Text(title,style: AppStyles.primaryStyle(bold: fontTitleBold,fontSize: fontSizeTitle),),
                  )),



                ],
              )),



              Expanded(
                flex: 2,
                child: CustomDropdown(
                  hintText: hint.tr,
                  items: list,

                  controller: controller,
                  fillColor: fillColor??AppColors.primaryColorOpacity,
                  borderSide: BorderSide(color: AppColors.primaryColor),
                  selectedStyle: AppStyles.primaryStyle(bold: true),
                  hintStyle: AppStyles.subTitleStyle(),
                  fieldSuffixIcon: Icon(Icons.keyboard_arrow_down_outlined,color: AppColors.primaryColor,),
                  borderRadius: BorderRadius.circular(10.h),
                  searchHint: AppStrings.search.tr,
                  searchColor: AppColors.primaryColor,
                  listItemStyle: AppStyles.primaryStyle(bold: false,fontSize: 16),

onChanged: (t){
},
                 onItemSelect: onSelect

                ),
              ),
            ],
          ),
        ),

        if(hasReason)
          UiHelper.verticalSpaceSmall,

        if(hasReason)

          Row(children: [
            BottomSheetLine(title: 'Reason no done/comment',length: 10000, controller: reasonCtrl!,isMultLine: true,unit: '',paddingH: 0,),


          ],),

        hasBottomBorder?UiHelper.verticalSpaceSmall:  UiHelper.verticalSpaceMedium,

        if(hasBottomBorder)
        DottedLine(
          direction: Axis.horizontal,
          lineLength: double.infinity,
          lineThickness: 1.0,
          dashLength: 3.0,
          dashColor: AppColors.subTitleColor,
          // dashGradient: [Colors.red, Colors.blue],
          dashRadius: 0.0,
          dashGapLength: 5.0,
          dashGapColor: Colors.transparent,
          // dashGapGradient: [Colors.red, Colors.blue],
          dashGapRadius: 0.0,
        ),

        hasBottomBorder?UiHelper.verticalSpaceSmall:  UiHelper.verticalSpaceMedium,





      ],
    );
  }
}
