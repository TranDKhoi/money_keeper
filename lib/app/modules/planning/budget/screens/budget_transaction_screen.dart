import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/controllers/planning/budget/budget_controller.dart';
import 'package:money_keeper/app/core/utils/utils.dart';

import '../../../../common/widget/card_transction_item.dart';
import '../../../../core/values/r.dart';

class BudgetTransactionScreen extends StatelessWidget {
  const BudgetTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final budgetController = Get.find<BudgetController>();
    final transaction = budgetController.transaction;
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
                    children: [
                      const Text(
                        R.Income,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        FormatHelper().moneyFormat(transaction.totalIncome),
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
                      const Text(
                        R.Expense,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        FormatHelper().moneyFormat(transaction.totalExpense),
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
                        FormatHelper().moneyFormat(transaction.totalIncome! -
                            transaction.totalExpense!),
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
            child: (transaction.details!.isNotEmpty)
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (_, i) => CardTransactionItem(
                      transactionsByDay: transaction.details![i],
                    ),
                    itemCount: transaction.details?.length,
                  )
                : const Center(
                    child: Text(
                        "There are currently no transactions in this budget"),
                  ),
          ),
        ],
      ),
    );
  }
}