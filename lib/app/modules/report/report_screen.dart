import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/controllers/report/report_controller.dart';
import 'package:money_keeper/app/core/utils/utils.dart';
import 'package:money_keeper/app/modules/report/widgets/report_bar_chart.dart';
import 'package:money_keeper/app/modules/report/widgets/report_pie_chart.dart';

import '../../core/values/r.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen>
    with SingleTickerProviderStateMixin {
  final _controller = Get.put(ReportController());
  late TabController _tabController;

  @override
  void initState() {
    _tabController =
        TabController(length: _controller.listTimeline.length, vsync: this);
    _tabController.index = _controller.listTimeline.length - 2;
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _controller.changeTimeLine(_tabController.index);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: Column(
          children: [
            Text(R.Balance.tr),
            const Text("100.000đ"),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(context.screenSize.height * 0.1),
          child: Column(
            children: [
              Obx(
                () => DropdownButton<String>(
                  value: _controller.selectedWallet.value,
                  icon: const Icon(Ionicons.caret_down),
                  onChanged: (String? value) {
                    _controller.changeWallet(value!);
                  },
                  items: _controller.listWallet.map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              TabBar(
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
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                R.IncomeandExpense.tr,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(R.Totalleft.tr),
              const Text(
                "50.000đ",
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(height: 10),
              const ReportBarChart(),
              //income pie
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    R.Income.tr,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      _controller.toIncomeDetailsScreen();
                    },
                    child: Text(
                      R.Detail.tr,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
              const Text(
                "100.000 đ",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              Row(
                children: const [
                  Expanded(child: ReportPieChart()),
                ],
              ),
              //expense pie
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    R.Expense.tr,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      _controller.toExpenseDetailsScreen();
                    },
                    child: Text(
                      R.Detail.tr,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
              const Text(
                "20.000 đ",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              Row(
                children: const [
                  Expanded(child: ReportPieChart()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
