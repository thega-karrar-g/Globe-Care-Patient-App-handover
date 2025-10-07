import 'package:get/get.dart';

import '../../services/session_service.dart';
import '../models/user_model.dart';

class AppUrls {
  static AppUser? get current {
    return Get.find<SessionService>().currentUser;
  }

//http://20.86.58.235/
  static const String sendSms = 'https://www.msegat.com/gw/sendsms.php';
  static const String sendSmsTest =
      'https://private-anon-144fa22d4b-msegat.apiary-proxy.com/gw/sendsms.php';

  static const String googlePlayUrl = 'market://details?id=com.globcare.app';
  static const String appleStoreUrl =
      'https://apps.apple.com/app/%D8%AC%D9%84%D9%88%D8%A8-%D9%83%D9%8A%D8%B1-globcare-%D8%B5%D8%AD%D8%AA%D9%83-%D8%AA%D9%87%D9%85%D9%86%D8%A7/id1613719569';

  static const String baseUrlTest = 'http://20.216.57.38:8069/sehati/';
  static const String baseUrlProduction = 'https://his.glob-care.com/sehati/';

  static const String baseUrl = baseUrlTest;

  // static const String baseUrl = 'https://his.glob-care.com/sehati/';

  ///////////////  app  config   ////
  static const String updateFcmToken = 'instant/update-fcm-token';

  static const String appVersion = 'app/update-and-ios';

  ///////////////     ////

  static const String login = 'request/token';
  static const String loginPatient = 'patient/login';
  static const String forgetPassword = 'patient/forgot-password';
  static const String registerPatient = 'patient/registration';
  static const String registerVerifyCode = 'patient/check-register-code';
  static const String forgotPasswordVerifyCode = 'patient/check-forget-code';

  static const String resetPassword = 'patient/reset-password';

  static const String registerPatientGuest = 'patient/guest-signup';
  static const String changePassword = 'change-password';
  static const String userDetails = 'get-user-details/1/';
  static const String updateProfilePhoto = 'update-profile-photo/1/';
  static const String doctors = 'get-doctor-list';
  // static const String doctorsTeleMed = 'get-doctor-list';
  static const String doctorSchedule = 'get-doctor-schedule/';
  static const String teleAppointments = 'get-appointment/1/';
  static const String hhcAppointments = 'get-hhc-appointment/1/';
  static const String hvdAppointments = 'get-hvd-appointment/1/';
  static const String pcrAppointments = 'get-pcr-appointment/1/';
  static const String pcrAppointmentCount = 'get-pcr-appointment/1/';
  static const String appointmentsCount = 'appointment/count-all/';
  static const String appointmentCheckDiscount = 'appointment/check-discount';
  static const String requestSleepMedicine = 'create-sleep-medicine-request';
  // static const String requestCaregiver = 'service-request/create-caregiver';
  static const String requestCaregiver = 'create-caregiver-contract';
  static const String contactUs = 'contact-us';
  static const String physiotherapyAppointments =
      'get-physiotherapy-appointment/1/';
  static const String services = 'get-service-list';
  static const String insurance = 'get-insurance-list';
  static const String requestedPayment = 'get-requested-payments/';
  static const String paymentChecker = 'service-request/payment-checker';

  static const String homeVisitFee = 'appointment/get-home-visit-fee';
  static const String pharmacyPrice = 'pharmacy/get-price';

  static const String periodsHHC = 'get-hhc-period-list';
  static const String periodsPCR = 'get-pcr-period-list';
  static const String periodsPhysiotherapy = 'get-physiotherapy-period-list';

  static const String todayAppointment = 'today-appointment';
  static const String labTests = 'get-labtest-info';
  static const String prescriptions = 'get-prescription-info';

  static const String prescriptionUrls = 'prescription/get-url/';
  static const String medicalReportUrls = 'report/get-url/';
  static const String labTestsUrls = 'lab-tests/get-url/';
  static const String labRequestsUrls = 'lab-request/get-url/';
  static const String imageTestsUrls = 'image-tests/get-url/';
  static const String imageRequestUrls = 'image-request/get-url/';
  static const String imageTestsRequestsUrls = 'image-test-request/get-url/';
  static const String labTestsRequestsUrls = 'lab-test-request/get-url/';

  static const String registration = 'patient/registration';
  static const String addMember = 'patient/child-registration';
  static const String getMembers = 'get-children-details/';

  static const String editProfile = 'update-patient/';

  //static const String createAppointment = 'create-appointment';
  static const String createHHCAppointment = 'appointment/create-hhc';
  static const String createAppointment = 'appointment/create';
  static const String createAppointmentPhysiotherapy =
      'appointment/create-physiotherapy';
  static const String createAppointmentHVD = 'appointment/create-hvd';
  static const String createAppointmentTele = 'appointment/create-tele';
  static const String createAppointmentPcr = 'appointment/create-pcr';
  static const String setPaymentStatus = 'appointment/set-payment-status';
  static const String setPaymentStatusInstantCons =
      'pharmacy/set-payment-status';
  static const String createInstantCon =
      'pharmacy/patient/instant-consultation/create';
  static const String checkDiscountCode = 'check-pharmacy-discount-status';
  static const String rateInstantCon = 'instant/update-evaluation';
  static const String requestCancelAppointment =
      'appointment/request-cancellation-appointment';

  static const String getInstantConsultation =
      'patient/get-instant-consultation/';

  static const String paymentRequest =
      'https://payments-dev.urway-tech.com/URWAYPGService/transaction/jsonProcess/JSONrequest';

  ///..

  static String get familyMemberList {
    return 'patient/${current?.id}/family-members-list';
  }

  static String get addNewFamilyMember {
    return 'patient/${current?.id}/family-member';
  }

  static String getUrl(String url,
      {bool withExtension = true, onlyId = false}) {
    var extension = '';

    if (!onlyId) {
      extension =
          (current != null) ? '/${current!.userType}/${current!.id}' : '';
    } else {
      extension = (current != null) ? '/${current!.id}' : '';
    }

    return withExtension ? (url + extension) : url;
  }

  //////  caregiver urls

  static const String getRecordFile = 'caregiver/get-patient-details/';
  static const String getVitalSigns = 'caregiver/get-vital-signs/';
  static const String getObservationList = 'caregiver/get-observation/';
  static const String getPainPresent = 'caregiver/get-pain-present/';
  static const String getPrescribedMedicine = 'caregiver/get-patient-medicine/';
  static const String getPrescribedMedicineTimes =
      'caregiver/get-medicine-times';
  static const String addVital = 'caregiver/add-vital-signs';
  static const String addObservation = 'caregiver/observation';
  static const String addPain = 'caregiver/add-pain-present';
  static const String updateMedicineState = 'caregiver/update-medicine-state';
  static const String getMedicineSlots = 'caregiver/get-medicine-slots/';

  static const String getNotificationList = 'get-notifications/';
  static const String updateNotification = 'update-notification';
  static const String sliders = 'sliders';

  static const String sleepMedicineRequestAddQuestioner =
      'sleep-medicine-request/add-questioner';
  static const String sleepMedicineRequestList =
      'get-sleep-medicine-request-list/';

  static const String caregiverContractRequestList =
      'get-caregiver-contracts-list/';
  static const String caregiverContractRequestAddQuestioner =
      'caregiver-contracts/add-questioner';
  static const String updateCaregiverContract = 'update-caregiver-contracts';

  static const String refundRequestList = 'get-cancellation-refund-list/';
  static const String privacyPolicy = 'https://glob-care.com/privacy-policy';
}
