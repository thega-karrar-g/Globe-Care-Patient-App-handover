import '../../../base_controller/base_controller.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/profile_repository.dart';

class MembersLogic extends BaseController {
  final ProfileRepository _profileRepository = ProfileRepository();

  List<AppUser> members = [];

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    fetch();
  }

  fetch() async {
    setBusy(true);
    members = await _profileRepository.getMemberList();
    setBusy(false);
    // var mf= Get.find<SelectPatientLogic>();
    //
    // mf.onInit();
  }
}
