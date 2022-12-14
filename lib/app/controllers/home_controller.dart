import 'package:get/get.dart';
import 'package:money_keeper/app/routes/routes.dart';

class HomeController extends GetxController {
  var selectedReport = 1.obs;

  void changeSelectedReport() {
    selectedReport.value = selectedReport.value == 0 ? 1 : 0;
  }

  void toAllWalletScreen() {
    Get.toNamed(myWalletRoute);
  }

  void toEditTransactionScreen() {
    Get.toNamed(editTransactionRoute);
  }
}
