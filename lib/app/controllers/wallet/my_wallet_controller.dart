import 'package:get/get.dart';
import 'package:money_keeper/app/routes/routes.dart';

import '../../../data/models/wallet.dart';

class MyWalletController extends GetxController {
  var listWallet = Rxn<List<Wallet>>();

  void getAllWalletData() {
    listWallet.value = [];
    for (int i = 0; i < 5; i++) {
      var tempWall = Wallet(name: "Wallet $i", balance: 100000);
      listWallet.value?.add(tempWall);
    }
  }

  void toEditWallet(Wallet selectedWallet) {
    Get.toNamed(editWalletRoute, arguments: selectedWallet);
  }

  void toAddWallet() {
    Get.toNamed(addWalletRoute);
  }
}
