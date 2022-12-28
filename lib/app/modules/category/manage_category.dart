import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../../data/models/category.dart';
import '../../controllers/category/category_controller.dart';
import '../../core/values/r.dart';
import 'add_edit_category.dart';

class ManageCategoryScreen extends StatefulWidget {
  const ManageCategoryScreen({Key? key, this.canBack = true}) : super(key: key);

  final bool canBack;

  @override
  State<ManageCategoryScreen> createState() => _ManageCategoryScreenState();
}

class _ManageCategoryScreenState extends State<ManageCategoryScreen>
    with SingleTickerProviderStateMixin {
  final _controller = Get.put(CategoryController());

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _controller.changeListCategory(_tabController.index);
      }
    });
    _controller.changeListCategory(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.ManageCategory.tr),
        bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.transparent,
            labelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            tabs: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(R.LoansDebts.tr),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(R.Income.tr),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(R.Expense.tr),
              ),
            ]),
      ),
      //////////////////
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Obx(
            () => ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, i) =>
                  _buildSlideItem(_controller.listCategoryUI[i]),
              itemCount: _controller.listCategoryUI.length,
            ),
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
          if (widget.canBack) Get.back(result: cate);
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
