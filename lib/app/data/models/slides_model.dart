import '../../core/language_and_localization/app_strings.dart';
import '../../core/assets_helper/app_images.dart';

class SliderModel {
  int id;
  String title, description, image, code;


  SliderModel(
      {this.id = 0,
      this.title = '',
      this.description = '',
      this.image = '',
      this.code = ''});

 factory SliderModel.fromJson(Map<String, dynamic> map)=>SliderModel(
     id: map['id'] ??0,
     title: map['name'] ??'',
     image: map['image_url'] ??""

 );

  Map toMap() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["text"] = title;

    return map;
  }

  @override
  bool operator ==(dynamic other) {
    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  static List<SliderModel> slides = [
    SliderModel(
        title: AppStrings.telemedicine,
        description: AppStrings.telemedicineDescription,
        image: AppImages.iconTeleMed,
        code: 'TD'),
    SliderModel(
        title: AppStrings.homeVisitDoctor,
        description: AppStrings.hvdDescription,
        image: AppImages.iconHVD,
        code: 'HVD'),
    SliderModel(
        title: AppStrings.geriatricCare,
        description: AppStrings.geriatricDescription,
        image: AppImages.iconGer,
        code: 'GCP'),
    SliderModel(
        title: AppStrings.covidPCR,
        description: AppStrings.pcrDescription,
        image: AppImages.iconPcr,
        code: 'PCR'),
    SliderModel(
        title: AppStrings.homeRadiology,
        description: AppStrings.radiologyDescription,
        image: AppImages.iconXRay,
        code: 'R'),
    SliderModel(
        title: AppStrings.sleepMedicine,
        description: AppStrings.sleepDescription,
        image: AppImages.iconSleep,
        code: 'SM'),
    SliderModel(
        title: AppStrings.manHealth,
        description: AppStrings.manHealthDescription,
        image: AppImages.iconMan,
        code: 'MH'),
    SliderModel(
        title: AppStrings.nurse,
        description: AppStrings.nurseDescription,
        image: AppImages.iconNurse,
        code: 'N'),
    SliderModel(
        title: AppStrings.homeLaboratory,
        description: AppStrings.homeLaboratoryDescription,
        image: AppImages.iconLab,
        code: 'L'),
    SliderModel(
        title: AppStrings.physiotherapist,
        description: AppStrings.physiotherapyDescription,
        image: AppImages.iconPhys,
        code: 'PHY'),
    SliderModel(
        title: AppStrings.ivAntibioticVitamin,
        description: AppStrings.ivTherapyDescription,
        image: AppImages.iconIV,
        code: 'IVT'),
    SliderModel(
        title: AppStrings.caregiver,
        description: AppStrings.caregiverDescription,
        image: AppImages.iconCaregiver,
        code: 'Car'),
    SliderModel(
        title: AppStrings.diabeticCare,
        description: AppStrings.diabeticCareDescription,
        image: AppImages.iconDiabetic,
        code: 'Diab'),
    SliderModel(
        title: AppStrings.vaccination,
        description: AppStrings.vaccinationDescription,
        image: AppImages.iconVac,
        code: 'V'),
    SliderModel(
        title: AppStrings.woundCare,
        description: AppStrings.woundCareDescription,
        image: AppImages.iconWound,
        code: 'WBSDFC'),
  ];
}

