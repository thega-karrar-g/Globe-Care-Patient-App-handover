import 'package:get/get.dart';

import '../modules/appointment/appointment_member_types_view.dart';
import '../modules/appointment/appointment_types_view.dart';
import '../modules/appointment/appointment_view.dart';
import '../modules/appointment_requests_module/caregiver_contract_questionnaire/caregiver_contract_questionnaire_view.dart';
import '../modules/appointment_requests_module/caregiver_contract_requests/caregiver_contract_requests_page.dart';
import '../modules/appointment_requests_module/refund_cancel_request/refund_cancel_request_page.dart';
import '../modules/appointment_requests_module/sleep_medicine_requests/sleep_medicine_requests_page.dart';
import '../modules/appointment_requests_module/sleep_questionnaire/sleep_questionnaire_view.dart';
import '../modules/auth/verify_code/verify_code_view.dart';
import '../modules/auth/views/change_password_view.dart';
import '../modules/auth/views/forget_password_view.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/auth/views/register_view.dart';
import '../modules/booking_home_modules/book_invoice/book_invoice_view.dart';
import '../modules/booking_home_modules/home_visit/home_visit_view.dart';
import '../modules/booking_home_modules/instant_consultation_module/instant_consultation_home/instant_consultation_home_view.dart';
import '../modules/booking_home_modules/instant_consultation_module/instant_consultation_states/views/instant_consultation_states_view.dart';
import '../modules/booking_home_modules/insurance/insurance_view.dart';
import '../modules/booking_home_modules/iv_therapy/therapy_types/iv_therapy_types_view.dart';
import '../modules/booking_home_modules/location/location_view.dart';
import '../modules/booking_home_modules/meeting/meeting_view.dart';
import '../modules/booking_home_modules/nurse_services/nurse_services_view.dart';
import '../modules/booking_home_modules/patient_data/patient_data_view.dart';
import '../modules/booking_home_modules/pcr/choose_date/choose_date_view.dart';
import '../modules/booking_home_modules/pcr/fill_data/fill_data_view.dart';
import '../modules/booking_home_modules/pcr/pcr_services/pcr_services_view.dart';
import '../modules/booking_home_modules/physiotherapist/physiotherapist_view.dart';
import '../modules/booking_home_modules/radiology_lab/radiology_lab_services/radiology_lab_services_view.dart';
import '../modules/booking_home_modules/radiology_lab/radiology_lab_types/radiology_lab_types_view.dart';
import '../modules/booking_home_modules/receipt_payment/receipt_payment_page.dart';
import '../modules/booking_home_modules/service_details/service_details_view.dart';
import '../modules/booking_home_modules/vaccination/vaccination_view.dart';
import '../modules/caregive_module/caregiver_home/caregiver_home_view.dart';
import '../modules/caregive_module/observation/observation_view.dart';
import '../modules/caregive_module/pain_present/pain_present_view.dart';
import '../modules/caregive_module/prescribed_medicine/prescribed_medicine_view.dart';
import '../modules/caregive_module/prescribed_medicine_times/prescribed_medicine_time_view.dart';
import '../modules/caregive_module/vital_signs/vital_signs_view.dart';
import '../modules/doctor_module/doctor_schedule/doctor_schedule_view.dart';
import '../modules/doctor_module/doctors/views/doctors_view.dart';
import '../modules/drawer_module/aboutus/about_view.dart';
import '../modules/drawer_module/contactus/contactus_view.dart';
import '../modules/drawer_module/faq/faq_view.dart';
import '../modules/drawer_module/our_services/our_services_view.dart';
import '../modules/drawer_module/patient_responsibilities/responsibility_view.dart';
import '../modules/drawer_module/privacy_policy/privacy_policy_view.dart';
import '../modules/drawer_module/settings/views/language_view.dart';
import '../modules/drawer_module/settings/views/theme_mode_view.dart';
import '../modules/drawer_module/terms_of_services/terms_of_services_view.dart';
import '../modules/files/files_view.dart';
import '../modules/home_screen/home_screen_view.dart';
import '../modules/home_tabs/home_binding.dart';
import '../modules/home_tabs/home_tabs_view.dart';
import '../modules/medical_file_module/medical_file/medical_file_binding.dart';
import '../modules/medical_file_module/medical_file/medical_file_view.dart';
import '../modules/medical_file_module/member_medical_file/member_medical_file_view.dart';
import '../modules/my_profile_module/members/members_view.dart';
import '../modules/my_profile_module/my_invoice/my_invoice_view.dart';
import '../modules/my_profile_module/my_profile/edit_profile_view.dart';
import '../modules/my_profile_module/my_profile/my_profile_view.dart';
import '../modules/my_profile_module/requested_payment/requested_payment_details_view.dart';
import '../modules/my_profile_module/requested_payment/requested_payment_view.dart';
import '../modules/notifications/notifications_binding.dart';
import '../modules/notifications/notifications_view.dart';
import '../modules/pdf_page/pdf_page_view.dart';
import 'app_route_names.dart';

