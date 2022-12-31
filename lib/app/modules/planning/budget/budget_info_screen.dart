import 'package:bubble_box/bubble_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_date_utils/in_date_utils.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/modules/planning/budget/widget/line_chart.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../controllers/planning/budget/budget_controller.dart';
import '../../../core/values/r.dart';
import '../../../routes/routes.dart';

class BudgetInfoScreen extends StatelessWidget {
  BudgetInfoScreen({Key? key}) : super(key: key);

  final _controller = Get.find<BudgetController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.Budget.tr),
      ),
      //////
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              indicatorBar(),
              //time left
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(
                  Ionicons.calendar_outline,
                ),
                title: const Text(R.Thismonth),
                subtitle: Text(_calculateTimeLeft()),
              ),
              //current Wallet
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.transparent,
                  child: Image.asset("assets/icons/${1}.png"),
                ),
                title: Text("Vi so 1"),
              ),
              const SizedBox(height: 30),
              //line chart
              const SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  height: 220,
                  width: 650,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: LineChartWidget(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              //recommended spending area
              Row(
                children: [
                  Column(
                    children: [
                      Text(R.recommendeddaily.tr),
                      Text("0"),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Text(R.projectedspending.tr),
                      Text("0"),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(R.actualspending.tr),
                      Text("1000"),
                    ],
                  )
                ],
              ),
              // transaction list
              ElevatedButton(
                onPressed: () => Get.toNamed(eventTransactionScreenRoute),
                child: Text(R.Listoftransaction.tr),
              )
            ],
          ),
        ),
      ),
    );
  }

  indicatorBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //title and icon
        Row(
          children: const [
            CircleAvatar(),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                "Food and something",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        //spent here
        Row(
          children: [
            Text(R.Totalbudget.tr),
            const Spacer(),
            const Text("1000"),
          ],
        ),
        const SizedBox(height: 5),

        Row(
          children: [
            Text(R.Totalexpense.tr),
            const Spacer(),
            const Text("1000"),
          ],
        ),
        const Divider(),
        Row(
          children: [
            Text(R.Totalleft.tr),
            const Spacer(),
            const Text("1000"),
          ],
        ),
        const SizedBox(height: 15),
        //the bar here
        Container(
          height: 50,
          padding: const EdgeInsets.only(left: 30),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Positioned(
                left: 20,
                child: LinearPercentIndicator(
                    padding: EdgeInsets.zero,
                    width: 300,
                    lineHeight: 10.0,
                    percent: 0.8,
                    barRadius: const Radius.circular(50),
                    backgroundColor: Colors.grey,
                    progressColor: Colors.green //or red if 100%,
                    ),
              ),
              Positioned(
                left: _controller.cursorPosition, // from 0 to 290
                child: Column(
                  children: [
                    //this is the red cursor
                    Container(
                      color: Colors.red,
                      width: 1,
                      height: 10,
                    ),
                    BubbleBox(
                      shape: BubbleShapeBorder(
                        position: const BubblePosition.center(0),
                        direction: BubbleDirection.top,
                      ),
                      backgroundColor: Colors.grey.withOpacity(0.3),
                      child: Text(R.now.tr),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _calculateTimeLeft() {
    DateTime today = DateTime.now();
    DateTime nextMonth = DTU.firstDayOfNextMonth(today);
    Duration diff = nextMonth.difference(today);
    if (diff.inDays != 0) {
      return "${diff.inDays} ${R.days.tr} ${R.left.tr}";
    } else {
      return "${diff.inHours} ${R.hour.tr} ${R.left.tr}";
    }
  }
}
