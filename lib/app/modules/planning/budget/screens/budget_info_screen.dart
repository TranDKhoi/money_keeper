import 'package:bubble_box/bubble_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_date_utils/in_date_utils.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/modules/planning/budget/widget/line_chart.dart';
import 'package:money_keeper/data/models/budget_detail_summary.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../../data/models/budget.dart';
import '../../../../controllers/planning/budget/budget_controller.dart';
import '../../../../core/values/r.dart';
import '../../../../routes/routes.dart';

class BudgetInfoScreen extends StatelessWidget {
  BudgetInfoScreen({Key? key}) : super(key: key);

  final budgetController = Get.find<BudgetController>();
  late Budget budget;
  late BudgetDetailSummary budgetDetailSummary;
  late int totalLeft;

  @override
  Widget build(BuildContext context) {
    budget = budgetController.budget;
    budgetDetailSummary = budgetController.budgetDetailSummary.value!;
    totalLeft = (budgetDetailSummary.totalBudget as int) -
        (budgetDetailSummary.totalSpentAmount as int);
    return Scaffold(
      appBar: AppBar(
        title: Text(R.Budget.tr),
        actions: [
          IconButton(
              onPressed: () => confirmDeleteBudget(context),
              icon: const Icon(Ionicons.trash))
        ],
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
                  child:
                      Image.asset("assets/icons/${budget.category?.icon}.png"),
                ),
                title:
                    Text(budgetController.selectedWallet.value.name as String),
              ),
              const SizedBox(height: 30),
              //line chart
              const SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  height: 220,
                  child: Padding(
                    padding: EdgeInsets.only(top: 8),
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
                      Text(budgetDetailSummary.recommendedDailyExpense!
                          .toStringAsFixed(2)),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Text(R.projectedspending.tr),
                      Text(budgetDetailSummary.expectedExpense!
                          .toStringAsFixed(2)),
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
                      Text(budgetDetailSummary.realDailyExpense!
                          .toStringAsFixed(2)),
                    ],
                  )
                ],
              ),
              // transaction list
              ElevatedButton(
                onPressed: () async {
                  await budgetController.initBudgetTransactionScreenData();
                  Get.toNamed(budgetTransactionScreenRoute);
                },
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
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image.asset(
                "assets/icons/${budget.category?.icon}.png",
                height: 40,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                budget.category?.name as String,
                style: const TextStyle(
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
            Text(budgetDetailSummary.totalBudget.toString()),
          ],
        ),
        const SizedBox(height: 5),

        Row(
          children: [
            Text(R.Totalexpense.tr),
            const Spacer(),
            Text(budgetDetailSummary.totalSpentAmount.toString()),
          ],
        ),
        const Divider(),
        Row(
          children: [
            Text(R.Totalleft.tr),
            const Spacer(),
            Text(totalLeft.toString()),
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
                    percent: (budgetDetailSummary.totalSpentAmount as int) /
                        (budgetDetailSummary.totalBudget as int),
                    barRadius: const Radius.circular(50),
                    backgroundColor: Colors.grey,
                    progressColor: Colors.green //or red if 100%,
                    ),
              ),
              Positioned(
                left: budgetController.cursorPosition, // from 0 to 290
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

  confirmDeleteBudget(context) async {
    var res = await showDialog(
      context: context,
      builder: (_) => Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(R.Deletethisbudgetquestion.tr),
                const SizedBox(height: 30),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                        onPressed: () => Get.back(result: false),
                        child: Text(R.No.tr)),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () => Get.back(result: true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                      ),
                      child: Text(R.Yes.tr),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
    if (res == true) {
      budgetController.deleteBudget();
    }
  }
}