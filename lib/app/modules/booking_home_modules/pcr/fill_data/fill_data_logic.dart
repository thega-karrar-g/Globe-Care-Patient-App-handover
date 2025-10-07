import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../base_controller/base_controller.dart';
import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../data/constants/booking_constants.dart';
import '../../../../data/eunums/enums.dart';
import '../../../../data/models/patient.dart';
import '../../../../routes/app_route_names.dart';

class FillDataLogic extends BaseController {
  final nameKey = 'name';
  final passportKey = 'passport';
  final ssnKey = 'ssn';

  List<Patient> patients = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    BookingConstants.paymentAppointmentType = PaymentAppointmentTypes.pcr;

    int count = Get.arguments as int;
    var forms = List<FormGroup>.generate(
        count,
        (i) => FormGroup({
              nameKey: FormControl<String>(
                validators: [
                  Validators.required,
                ],
              ),
              ssnKey: FormControl<String>(
                validators: [
                  Validators.required,
                ],
              ),
              passportKey: FormControl<String>(
                validators: [],
              ),
            }));
    patients = List<Patient>.generate(
        count, (i) => Patient(id: i + 1, form: forms[i]));
  }

  updatePatient(Patient p) {
    patients[patients.indexOf(p)].hasCertificate = !p.hasCertificate;
    update();
  }

  navToNext() {
    bool valid = true;
    for (var element in patients) {
      if (element.form.invalid) {
        valid = false;
        break;
      }

      if (element.hasCertificate && element.form.value[passportKey] == null) {
        valid = false;
        break;
      }
    }
    if (valid) {
      BookingConstants.showFiles = false;
      BookingConstants.patientFollowers = '';

      for (var el in patients) {
        var passport = el.hasCertificate
            ? ('-${el.form.value[passportKey]}')
            : '';
        var e = '${el.form.value[nameKey].toString().trim()}-${el.form.value[ssnKey]}$passport';
        BookingConstants.patientFollowers += e;

        if (el != patients.last) {
          BookingConstants.patientFollowers += ',';
        }
      }

      Get.toNamed(
        AppRouteNames.patientData,
      );
    } else {
      buildFailedSnackBar(msg: AppStrings.fillAllRequiredFields.tr);
    }
  }
}
