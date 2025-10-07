import '../api/auth_api.dart';
import '../models/user_model.dart';

class ProfileRepository {
  static final _profileRepository = ProfileRepository._internal();

  factory ProfileRepository() {
    return _profileRepository;
  }

  ProfileRepository._internal();

  final AuthApi _authApi = AuthApi();

  Future<List<AppUser>> getMemberList() async {
    try {
      var response = await _authApi.getMembers();
      var d = response!.data['data'] as List;
      var dd = d.map((dr) {
        // print(dr);

        return AppUser.fromMap((dr));
      }).toList();

      return dd;
    } catch (_) {
      return [];
    }
  }
}
