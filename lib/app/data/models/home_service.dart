import '../../core/language_and_localization/app_strings.dart';
import '../../modules/booking_home_modules/iv_therapy/therapy_types/iv_therapy_types_view.dart';
import '../../routes/app_route_names.dart';
import '../../core/assets_helper/app_images.dart';
import 'user_model.dart';

class HomeService {
  HomeService(
      {this.id = 0,
      this.user,
      this.name = '',
      this.icon = '',
      this.route = '',
      this.next = AppRouteNames.homeAppointment,
      this.code = '',
      this.description = '',this.url='',
      this.primary = true


      });

  int id;
  String name = '',
      icon = '',
      route = '',
      next = '',
      code = '',
      description = '',url;
  AppUser? user;
  bool primary = true;

  factory HomeService.fromJson(Map<String, dynamic> json) => HomeService(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        icon: json['icon'] ?? '',
        route: json['route'] ?? '',
        next: json['next'] ?? '',
        code: json['code'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": icon,
      };

  static List homeServices = [
    HomeService(
        name: AppStrings.nurse,
        icon: AppImages.iconNurse,
        route: AppRouteNames.map,
        next: AppRouteNames.nurseServices,

        code: 'HHC'),
    HomeService(
        name: AppStrings.physiotherapist,
        icon: AppImages.iconPhys,
        route: AppRouteNames.map,
        next: AppRouteNames.physiotherapistServices,
        code: 'PHY'),

    HomeService(
        name: AppStrings.caregiver,
        icon: AppImages.iconCaregiver,
        route: AppRouteNames.map,
        next: AppRouteNames.nurseServices,
        // next: AppRouteNames.serviceDetails,
        code: 'Car'),



    HomeService(
        name: AppStrings.sleepMedicine,
        icon: AppImages.iconSleep,
        route: AppRouteNames.map,
        // next: AppRouteNames.serviceDetails,
        next: AppRouteNames.nurseServices,

        code: 'SM'),


  ];

  static List<HomeService> homeServicesHorizontal = [
    //  HomeService(name: AppStrings.covidPCR,icon: AppImages.pcrTest,route: AppRouteNames.map,next: ''),
    //   HomeService(name: AppStrings.caregiver,icon: AppImages.iconCaregiver,route: AppRouteNames.map,next: AppRouteNames.serviceDetails,code: 'Car'),


    HomeService(
        name: AppStrings.laboratoryRadiology,
        icon: AppImages.iconLab,
        route: AppRouteNames.map,
        next: AppRouteNames.labRadiologyTypesPage,
        code: 'L'),

    HomeService(
        name: AppStrings.geriatricCare,
        icon: AppImages.iconGer,
        route: AppRouteNames.map,
        next: AppRouteNames.serviceDetails,
        code: 'GCP'),

    HomeService(
        name: AppStrings.telemedicine,
        icon: AppImages.iconTeleMed,
        route: AppRouteNames.map,
        next: AppRouteNames.doctors,
        code: 'Tel'),
    HomeService(
        name: AppStrings.homeVisitDoctor,
        icon: AppImages.iconHVD,
        route: AppRouteNames.map,
        next: AppRouteNames.doctors,
        code: 'HVD'),


    HomeService(
        name: AppStrings.woundCare,
        icon: AppImages.iconWound,
        route: AppRouteNames.map,
        next: AppRouteNames.serviceDetails,
        code: 'WBSDFC'),
    HomeService(
        name: AppStrings.ivAntibioticVitamin,
        icon: AppImages.iconIV,
        route: AppRouteNames.map,
        next: IVTherapyTypesPage.routeName,
        code: 'IVT'),

    HomeService(
        name: AppStrings.manHealth,
        icon: AppImages.iconMan,
        route: AppRouteNames.map,
        next: AppRouteNames.serviceDetails,
        code: 'MH'),

    // HomeService(name: AppStrings.geriatricCare,icon: AppImages.iconGer,route: AppRouteNames.map,next: AppRouteNames.serviceDetails,code: 'GCP'),

    HomeService(
        name: AppStrings.vaccination,
        icon: AppImages.iconVac,
        route: AppRouteNames.map,
        next: AppRouteNames.vaccination,
        code: 'V'),

    // HomeService(name: AppStrings.manHealth,icon: AppImages.iconMan,route: AppRouteNames.map,next: AppRouteNames.serviceDetails,code: 'MH'),


    HomeService(
        name: AppStrings.diabeticCare,
        icon: AppImages.iconDiabetic,
        route: AppRouteNames.map,
        next: AppRouteNames.serviceDetails,
        code: 'Diab'),



    HomeService(
        name: AppStrings.laboratoryRadiology,
        icon: AppImages.iconLab,
        route: AppRouteNames.map,
        next: AppRouteNames.labRadiologyTypesPage,
        code: 'L'),

    HomeService(
        name: AppStrings.geriatricCare,
        icon: AppImages.iconGer,
        route: AppRouteNames.map,
        next: AppRouteNames.serviceDetails,
        code: 'GCP'),

  ];

  static List<HomeService> appointmentTypes = [
    HomeService(
        id: 1,
        name: AppStrings.pcrAppointments,
        description: AppStrings.pcrAppointments,
        icon: AppImages.iconPcr,
        code: 'pcr'),
    HomeService(
        id: 1,
        name: AppStrings.telemedicineAppointments,
        description: AppStrings.telemedicineAppointments,
        icon: AppImages.iconTeleMed,
        code: 'tele'),
    HomeService(
        id: 1,
        name: AppStrings.hhcAppointments,
        description: AppStrings.hhcAppointments,
        icon: AppImages.iconNurse,
        code: 'N'),
    HomeService(
        id: 1,
        name: AppStrings.physiotherapistAppointments,
        description: AppStrings.physiotherapistAppointments,
        icon: AppImages.iconPhys,
        code: 'phy'),
    HomeService(
        id: 1,
        name: AppStrings.homeVisitAppointments,
        description: AppStrings.homeVisitAppointments,
        icon: AppImages.iconHVD,
        code: 'hvd'),
  ];

  static List<HomeService> labTypes = [
    HomeService(
        id: 1,
        name: AppStrings.radiology,
        description: AppStrings.radiology,
        icon: AppImages.iconXRay,
        code: 'R',
        next: ''
        //  next: AppRouteNames.radiologyPage

        ),
    HomeService(
        id: 1,
        name: AppStrings.laboratory,
        description: AppStrings.laboratory,
        icon: AppImages.iconLab,
        code: 'L',
        next: AppRouteNames.radiologyPage),
    // HomeService(
    //     id: 1,
    //     name: AppStrings.pcr,
    //     description: AppStrings.pcr,
    //     icon: AppImages.iconPcr,
    //     code: 'PCR',
    //     next: AppRouteNames.radiologyPage),
  ];



  static List<HomeService> ivTherapyTypes = [
    HomeService(
        id: 1,
        name: AppStrings.ivAntibiotic,
        description: AppStrings.ivAntibiotic,
        icon: AppImages.iconIV,
        code: 'IVFA',

      route: AppRouteNames.map,
      next: AppRouteNames.serviceDetails,

    ),
    HomeService(
        id: 2,
        name: AppStrings.ivVitamins,
        description: AppStrings.ivVitamins,
        icon: AppImages.iconIV,
        code: 'IV',

      route: AppRouteNames.map,
      next: AppRouteNames.nurseServices,
    ),
  ];
}
