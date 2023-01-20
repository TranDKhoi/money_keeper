import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/controllers/transaction/add_transaction_controller.dart';
import 'package:money_keeper/app/routes/routes.dart';

import '../../core/utils/utils.dart';
import '../../core/values/r.dart';
import '../category/manage_category.dart';

class AddTransactionScreen extends StatelessWidget {
  AddTransactionScreen({Key? key}) : super(key: key);

  final _controller = Get.put(AddTransactionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.Newtransaction.tr),
        actions: [
          TextButton(
            onPressed: () => _controller.createNewTransaction(),
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
                      controller: _controller.amountController,
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
                    ),
                    const SizedBox(height: 10),
                    //wallet
                    Row(
                      children: [
                        Obx(
                          () {
                            if (_controller.selectedWallet.value != null) {
                              return CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.transparent,
                                child: Image.asset(
                                    "assets/icons/${_controller.selectedWallet.value?.icon}.png"),
                              );
                            }
                            return const CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.grey,
                            );
                          },
                        ),
                        const SizedBox(width: 20),
                        Obx(
                          () => Expanded(
                            child: TextField(
                              enabled: true,
                              onTap: () async {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                var res = await Get.toNamed(myWalletRoute,
                                    arguments: true);
                                if (res != null) {
                                  _controller.selectedWallet.value = res;
                                }
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                hintText: _controller
                                            .selectedWallet.value?.name ==
                                        null
                                    ? R.Selectwallet.tr
                                    : _controller.selectedWallet.value!.name,
                                fillColor: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    //category
                    Row(
                      children: [
                        Obx(
                          () {
                            if (_controller.selectedCategory.value != null) {
                              return CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Image.asset(
                                    "assets/icons/${_controller.selectedCategory.value!.icon}.png"),
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
                              enabled: _controller.selectedWallet.value != null
                                  ? true
                                  : false,
                              onTap: () async {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                var res = await Get.to(
                                  ManageCategoryScreen(
                                    canChangeWallet: false,
                                    selectedWallet:
                                        _controller.selectedWallet.value,
                                  ),
                                );
                                if (res != null) {
                                  _controller.selectedCategory.value = res;
                                }
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                hintText: _controller
                                            .selectedCategory.value?.name ==
                                        null
                                    ? R.Selectcategory.tr
                                    : _controller.selectedCategory.value!.name,
                                fillColor: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    //note
                    Row(
                      children: [
                        const Icon(Ionicons.list_outline),
                        const SizedBox(width: 30),
                        Expanded(
                          child: TextField(
                            controller: _controller.noteController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              hintText: R.Note.tr,
                              fillColor: Colors.transparent,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    //date
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
