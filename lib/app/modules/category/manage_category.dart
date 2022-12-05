import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../../data/models/category.dart';
import '../../controllers/category/category_controller.dart';
import 'add_edit_category.dart';

class ManageCategoryScreen extends StatelessWidget {
  ManageCategoryScreen({Key? key, this.canBack = true}) : super(key: key);

  final _controller = Get.put(CategoryController());
  bool canBack;

  final List<Category> listCate = List.generate(
      13,
      (index) => Category(
          name: "name $index",
          image: index,
          type: index % 2 == 0 ? "Income".tr : "Expense".tr));

  @override
  Widget build(BuildContext context) {
    final incomeList =
        listCate.where((element) => element.type == "Income".tr).toList();
    final expenseList =
        listCate.where((element) => element.type == "Expense".tr).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("ManageCategory".tr),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Income".tr,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, i) {
                  return _buildSlideItem(incomeList[i]);
                },
                itemCount: incomeList.length,
              ),
              const SizedBox(height: 20),
              Text(
                "Expense".tr,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, i) {
                  return _buildSlideItem(expenseList[i]);
                },
                itemCount: expenseList.length,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () async {
          await showDialog(
              context: context, builder: (context) => AddEditCategoryScreen());
          _controller.selectedCategoryPic.value = null;
        },
        foregroundColor: Colors.white,
        child: const Icon(Ionicons.add),
      ),
    );
  }

  _buildSlideItem(Category cate) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) async {
              _controller.selectedEditCategory.value = cate;
              await showDialog(
                  context: context,
                  builder: (context) => AddEditCategoryScreen());
              _controller.selectedEditCategory.value = null;
            },
            backgroundColor: Colors.green,
            icon: Ionicons.pencil,
          ),
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: Colors.red,
            icon: Ionicons.trash_outline,
          ),
        ],
      ),
      child: ListTile(
        onTap: () {
          if (canBack) Get.back(result: cate);
        },
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Image.asset("assets/icons/${cate.image}.png"),
        ),
        title: Text(cate.name ?? ""),
      ),
    );
  }
}
