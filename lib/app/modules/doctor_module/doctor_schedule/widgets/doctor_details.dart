import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../data/models/m_doctors.dart';
import '../../../../global_widgets/shared/dynamic_column.dart';
import 'doctor_details_item.dart';

class DoctorDetails extends StatelessWidget {
  const DoctorDetails({Key? key, required this.doctor}) : super(key: key);

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    var ar = Get.locale.toString() == 'ar';

    return DynamicColumn(
      children: [
        DoctorDetailsItem(
          title: AppStrings.medicalLicense,
          description: doctor.medicalLicense!,
        ),
        DoctorDetailsItem(
          title: AppStrings.scientificExpertise,
          description:
              ar ? doctor.scientificExpertiseAr! : doctor.scientificExpertise!,
        ),
        DoctorDetailsItem(
          title: AppStrings.practicalExpertise,
          description:
              ar ? doctor.practicalExpertiseAr! : doctor.practicalExpertise!,
        ),
        // DoctorDetailsItem(title:AppStrings.languages,description: doctor.languages!,),
        // DoctorDetailsItem(title:AppStrings.country,description:ar?doctor.countryAr!: doctor.country!,),
      ],
    );
  }
}
