import 'package:expandable/expandable.dart';
import 'package:get/get.dart';
import '../../../base_controller/base_controller.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../data/constants/booking_constants.dart';
import '../../../data/eunums/enums.dart';
import '../../../data/models/dept.dart';
import '../../../data/models/nurse_service.dart';
import '../../../data/repositories/service_repository.dart';
import '../../../routes/app_route_names.dart';
import '../patient_data/patient_data_logic.dart';

class PhysiotherapistLogic extends BaseController {
  List<NurseService> selectedItems = [];
  List<Dept> depts = [
    Dept(
        id: 1,
        name: 'العظام و العضلات',
        description:
            'خشونة مفصل الركبة- تبديل مفصل الركبة - آلام أسفل الظهر - مشاكل الكتف - الكسور - الحوادث وغيرها '),
    Dept(
        id: 2,
        name: 'الأعصاب ',
        description:
            'الجلطة (السكتة) الدماغية - التصلب اللويحي -  العصب السابع وغيرها'),
    Dept(
        id: 3,
        name: ' المسنين',
        description:
            'التهاب المفاصل - فقدان التوازن - اضطراب المشي  -قلة الحركة أو انعدامها - ضمور العضلات '),
    Dept(
        id: 4,
        name: ' الأطفال',
        description: 'تأخر النمو - الشلل الدماغي - متلازمة داون وغيرها'),
    Dept(
        id: 5,
        name: ' صحة المرأة',
        description:
            'إعادة تأهيل عضلات قاع الحوض - تصحيح قوام الجسم - تمارين عضلة البطن - نصائح حول التمارين الآمنة التي يمكن ممارستها أثناء الحمل - التثقيف الصحي وغيرها'),
  ];
  List<ExpandableController> controllers = [
    ExpandableController(),
    ExpandableController(),
    ExpandableController(),
    ExpandableController(),
    ExpandableController(),
  ];

  Dept? selectedDept;
  NurseService? selectedSession;

  int gender = 0, index = 0;

  final List<NurseService> sessions = [
    NurseService(id: 1, name: 'جلسة علاج طبيعي', price: '50'),
    NurseService(id: 1, name: '3 جلسات علاج طبيعي', price: '100'),
    NurseService(id: 1, name: '6 جلسات علاج طبيعي', price: '150'),
    NurseService(id: 1, name: '9 جلسات علاج طبيعي', price: '200'),
    NurseService(id: 1, name: '12 جلسة علاج طبيعي ', price: '250'),
  ];

  // String route = '';

  updateSessions(NurseService item) {
    if (item == selectedSession) {
      selectedSession = null;
    } else {
      selectedSession = item;
    }

    //selectedItems=items;
    update();
  }

  navToTimeSlots() {
    if (selectedItems.isNotEmpty) {
      PatientDataLogic.chooseDateType = ChooseDateType.other;

      BookingConstants.serviceCode = '';
      BookingConstants.serviceId = selectedItems[0].id;
      BookingConstants.service = selectedItems[0];
      BookingConstants.doctor.name = '';
      BookingConstants.doctor.nameAr = '';
      BookingConstants.paymentAppointmentType = PaymentAppointmentTypes.phy;

      Get.toNamed(AppRouteNames.patientData,);


    }
    else {
      buildFailedSnackBar(msg: AppStrings.selectMsg.tr);
    }
  }

  updateGender(int g) {
    gender = g;
    update();
  }

  updateIndex(int i) {
    index = i;
    update();
  }

  updateDept(Dept dept, {int index = 0}) {
    for (var element in controllers) {
      element.value = false;
    }

    if (dept == selectedDept) {
      selectedDept = null;
      controllers[index].value = false;
    } else {
      selectedDept = dept;
      controllers[index].value = true;
    }

    update();
  }

  final ServiceRepository _serviceRepository = ServiceRepository();

  List<NurseService> items = [];

  updateItems(NurseService item) {
    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
    } else {
      selectedItems.clear();

      if (selectedItems.isEmpty) {
        selectedItems.add(item);
        BookingConstants.price = double.parse(item.price);
        BookingConstants.doctorGender = gender == 0 ? 'Male' : 'Female';
        BookingConstants.appointmentType = 'phy';
        BookingConstants.doctorName = '';

        if (Get.locale.toString() == 'ar') {
          BookingConstants.serviceName = item.nameAr;
        } else {
          BookingConstants.serviceName = item.name;
        }
      }
    }

    update();
  }

  checkItem(NurseService item) {
    return selectedItems.contains(item);
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    BookingConstants.isPcr = false;
    BookingConstants.reset();
    BookingConstants.discountCategory = 'physiotherapy';

    setBusy(true);
    var data = await _serviceRepository.getServicesList(serviceType: 'PHY');

    items.addAll(data.where((element) => element.type == 'PHY'));



    setBusy(false);
    update();
  }
}
