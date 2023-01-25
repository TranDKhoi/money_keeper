import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/core/utils/push_service.dart';
import 'package:money_keeper/app/core/utils/utils.dart';

import '../../../data/models/notify.dart';
import '../../../data/services/notify_service.dart';
import '../../../data/services/socket_service.dart';

class NotificationController extends GetxController {
  var listNotify = <Notify>[].obs;

  final String _notiMethodChannel = "Notification";

  NotificationController() {
    SocketService.ins.initializeSocket();
    listenToNotiHub();
  }

  void listenToNotiHub() {
    SocketService.ins.onListenMethod(
        methodName: _notiMethodChannel,
        callBack: (notifyItem) {
          //listNotify.add(Notify.fromJson(notifyItem[0]));
          PushService.ins.showNotification(title: "title ne", body: "Body ne");
        });
  }

  void getAllNotify() async {
    EasyLoading.show();
    var res = await NotifyService.ins.getAllNotify();
    EasyLoading.dismiss();

    if (res.isOk) {
      listNotify.clear();
      for (int i = 0; i < res.data.length; i++) {
        listNotify.add(Notify.fromJson(res.data[i]));
      }
    } else {
      print("Error");
    }
  }
}
