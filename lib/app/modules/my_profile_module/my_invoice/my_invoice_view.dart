import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globcare/app/core/theme_helper/app_styles.dart';
import 'package:globcare/app/data/api/app_urls.dart';
import 'package:globcare/app/global_widgets/shared/ui_helpers.dart';
import 'package:globcare/app/utils/launcher.dart';

import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_colors.dart';
import '../../../global_widgets/shared/my_appbar.dart';
import '../../../global_widgets/ui.dart';
import 'my_invoice_controller.dart';

class MyInvoicePage extends StatelessWidget {
  MyInvoicePage({super.key});
static const routeName="/MyInvoicePage";
  final MyInvoiceController controller = Get.put(MyInvoiceController());

  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(child: Center(
      child: Column(

        children: [

        myAppBar2(title: AppStrings.invoices),

        UiHelper.verticalSpaceMassive,


        Text(AppStrings.invoiceMsg.tr,style: AppStyles.primaryStyle(bold: false,fontSize: 18),),
          UiHelper.verticalSpaceLarge,

          Row(
            children: [
              Expanded(child: Ui.primaryButton(title: AppStrings.openLink,paddingH: 10,paddingV: 10,color: AppColors.primaryColor,marginV: 0,fontSize: 12,onTab: (){




                Launcher.launchInBrowser(AppUrls.baseUrl.replaceAll("sehati/", ''));



              })),
            ],
          ),



        ],),
    ));
  }
}
