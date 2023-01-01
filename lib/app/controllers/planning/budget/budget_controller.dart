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
    int yearStep = 1;
    while (yearStep <= 2) {
      if (yearStep == 1) {
        for (int i = 1; i <= 12; i++) {
          String time = "$i/${DateTime.now().year - 1}";
          listTimeline.add(time);
        }
      } else if (yearStep == 2) {
        for (int i = 1; i <= DateTime.now().month; i++) {
          String time = "$i/${DateTime.now().year}";
          if (i == DateTime.now().month - 1) time = R.Lastmonth.tr;
          if (i == DateTime.now().month) time = R.Thismonth.tr;
          if (i == DateTime.now().month + 1) time = R.Nextmonth.tr;
          listTimeline.add(time);
        }
      }
      yearStep++;
    }
    for (int i = 0; i < listTimeline.length; i++) {
      if (listTimeline[i] == R.Thismonth.tr) {
        listTimeline[i - 1] = R.Lastmonth.tr;
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
