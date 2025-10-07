
import 'dart:math';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:globcare/app/data/constants/app_boxes_names.dart';
import 'package:globcare/app/modules/home_screen/home_screen_controller.dart';

import '../../base_controller/base_controller.dart';
import '../../data/models/notification_model.dart';
import '../../data/repositories/notifications_repository.dart';

class NotificationsLogic extends BaseController {


final  NotificationsRepository notificationsRepository=NotificationsRepository();
  List<NotificationModel> currentNotifications=[],allNotifications=[];

  bool isPrivateSelected=true;

GetStorage notificationBox=GetStorage();


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();



getNotificationList();

  }


  getNotificationList()async{

    setBusy(true);

 allNotifications=await   notificationsRepository.getNotificationList();
    BaseController.notificationCount=allNotifications.length;

 // notificationList.reversed.toList();
 allNotifications.sort((b,a)=>a.id.compareTo(b.id,),);

    setBusy(false);

   // var lastID= notificationBox.read(AppBoxesNames.notificationLastIDKey) ??0;

   int count=allNotifications.where((e)=> !e.read && e.type=='private' ).toList().length;

    Get.find<HomeScreenController>().updateNotificationCount(count);

    updateType(isPrivateSelected);
    // markAllRead();

  }


  markAllRead()async{

    if(currentNotifications.isNotEmpty){


      List<int> ids=currentNotifications.map((e)=>e.id).toList();
      int maxId=ids.reduce(max);
      // print(maxId);


        notificationBox.write(AppBoxesNames.notificationLastIDKey,maxId);
      Get.find<HomeScreenController>().updateNotificationCount(0);

      update();

    }








  }

  updateType(bool isPrivate){
    isPrivateSelected=isPrivate;

    // currentNotifications=allNotifications;
    String type= isPrivateSelected ? "private" :"public";
    // print(type);
    currentNotifications=allNotifications.where( (e)=>e.type== type).toList();
 update();
    // print(currentNotifications.length);
    // print(allNotifications.length);
  }

  readNotification(int id,int index)async{


   var result= await notificationsRepository.updateNotification({ 'patient_id':currentUser!.id, 'notification_id':id});

   logger.i(result);
   // getNotificationList();
currentNotifications[index].read=true;
update();
  }

}
