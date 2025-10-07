import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_colors.dart';
import '../../../data/models/user_model.dart';
import '../../../global_widgets/shared/dynamic_list.dart';
import '../../../global_widgets/shared/loading.dart';
import '../../../global_widgets/shared/my_appbar.dart';
import '../../../global_widgets/shared/no_data.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../global_widgets/ui.dart';
import '../../../core/assets_helper/app_anim.dart';
import 'members_logic.dart';
import 'widgets/member_item.dart';
import 'widgets/reactive_add_member_form.dart';

class MembersPage extends StatelessWidget {
  final logic = Get.put(MembersLogic());

   MembersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(
        child: Column(
      children: [
        myAppBar2(title: AppStrings.myMembers),
        Expanded(child: GetBuilder<MembersLogic>(builder: (logic) {
          return logic.busy
              ? MyLoadingWidget()
              : logic.members.isNotEmpty
                  ? DynamicListView(
                      data: logic.members,
                      itemBuilder: (item) =>
                          MemberItem(member: item as AppUser))
                  : NoDataFound(
                      animation: AppAnim.noMembers,
                      msg: AppStrings.noAvailableMembers,
                    );
        })),
        UiHelper.verticalSpaceMedium,
        Row(
          children: [
            Spacer(),
            GestureDetector(
              onTap: () {
                Get.bottomSheet(
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: AddMemberForm(),
                        ),
                        isScrollControlled: true,
                        backgroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))))
                    .then((value) {
                  logic.fetch();
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primaryColor),
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.add_circle,
                  color: AppColors.white,
                  size: 30,
                ),
              ),
            ),
            Spacer(),
          ],
        ),
        UiHelper.verticalSpaceMassive,
      ],
    ));
  }
}
