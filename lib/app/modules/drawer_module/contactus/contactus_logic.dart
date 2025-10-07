import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../base_controller/base_controller.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../data/api/appointment_api.dart';
import '../../../global_widgets/shared/different_dialogs.dart';
import '../../../utils/launcher.dart';

class ContactusLogic extends BaseController {
  final AppointmentApi _appointmentApi = AppointmentApi();
  final emailKey = 'email';
  final phoneKey = 'mobile';
  final commentKey = 'message';

  late FormGroup form;

  openTwitter() {
    Launcher.openTwitter();
  }

  openInstagram() {
    Launcher.openInstagram();
  }

  openFacebook() {
    Launcher.openFacebook();
  }

  openWhatsapp() {
    Launcher.openWhatsApp(AppStrings.whatsappNo);
  }

  openEmail() {
    Launcher.openEmail(AppStrings.emailAddress);
  }

  openCall() {
    Launcher.phoneCall(AppStrings.contactUsNo);
  }

  void send() async {
    Map<String, dynamic> data = {};

    if (form.valid) {
      data.addAll(form.value);

      if (!noInternetConnection()) {
        DifferentDialog.showProgressDialog(isDismissible: false);

        _appointmentApi.contactUs(data).then((value) async {
          try {
            var respo = value!.data;

            Get.back();
            if (respo['success'] == 1) {
              buildSuccessSnackBar(msg: respo['data']['message']);

              form.reset();

              //   await DifferentDialog.hideProgressDialog();
              //  DifferentDialog.showRegisterSuccessDialog2();

              // Get.toNamed(AppRouteNames.successRegister);

            } else {
              buildFailedSnackBar(msg: respo['message']);
            }
          } catch (_) {}
        });
      } else {
        buildFailedSnackBar(msg: AppStrings.checkInternet.tr);
      }
    } else {
      buildFailedSnackBar(msg: AppStrings.fillAllFields.tr);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    form = FormGroup({
      emailKey: FormControl<String>(validators: [Validators.required]),
      commentKey: FormControl<String>(validators: [Validators.required]),
      phoneKey: FormControl<String>(validators: [Validators.required]),
    });
  }
}
