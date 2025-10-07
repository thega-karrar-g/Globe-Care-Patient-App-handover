import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme_helper/app_colors.dart';
import '../ui.dart';
import 'bottom_sheet_text_form.dart';
import 'ui_helpers.dart';
 class BottomSheetLine extends StatelessWidget {
   const BottomSheetLine({Key? key,required this.title,required this.controller,this.height=55,this.paddingH=5.0,this.isInt=false,this.hasBorder=true,this.hasSlash=false,this.isDecimal=false,this.isMultLine=false,this.length=4,this.unit='bpm',this.flex=1}) : super(key: key);
 final String  title;
final TextEditingController controller;
   final bool isInt,hasSlash,hasBorder,isDecimal,isMultLine;
   final int length,flex;
   final  String unit;
  final double paddingH,height;

   @override
   Widget build(BuildContext context) {
     return Expanded(
       flex: flex,
       child: Container(
         decoration: BoxDecoration(
           color: AppColors.primaryColorOpacity,
           borderRadius: BorderRadius.circular(10.h)
         ),
         margin: EdgeInsets.symmetric(vertical: 0),
         padding: EdgeInsets.symmetric(horizontal: paddingH.w
         ),
         child: Column(children: [
           Ui.titlePrimary(title,topPadding: 5,fontSize: 12),
           Row(
             children: [
               Expanded(child: BottomSheetTextForm(controller: controller,unit: unit,hasBorder: hasBorder,length: length,isInt: isInt,hasSlash: hasSlash,isDecimal: isDecimal,isMultiLine: isMultLine,height: height,)),
             ],
           )
           ,
           UiHelper.verticalSpaceMedium,

         ],),
       ),
     );
   }
 }
