import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../global_widgets/shared/ui_helpers.dart';
import 'observation_logic.dart';

class AddObservationPage extends StatelessWidget {
  final logic = Get.put(ObservationLogic());
  static const routeName='/AddObservationPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          minimum: UiHelper.safeAreaPadding,
          child: Column(children: [

//             myAppBar2(title: AppStrings.addObservation,),
//
//             Expanded(child: GetBuilder<ObservationLogic>(builder: (logic) {
//               return SingleChildScrollView(
//                 child: Wrap(
//                   children: [
//                     Column(children: [
//
//
//
//                       UiHelper.verticalSpaceMedium,
//
//
//                       DropDownItem(title: 'Nutritional Status',controller: logic.nutritionalStatusCtrl, list: logic
//                           .statesList, hint: AppStrings.selectStatus,id: logic.nutritionalStatusValue,onSelect: (item){
//                         logic.nutritionalStatusValue=item.name.toString();
//                       }),
//
//                       DropDownItem(title:'Sleeping Pattern' ,controller: logic.sleepingPatternCtrl, list: logic
//                           .statesList, hint: AppStrings.selectStatus,id: logic.sleepingPatternValue,onSelect: (item){
//                         logic.sleepingPatternValue=item.name.toString();
//                       }),
//
//
//
//
//
// Theme(
//   data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
//
//   child:   ExpansionTile(
//
//
// childrenPadding: EdgeInsets.symmetric(horizontal: 10.w),
//
//
//     title:   Text('Task/ Activities Provided',style: AppStyles.primaryStyle(bold: true),),
//
//   leading: null,
//
//     tilePadding: EdgeInsets.symmetric(horizontal: 0),
//
//
// onExpansionChanged: (_expanded){
//       logic.updateExpanded(_expanded);
// },
//     trailing: Icon(logic.expanded?Icons.keyboard_arrow_up: Icons.keyboard_arrow_down,color:logic.expanded? AppColors.primaryColorGreen:AppColors.primaryColor,),
//
//   children: [
//
//     Container(
//
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10.h),
//         color: AppColors.primaryColorGreenOpacity2
//       ),
//       padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
//       child: Column(
//         children:ObservationTask.tasks.map((e) => DropDownItem(title:e.title,fontTitleBold: false,fillColor: AppColors.primaryColorGreenOpacity2,hasBottomBorder: true ,controller: e.dropdownCtrl!,reasonCtrl: e.reasonCtrl!, list: logic
//             .taskStatesList, hint: AppStrings.select,id: '',hasReason: e.dropdownCtrl!.text==logic.taskStatesList[1].name,onSelect: (item){
//
//           e.dropdownCtrl!.text=item.name;
//
//           logic.update();
//
//
//
//           // logic.sleepingPatternValue=item.name.toString();
//         })).toList(),
//       ),
//     ),
//
//
//
//   ],
//
//   ),
// ),
//
//
//                       UiHelper.verticalSpaceLarge,
//
//                       Container(
//                         padding: EdgeInsets.only(top: 5.h),
//                         decoration: BoxDecoration(
//                             color: AppColors.primaryColorOpacity,
//                             borderRadius: BorderRadius.circular(10)
//                         ),
//                         child: Row(
//                           children: [
//                             BottomSheetLine(title: 'Progress Noted',length: 10000, controller: logic.progressNotedCtrl,isMultLine: true,unit: '',),
//                           ],
//                         ),
//                       ),
//                       UiHelper.verticalSpaceMedium,
//
//
//
//                       Row(
//                         children: [
//
//                           Expanded(child:   Ui.primaryButton(title: 'Reset',color: AppColors.primaryColorGreen,fontSize: 15,onTab: (){
//
//                             logic.resetTextCtrl();
//
//                           }),),
//
//                           UiHelper.horizontalSpaceMedium,
//
//                           Expanded(child:   Ui.primaryButton(title: 'Save',fontSize: 15,onTab: (){
//                           //  Get.back();
//
//                             logic.addObservation();
//                        //  print(logic.toJson());
//                           }),),
//
//                         ],
//                       )
//                     ],),
//                   ],
//                 ),
//               );
//             }))
//
          ]



          ,),
        ),

    );
  }
}
