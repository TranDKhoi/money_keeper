import 'package:get/get.dart';
import 'package:money_keeper/app/routes/routes.dart';

class TransactionController extends GetxController {
  void toCreateTransactionScreen() {
    Get.toNamed(addTransactionRoute);
  }

  void toEditTransactionScreen() {
    Get.toNamed(editTransactionRoute);
  }
}
