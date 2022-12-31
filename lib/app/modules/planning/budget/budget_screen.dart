import 'package:bubble_box/bubble_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/routes/routes.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../controllers/planning/budget/budget_controller.dart';
import '../../../core/values/r.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({Key? key}) : super(key: key);

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _controller = Get.put(BudgetController());

  @override
  void initState() {
    _tabController =
        TabController(length: _controller.listTimeline.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _controller.changeTimeLine(_tabController.index);
      }
    });
    _tabController.index = _controller.listTimeline.length - 1;
    _controller.changeTimeLine(_tabController.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.Budget.tr),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.transparent,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          tabs: _controller.listTimeline
              .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(e),
                  ))
              .toList(),
        ),
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            summaryCard(isVisible: true),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, i) => InkWell(
                  onTap: () => Get.toNamed(budgetInfoScreen),
                  child: indicatorBar(),
                ),
                separatorBuilder: (context, i) => const Divider(),
                itemCount: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  indicatorBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //title and icon
          Row(
            children: const [
              CircleAvatar(),
              SizedBox(width: 10),
              Text(
                "Food and something",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                "0",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          //spent here
          Row(
            children: const [
              Spacer(),
              Text("1000"),
            ],
          ),
          const SizedBox(height: 5),
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
      ),
    );
  }

  Visibility summaryCard({required bool isVisible}) {
    return Visibility(
      visible: isVisible,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    R.Totalbudget.tr,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  const Text(
                    "1000",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                "2 ${R.budget.tr}",
                style: const TextStyle(color: Colors.grey),
              ),
              const Divider(
                thickness: 1,
              ),
              Row(
                children: [
                  Text(R.Spent.tr),
                  const Spacer(),
                  const Text(
                    "1000",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(R.Overspent.tr),
                  const SizedBox(width: 5),
                  Text(
                    "2 ${R.days.tr}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const Spacer(),
                  const Text("0"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
