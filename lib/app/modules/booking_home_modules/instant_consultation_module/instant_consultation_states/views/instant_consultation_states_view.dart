import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/language_and_localization/app_strings.dart';
import '../../../../../data/eunums/enums.dart';
import '../../../../../global_widgets/shared/loading.dart';
import '../../../../../global_widgets/shared/my_appbar.dart';
import '../../../../../global_widgets/shared/no_data.dart';
import '../../../../../global_widgets/ui.dart';
import '../../../../../core/assets_helper/app_anim.dart';
import '../instant_consultation_states_logic.dart';import '../widgets/rating_item.dart';
import '../widgets/request_accepted.dart';
import '../widgets/send_request.dart';
import '../widgets/send_request_again.dart';
import '../widgets/start_meeting.dart';
import '../widgets/timer_item.dart';

class InstantConsultationStatesPage extends StatefulWidget {
  const InstantConsultationStatesPage({super.key});

  @override
  State<InstantConsultationStatesPage> createState() =>
      _InstantConsultationStatesPageState();
}

class _InstantConsultationStatesPageState
    extends State<InstantConsultationStatesPage> {

  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(
        child: GetBuilder<InstantConsultationStatesLogic>(builder: (logic) {
      return Column(
        children: [
          myAppBar2(title: AppStrings.instantConsultation),

          // Ui.primaryButton(title: 'send notification',onTab: (){
          //
          //   logic.sendTestNotification();
          //
          // }),

          if (logic.noInternetConnection())
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  NoDataFound(
                    animation: AppAnim.noInternet,
                    msg: AppStrings.checkInternet,
                  ),

                  // Ui.primaryButton(title: AppStrings.tryAgain.tr,onTab: (){
                  //   logic.onInit();
                  // })
                ],
              ),
            )
          else
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [



                    if (InstantConsultationStatesLogic
                            .instantConsultationStatus ==
                        InstantConsultationStatus.load)
                      MyLoadingWidget()
                    else if (InstantConsultationStatesLogic
                            .instantConsultationStatus ==
                        InstantConsultationStatus.send)
                      SendRequest()
                    else if (InstantConsultationStatesLogic
                            .instantConsultationStatus ==
                        InstantConsultationStatus.rating)
                      RatingItem()
                    else if (InstantConsultationStatesLogic
                            .instantConsultationStatus ==
                        InstantConsultationStatus.timer)
                      TimerItem()
                    else if (InstantConsultationStatesLogic
                            .instantConsultationStatus ==
                        InstantConsultationStatus.approved)
                      RequestAcceptedItem()
                    else if (InstantConsultationStatesLogic
                            .instantConsultationStatus ==
                        InstantConsultationStatus.startMeeting)
                      StartMeetingItem()
                    else if (InstantConsultationStatesLogic
                            .instantConsultationStatus ==
                        InstantConsultationStatus.resend)
                      SendRequestAgain()
                  ],
                ),
              ),
            )
        ],
      );
    }));
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
