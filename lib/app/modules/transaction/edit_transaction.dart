import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/controllers/transaction/edit_transaction_controller.dart';

import '../../core/utils/utils.dart';

class EditTransactionScreen extends StatelessWidget {
  EditTransactionScreen({Key? key}) : super(key: key);

  final _controller = Get.put(EditTransactionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sửa khoản chi"),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text("Lưu"),
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
                    const TextField(
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.green,
                      ),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "0 đ",
                        hintStyle: TextStyle(
                          color: Colors.green,
                        ),
                        fillColor: Colors.transparent,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: const [
                        CircleAvatar(),
                        SizedBox(width: 20),
                        Expanded(
                          child: TextField(
                            enabled: false,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              hintText: "Chọn danh mục",
                              fillColor: Colors.transparent,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: const [
                        Icon(Ionicons.list_outline),
                        SizedBox(width: 30),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              hintText: "Ghi chú",
                              fillColor: Colors.transparent,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Icon(Ionicons.calendar_outline),
                        const SizedBox(width: 30),
                        GestureDetector(
                          onTap: () async {
                            DateTime? selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2030));
                            if (selectedDate != null) {
                              _controller.pickedDate.value = selectedDate;
                            }
                          },
                          child: Obx(
                            () => Text(
                              FormatHelper()
                                  .dateFormat(_controller.pickedDate.value),
                              style: const TextStyle(
                                fontSize: 16,
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
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          _controller.pickedImageGallery();
                        },
                        child: const Icon(
                          Ionicons.image,
                          size: 40,
                        ),
                      ),
                      const VerticalDivider(),
                      GestureDetector(
                        onTap: () {
                          _controller.pickedImageCamera();
                        },
                        child: const Icon(
                          Ionicons.camera,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Obx(() {
              if (_controller.pickedImage.value != null) {
                return Stack(
                  children: [
                    Image.file(
                      File(_controller.pickedImage.value!),
                    ),
                    GestureDetector(
                      onTap: () {
                        _controller.deleteImage();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Icon(
                          Ionicons.close,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }
}
