import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/common/widget/card_transction_item.dart';

import '../../../../data/models/event.dart';
import '../../../../data/models/transactions_by_day.dart';
import '../../../core/utils/utils.dart';
import '../../../core/values/r.dart';

class EventTransactionScreen extends StatelessWidget {
  const EventTransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Event selectedEvent = Get.arguments as Event;

    return Scaffold(
      appBar: AppBar(
        title: Text(R.Listoftransaction.tr),
      ),
      body: Column(
        children: [
          //summary information here
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //number of result
                  Text(
                    "${selectedEvent.transactions?.length ?? 0} ${R.result.tr}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  //income
                  Row(
                    children: [
                      Text(
                        R.Income.tr,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        FormatHelper().moneyFormat(_calculateIncome()),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      )
                    ],
                  ),
                  //expense
                  Row(
                    children: [
                      Text(
                        R.Expense.tr,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        FormatHelper().moneyFormat(_calculateExpense()),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      Text(
                        FormatHelper().moneyFormat(
                            _calculateIncome() - _calculateExpense()),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          //list of transaction
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, i) => CardTransactionItem(
                transactionsByDay: TransactionsByDay(),
              ),
              itemCount: selectedEvent.transactions?.length,
            ),
          ),
        ],
      ),
    );
  }

  int _calculateIncome() {
    return 0;
  }

  int _calculateExpense() {
    return 0;
  }
}
