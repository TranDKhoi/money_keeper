import 'package:flutter/material.dart';
import 'package:money_keeper/app/modules/report/widgets/report_pie_chart.dart';

import '../../common/widget/in_ex_item.dart';

class IncomeDetail extends StatelessWidget {
  IncomeDetail({Key? key}) : super(key: key);

  final List<Widget> listIncome = [
    InExItem(),
    InExItem(),
    InExItem(),
    InExItem(),
    InExItem(),
    InExItem(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chi tiết khoản thu"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Tổng thu",
                style: TextStyle(fontSize: 30),
              ),
              Text(
                "200.000 đ",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                ),
              ),
              Row(
                children: [Expanded(child: ReportPieChart())],
              ),
              Divider(thickness: 1),
              ...listIncome,
            ],
          ),
        ),
      ),
    );
  }
}
