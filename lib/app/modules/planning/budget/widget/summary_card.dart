import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/planning/budget/budget_controller.dart';
import '../../../../core/values/r.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key, required this.isVisible});
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    final budgetController = Get.find<BudgetController>();
    return Obx(
      () => Visibility(
        visible: isVisible,
        child: (budgetController.budgetSummary.value != null)
            ? Card(
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
                          Text(
                            budgetController.budgetSummary.value!.totalBudget
                                .toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "${budgetController.budgets.length} ${R.budget.tr}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          Text(R.Spent.tr),
                          const Spacer(),
                          Text(
                            budgetController
                                .budgetSummary.value!.totalSpentAmount
                                .toString(),
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(R.canSpent.tr),
                          const Spacer(),
                          Text(
                              "${(budgetController.budgetSummary.value!.totalBudget as int) - (budgetController.budgetSummary.value!.totalSpentAmount as int)}"),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
