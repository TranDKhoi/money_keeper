import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/controllers/planning/budget/budget_controller.dart';

import '../../../../core/values/r.dart';
import '../../../category/manage_category.dart';

class AddBudget extends StatelessWidget {
  const AddBudget({super.key});

  @override
  Widget build(BuildContext context) {
    final budgetController = Get.find<BudgetController>();
    final bool isEdit = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text((isEdit) ? R.editBudget.tr : R.newBudget.tr),
        actions: [
          TextButton(
            onPressed: () => (isEdit)
                ? budgetController.editBudget()
                : budgetController.createBudget(),
            child: Text(R.Save.tr),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextField(
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.green,
                      ),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "0 đ",
                        hintStyle: TextStyle(
                          color: Colors.green,
                        ),
                        fillColor: Colors.transparent,
                      ),
                      onChanged: (value) =>
                          budgetController.limitAmount = int.parse(value),
                    ),
                    const SizedBox(height: 20),
                    //category
                    Row(
                      children: [
                        Obx(
                          () {
                            if (budgetController.category.value != null) {
                              return CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Image.asset(
                                    "assets/icons/${budgetController.category.value?.icon}.png"),
                              );
                            } else {
                              return const CircleAvatar();
                            }
                          },
                        ),
                        const SizedBox(width: 20),
                        Obx(
                          () => Expanded(
                            child: TextField(
                              onTap: () async {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                var res = await Get.to(
                                  ManageCategoryScreen(
                                    onlyExpense: true,
                                    canChangeWallet: false,
                                    selectedWallet:
                                        budgetController.selectedWallet.value,
                                  ),
                                );
                                if (res != null) {
                                  budgetController.category.value = res;
                                }
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                hintText:
                                    (budgetController.category.value == null)
                                        ? R.Selectcategory.tr
                                        : budgetController.category.value?.name,
                                fillColor: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
