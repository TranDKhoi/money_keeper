import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/modules/category/widgets/category_icon_modal.dart';

import '../../controllers/category/category_controller.dart';

class AddEditCategoryScreen extends StatelessWidget {
  AddEditCategoryScreen({Key? key}) : super(key: key);

  final CategoryController _controller = Get.find();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => _controller.selectedEditCategory.value == null
                ? TextField(
                    decoration: InputDecoration(hintText: "Categoryname".tr))
                : TextField(
                    controller: nameController
                      ..text = _controller.selectedEditCategory.value!.name!,
                    decoration: InputDecoration(hintText: "Categoryname".tr)),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) =>
                      const IconModalBottomSheet());
            },
            child: Obx(
              () {
                if (_controller.selectedEditCategory.value != null) {
                  return CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.transparent,
                    child: Image.asset(
                        "assets/icons/${_controller.selectedEditCategory.value!.image}.png"),
                  );
                }
                if (_controller.selectedCategoryPic.value != null) {
                  return CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.transparent,
                    child: Image.asset(
                        "assets/icons/${_controller.selectedCategoryPic.value}.png"),
                  );
                }
                return const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey,
                );
              },
            ),
          ),
          const SizedBox(height: 50),
          ElevatedButton(onPressed: () {}, child: Text("Save".tr))
        ],
      ),
    );
  }
}