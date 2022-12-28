import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/modules/report/widgets/report_pie_chart.dart';

import '../../common/widget/in_ex_item.dart';
import '../../core/values/r.dart';

class ExpenseDetail extends StatelessWidget {
  ExpenseDetail({Key? key}) : super(key: key);

  final List<Widget> listIncome = [
    const InExItem(),
    const InExItem(),
    const InExItem(),
    const InExItem(),
    const InExItem(),
    const InExItem(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.Expensedetail.tr),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Totalexpense",
                style: TextStyle(fontSize: 30),
              ),
              const Text(
                "200.000 đ",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                ),
              ),
              Row(
                children: const [Expanded(child: ReportPieChart())],
              ),
              const Divider(thickness: 1),
              ...listIncome,
            ],
          ),
        ),
      ),
    );
  }
}
