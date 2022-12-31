import 'package:get/get.dart';
import 'package:in_date_utils/in_date_utils.dart';

import '../../../core/values/r.dart';

class BudgetController extends GetxController {
  var listTimeline = [].obs;
  var selectedTimeLine = Rxn<String>();

  BudgetController() {
    generateTimeLine();
    _calculatePositionByMonth();
  }

  void changeTimeLine(int index) {
    selectedTimeLine.value = listTimeline[index];
  }

  void generateTimeLine() {
    for (int j = 1; j <= 2; j++) {
      for (int i = 1; i <= 12; i++) {
        if (i > DateTime.now().month + 1) continue;
        String time = "$i/202$j";
        if (time.contains("${DateTime.now().month - 1}/${DateTime.now().year}"))
          time = R.Lastmonth.tr;
        if (time.contains("${DateTime.now().month}/${DateTime.now().year}"))
          time = R.Thismonth.tr;
        if (time.contains("${DateTime.now().month + 1}/${DateTime.now().year}"))
          time = R.Nextmonth.tr;
        listTimeline.add(time);
      }
    }
  }

  //this logic is for the indicator and cursor position
  double _cursorPosition = 1; // only from 0 to 290
  double get cursorPosition => _cursorPosition <= 0 ? 5 : _cursorPosition * 295;

  void _calculatePositionByMonth() {
    int dayInMonth = DTU.getDaysInMonth(2022, 12);
    int today = DateTime.now().day;
    if (today == 1) today = 0;

    double diffPercentage = today / dayInMonth;

    _cursorPosition *= diffPercentage;
  }
}
