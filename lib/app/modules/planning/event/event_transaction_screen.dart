import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/common/widget/card_transction_item.dart';

import '../../../../data/models/transactions_by_day.dart';
import '../../../core/values/r.dart';

class EventTransactionScreen extends StatelessWidget {
  const EventTransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    "1 ${R.result.tr}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  //income
                  Row(
                    children: const [
                      Text(
                        R.Income,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "0 đ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      )
                    ],
                  ),
                  //expense
                  Row(
                    children: const [
                      Text(
                        R.Expense,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "0 đ",
                        style: TextStyle(
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
                    children: const [
                      Spacer(),
                      Text(
                        "0",
                        style: TextStyle(
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
              itemCount: 5,
            ),
          ),
        ],
      ),
    );
  }
}
