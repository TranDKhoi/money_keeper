import 'package:get/get.dart';
import 'package:money_keeper/app/routes/routes.dart';

class MyWalletController extends GetxController {
  void toEditWallet() {
    Get.toNamed(editWalletRoute);
  }

  void toAddWallet() {
    Get.toNamed(addWalletRoute);
  }
}
