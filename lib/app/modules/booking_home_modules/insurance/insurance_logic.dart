import '../../../base_controller/base_controller.dart';
import '../../../data/models/insurance.dart';
import '../../../data/repositories/payment_repository.dart';
import '../appointment_base_controllers/booking_base_controller.dart';

class InsuranceLogic extends BaseController {
  Insurance? selectedCompany;

  final PaymentRepository _insuranceRepository = PaymentRepository();

  List<Insurance> items = [];

  updateCompany(Insurance selected) {
    selectedCompany = selected;
    update();
  }

  bool isLoad = false;

  isLoading(bool load) {
    isLoad = load;
    update();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    setBusy(true);
    items = await _insuranceRepository.getInsuranceList();
    setBusy(false);
  }

  makeBookingWithFileDio() async {
    final BookingBaseController appointmentBaseController =
        BookingBaseController();

    appointmentBaseController.createAppointment();
  }
}
