import 'package:get/get.dart';

import '../../../../data/models/event.dart';
import '../../../../data/models/wallet.dart';

class AddEditEventController extends GetxController {
  var selectedIcon = Rxn<int>();
  var eventName = Rxn<String>();
  var endDate = Rxn<DateTime>();
  var selectedWallet = Rxn<Wallet>();
  var selectedEvent = Rxn<Event>();

  void setSelectedEditEvent(Event selectedEvent) {
    selectedIcon.value = selectedEvent.icon;
    eventName.value = selectedEvent.name;
    endDate.value = selectedEvent.endDate;
    selectedWallet.value = selectedEvent.wallet;
  }
}
