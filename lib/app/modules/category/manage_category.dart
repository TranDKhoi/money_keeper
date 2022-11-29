import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ionicons/ionicons.dart';

import '../../../data/models/category.dart';
import '../../controllers/category/category_controller.dart';
import 'add_edit_category.dart';

class ManageCategoryScreen extends StatelessWidget {
  ManageCategoryScreen({Key? key, this.canBack = true}) : super(key: key);

  final _controller = Get.put(CategoryController());
  bool canBack;

  final List<Category> listCate =
      List.generate(13, (index) => Category(name: "name $index", image: index));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ManageCategory".tr),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, i) {
          return _buildSlideItem(listCate[i]);
        },
        itemCount: listCate.length,
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
