import 'package:get/get.dart';

import '../../../../base_controller/base_controller.dart';
import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../data/models/pcr_model.dart';
import '../../../../data/repositories/service_repository.dart';
import '../../../../routes/app_route_names.dart';

class PCRServicesLogic extends BaseController {
  final ServiceRepository _serviceRepository = ServiceRepository();

  late PcrModel? selectedItem;

  final List<PcrModel> items = [];

  updateItemsAdd(PcrModel item) {
    if (item.quantity < 10) {
      items[items.indexOf(item)].quantity++;
    }
    update();
  }

  updateItemsSub(PcrModel item) {
    if (item.quantity > 1) {
      items[items.indexOf(item)].quantity--;
    }
    update();
  }

  navToTimeSlots() {
    if (selectedItem != null) {
      Get.toNamed(AppRouteNames.bookingPeriod);
    } else {
      buildFailedSnackBar(msg: AppStrings.selectMsg.tr);
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    setBusy(true);

    var data = await _serviceRepository.getPCRServicesList();

    print(data.length);
    items.addAll(data.where((element) => element.type == 'PCR'));

    setBusy(false);
    update();
  }
}