class AppRoutes {
  static const transition = Transition.leftToRightWithFade;
  static const duration = Duration(milliseconds: 500);
  static const durationHome = Duration(milliseconds: 500);
  static final List<GetPage> allRoutes = [
  GetPage(
  name: AppRouteNames.intro,
  page: () => OurServices(),
  transitionDuration: duration,
  transition: transition),

    GetPage(
        name: AppRouteNames.home,
        page: () => HomeScreenView(),
        transitionDuration: duration,
        transition: transition),
    GetPage(
        name: AppRouteNames.login,
        page: () => LoginPage(),
        transitionDuration: duration,
        transition: transition),
    GetPage(
      name: AppRouteNames.homeTabs,
      binding: HomeBinding(),
      page: () => HomeTabsView(),
    ),
    GetPage(
        name: AppRouteNames.doctors,
        page: () => DoctorsPage(),
        transitionDuration: duration,
        transition: transition),
    GetPage(
        name: AppRouteNames.homeAppointment,
        page: () => AppointmentPage(),
        transition: Transition.leftToRight,
        transitionDuration: durationHome),
    GetPage(
        name: AppRouteNames.homeBookNow,
        page: () => HomeScreenView(),
        transition: Transition.leftToRight,
        transitionDuration: durationHome),
    GetPage(
        name: AppRouteNames.homeMedicalFile,
        page: () => MedicalFilePage(),
        transition: Transition.leftToRight,
        transitionDuration: durationHome),
    GetPage(
        name: AppRouteNames.homeProfile,
        page: () => MyProfilePage(),
        transition: Transition.leftToRight,
        transitionDuration: durationHome),

    GetPage(
        name: AppRouteNames.insurance,
        page: () => InsurancePage(),
        transitionDuration: duration,
        transition: transition),

    GetPage(
        name: AppRouteNames.themeMode,
        page: () => ThemeModeView(),
        transitionDuration: duration,
        transition: transition),
    GetPage(
        name: AppRouteNames.language,
        page: () => LanguageView(),
        transitionDuration: duration,
        transition: transition),
    // GetPage(name: AppRouteNames.emergncy, page: () => EmergencyPage(),),
    GetPage(
        name: AppRouteNames.register,
        page: () => RegisterPage(),
        transitionDuration: duration,
        transition: transition),
    GetPage(
        name: AppRouteNames.verify,
        page: () => VerifyCodePage(),
        transitionDuration: duration,
        transition: transition),
    GetPage(
        name: AppRouteNames.forgetPassword,
        page: () => ForgetPasswordPage(),
        transitionDuration: duration,
        transition: transition),

    ////////////
    GetPage(
        name: AppRouteNames.map,
        //page: () => LocationTestPage(),
        page: () => LocationPage(),
        transitionDuration: duration,
        transition: transition),
    GetPage(
        name: AppRouteNames.nurseServices,
        page: () => NurseServicesPage(),
        transitionDuration: duration,
        transition: transition),
    GetPage(
        name: AppRouteNames.vaccination,
        page: () => VaccinationPage(),
        transitionDuration: duration,
        transition: transition),
    GetPage(
        name: AppRouteNames.physiotherapistServices,
        page: () => PhysiotherapistPage(),
        transitionDuration: duration,
        transition: transition),

    GetPage(
        name: AppRouteNames.editPassword,
        page: () => ChangePasswordPage(),
        transition: transition,
        transitionDuration: duration),

    GetPage(
        name: AppRouteNames.patientData,
        page: () => PatientDataPage(),
        transition: transition,
        transitionDuration: duration),

    GetPage(
        name: AppRouteNames.notifications,
        page: () => NotificationsPage(),
        binding: NotificationsBinding(),
        transition: transition,
        transitionDuration: duration),
    GetPage(
        name: AppRouteNames.medicalFile,
        page: () => MedicalFilePage(),
        binding: MedicalFileBinding(),
        transition: transition,
        transitionDuration: duration),
    GetPage(
        name: AppRouteNames.editProfile,
        page: () => EditProfilePage(),
        transition: transition,
        transitionDuration: duration),

    GetPage(
        name: AppRouteNames.termsOfService,
        page: () => TermsOfServicesPage(),
        transition: transition,
        transitionDuration: duration),
    GetPage(
        name: AppRouteNames.pcrService,
        page: () => PCRServicesPage(),
        transition: transition,
        transitionDuration: duration),

    GetPage(
        name: AppRouteNames.chooseDate,
        page: () => ChoosePCRDatePage(),
        transition: transition,
        transitionDuration: duration),
    // GetPage(
    //     name: AppRouteNames.chooseDatePeriod,
    //     page: () => ChooseDatePeriodPage(),
    //     transition: transition,
    //     transitionDuration: duration
    // ),

    GetPage(
        name: AppRouteNames.fillData,
        page: () => FillDataPage(),
        transition: transition,
        transitionDuration: duration),
    GetPage(
        name: AppRouteNames.serviceDetails,
        page: () => ServiceDetailsPage(),
        transition: transition,
        transitionDuration: duration),
    GetPage(
        name: AppRouteNames.homeVisit,
        page: () => HomeVisitPage(),
        transition: transition,
        transitionDuration: duration),

    GetPage(
        name: AppRouteNames.contactUs,
        page: () => ContactusPage(),
        transition: transition,
        transitionDuration: duration),

    GetPage(
        name: AppRouteNames.aboutUs,
        page: () => AboutPage(),
        transition: transition,
        transitionDuration: duration),
    GetPage(
        name: AppRouteNames.patientResponsibilities,
        page: () => ResponsibilityPage(),
        transition: transition,
        transitionDuration: duration),
    GetPage(
        name: AppRouteNames.privacyPolicy,
        page: () => PrivacyPolicyPage(),
        transition: transition,
        transitionDuration: duration),
    GetPage(
        name: AppRouteNames.faq,
        page: () => FAQPage(),
        transition: transition,
        transitionDuration: duration),
    GetPage(
        name: AppRouteNames.doctorSchedule,
        page: () => DoctorSchedulePage(),
        transition: transition,
        transitionDuration: duration),
    GetPage(
        name: AppRouteNames.invoicePage,
        page: () => BookInvoicePage(),
        transition: transition,
        transitionDuration: duration),
    GetPage(
        name: AppRouteNames.meetingPage,
        page: () => MeetingPage(),
        transition: transition,
        transitionDuration: duration),
    GetPage(
        name: AppRouteNames.radiologyPage,
        page: () => RadiologyLabServicesPage(),
        transition: transition,
        transitionDuration: duration),
    GetPage(
        name: AppRouteNames.labRadiologyTypesPage,
        page: () => RadiologyLabTypesPage(),
        transition: transition,
        transitionDuration: duration),
    GetPage(
        name: AppRouteNames.sleepQuestionnaire,
        page: () => SleepQuestionnairePage(),
        transition: transition,
        transitionDuration: duration),
    GetPage(
        name: AppRouteNames.receiptPage,
        page: () => ReceiptPaymentPage(),
        transition: transition,
        transitionDuration: duration),
    GetPage(
        name: AppRouteNames.radiologyLabFiles,
        page: () => FilesPage(),
        transition: transition,
        transitionDuration: duration),
    GetPage(
        name: AppRouteNames.instantConsultation,
        page: () => InstantConsultationStatesPage(),
        transition: transition,
        transitionDuration: duration),
    GetPage(
        name: AppRouteNames.requestedPayment,
        page: () => RequestedPaymentPage(),
        transition: transition,
        transitionDuration: duration),
    GetPage(
        name: AppRouteNames.requestedPaymentDetails,
        page: () => RequestedPaymentDetailsPage(),
        transition: transition,
        transitionDuration: duration),
    GetPage(
        name: AppRouteNames.member,
        page: () => MembersPage(),
        transition: transition,
        transitionDuration: duration),

    GetPage(
        name: AppRouteNames.appointmentTypes,
        page: () => AppointmentTypesPage(),
        transition: transition,
        transitionDuration: duration),
    GetPage(
        name: AppRouteNames.appointmentMemberTypes,
        page: () => AppointmentMemberTypesPage(),
        transition: transition,
        transitionDuration: duration),
    GetPage(
        name: MemberMedicalFilePage.routeName,
        page: () => MemberMedicalFilePage(),
        transition: transition,
        transitionDuration: duration),
    GetPage(
      name: InstantConsultationHomePage.routeName,
      page: () => InstantConsultationHomePage(),
      transition: transition,
      transitionDuration: duration,
    ),
    GetPage(
      name: PdfPage.routeName,
      page: () => PdfPage(),
      transition: transition,
      transitionDuration: duration,
    ),
    GetPage(
      name: IVTherapyTypesPage.routeName,
      page: () => IVTherapyTypesPage(),
      transition: transition,
      transitionDuration: duration,
    ),
    GetPage(
      name: CaregiverHomePage.routeName,
      page: () => CaregiverHomePage(),
      transition: transition,
      transitionDuration: duration,
    ),


    GetPage(
      name: PrescribedMedicinePage.routeName,
      page: () => PrescribedMedicinePage(),
      transition: transition,
      transitionDuration: duration,
    ),

    GetPage(
      name: VitalSignsPage.routeName,
      page: () => VitalSignsPage(),
      transition: transition,
      transitionDuration: duration,
    ),
    GetPage(
      name: PainPresentPage.routeName,
      page: () => PainPresentPage(),
      transition: transition,
      transitionDuration: duration,
    ),
    GetPage(
      name: ObservationPage.routeName,
      page: () => ObservationPage(),
      transition: transition,
      transitionDuration: duration,
    ),



    GetPage(
      name: PrescribedMedicineTimePage.routeName,
      page: () => PrescribedMedicineTimePage(),
      transition: transition,
      transitionDuration: duration,
    ),




    GetPage(
      name: SleepMedicineRequestsPage.routeName,
      page: () => SleepMedicineRequestsPage(),
      transition: transition,
      transitionDuration: duration,
    ),
    GetPage(
      name: CaregiverContractRequestsPage.routeName,
      page: () => CaregiverContractRequestsPage(),
      transition: transition,
      transitionDuration: duration,
    ),
    GetPage(
      name: CaregiverContractQuestionnairePage.routeName,
      page: () => CaregiverContractQuestionnairePage(),
      transition: transition,
      transitionDuration: duration,
    ),
    GetPage(
      name: RefundCancelRequestPage.routeName,
      page: () => RefundCancelRequestPage(),
      transition: transition,
      transitionDuration: duration,
    ),

    GetPage(
      name: MyInvoicePage.routeName,
      page: () => MyInvoicePage(),
      transition: transition,
      transitionDuration: duration,
    ),


  ];
}
