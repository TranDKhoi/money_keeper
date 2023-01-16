import 'package:get/get.dart';

import '../../../../data/models/event.dart';
import '../../../../data/models/wallet.dart';
import '../../wallet/my_wallet_controller.dart';

class EventController extends GetxController {
  var listWallet = <Wallet>[].obs;
  var selectedWallet = Wallet().obs;
  var listEventFromAPI = Rxn<List<Event>>();
  var listEvent = Rxn<List<Event>>();

  EventController() {
    listWallet.value = List.from(Get.find<MyWalletController>().listWallet);
    selectedWallet.value = listWallet[0];
  }

  void getAllEvent() {
    listEventFromAPI.value = [];
    for (int i = 0; i < 15; i++) {
      var tempEvent = Event(
          name: "Event $i",
          endDate: DateTime.now(),
          icon: i,
          isFinished: i % 2 == 0 ? false : true,
          wallet: Wallet(name: "Wallet 1"));
      listEventFromAPI.value!.add(tempEvent);
    }
    listEvent.value = List.from(listEventFromAPI.value!
        .where((element) => element.isFinished == false)
        .toList());
  }

  void changeWallet(Wallet value) {
    selectedWallet.value = value;
  }

  void changeEventTabBar(int index) {
    if (index == 0) {
      listEvent.value = List.from(listEventFromAPI.value!
          .where((element) => element.isFinished == false)
          .toList());
    } else {
      listEvent.value = List.from(listEventFromAPI.value!
          .where((element) => element.isFinished == true)
          .toList());
    }
  }
}
