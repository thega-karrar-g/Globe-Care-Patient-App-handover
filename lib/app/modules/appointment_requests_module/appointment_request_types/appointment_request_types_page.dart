import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global_widgets/shared/dynamic_column.dart';
import '../../appointment/widgets/appointment_type_item.dart';
import 'appointment_request_types_controller.dart';

class AppointmentRequestTypesPage extends StatelessWidget {
  final controller = Get.put(AppointmentRequestTypesController());

   AppointmentRequestTypesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColumn(
      children: controller.appointmentTypes
          .map((e) => AppointmentTypeItem(
        homeService: e,
        onTab: ()=>controller.onRequestTypeTab(e),
      ))
          .toList(),
    );
  }
}
