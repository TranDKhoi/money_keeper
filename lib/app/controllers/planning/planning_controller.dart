import 'package:get/get.dart';

class PlanningController extends GetxController{
  var selectedWallet = "Ví tổng".obs;
  List<String> listWallet = ["Ví tổng", 'One', 'Two', 'Three', 'Four'];

  void changeWallet(String value) {
    selectedWallet.value = value;
  }
}