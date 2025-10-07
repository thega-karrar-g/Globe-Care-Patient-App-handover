
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme_helper/app_colors.dart';
import '../../core/theme_helper/app_styles.dart';
class BottomSheetTextForm extends StatelessWidget {
  const BottomSheetTextForm({Key? key,required this.controller,this.height=55,this.isInt=false,this.isDecimal=true,this.hasSlash=false,this.hasBorder=true,this.isMultiLine=false,this.length=4,this.unit='bpm'}) : super(key: key);
  final  TextEditingController controller;
  final bool isInt,hasSlash,hasBorder,isDecimal,isMultiLine;
  final int length;
  final  String unit;
  final double height;
  @override
  Widget build(BuildContext context) {
    return    Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 10.h),
      width: 150.w,
      height:isMultiLine?height.h: 45.h,
      decoration: BoxDecoration(
          border:hasBorder? Border.all(color: AppColors.primaryColor):Border.fromBorderSide(BorderSide.none),
          borderRadius: BorderRadius.circular(10.h)
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              style: AppStyles.primaryStyle(bold: true,height: 1.5),
              cursorColor: AppColors.primaryColor,
              controller: controller,
              minLines: isMultiLine?null:1,
              maxLines: isMultiLine?null:1,
textAlignVertical: TextAlignVertical.top,
              textAlign: TextAlign.start,
              expands:isMultiLine,
              keyboardType: isMultiLine? TextInputType.multiline:(isInt||isDecimal)?TextInputType.number:TextInputType.text,

              decoration: InputDecoration(
                border:InputBorder.none,

                contentPadding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 3.h),

                focusedErrorBorder:InputBorder.none,
                disabledBorder:InputBorder.none,
                enabledBorder:InputBorder.none,
                errorBorder:InputBorder.none,
                focusedBorder:InputBorder.none,
              ),
              inputFormatters: [


                if(hasSlash||isInt)
                  FilteringTextInputFormatter.allow(RegExp("[0-9/]"))
                else if(isDecimal)
                  FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
                ,

                LengthLimitingTextInputFormatter(length),




              ],

            ),
          ),
          Text(unit,style: AppStyles.primaryStyle(fontSize: 13,color: AppColors.primaryColorGreen),)
        ],
      ),
    )
    ;
  }
}
