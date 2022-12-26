import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
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
            onTap: () async {
              var res = await showModalBottomSheet<int>(
                  context: context,
                  builder: (BuildContext context) =>
                      const IconModalBottomSheet());

              if (res != null) {
                _controller.selectedCategoryPic.value = res;
              }
            },
            child: Row(
              children: [
                Obx(
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
                const SizedBox(width: 20),
                Expanded(
                  child: Obx(
                    () => DropdownButton<String>(
                      value: _controller.selectedEditCategory.value != null
                          ? _controller.selectedEditCategory.value!.type
                          : _controller.selectedType.value,
                      hint: Text("Type".tr),
                      isExpanded: true,
                      icon: const Icon(Ionicons.caret_down),
                      onChanged: (String? value) {
                        _controller.changeType(value!);
                      },
                      items: _controller.listType.map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          ElevatedButton(onPressed: () {}, child: Text("Save".tr))
        ],
      ),
    );
  }
}
