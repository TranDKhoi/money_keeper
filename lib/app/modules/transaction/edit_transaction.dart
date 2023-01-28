import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/controllers/transaction/edit_transaction_controller.dart';

import '../../../data/models/transaction.dart';
import '../../controllers/wallet/my_wallet_controller.dart';
import '../../core/utils/utils.dart';
import '../../core/values/r.dart';
import '../../routes/routes.dart';
import '../category/manage_category.dart';
import '../planning/event/event_screen.dart';

class EditTransactionScreen extends StatefulWidget {
  const EditTransactionScreen({Key? key, required this.selectedTrans})
      : super(key: key);

  final Transaction selectedTrans;

  @override
  State<EditTransactionScreen> createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  Transaction tempTrans = Transaction();

  final _controller = Get.put(EditTransactionController());

  final walletController = Get.find<MyWalletController>();

  @override
  void initState() {
    tempTrans =
        Transaction.fromJson(jsonDecode(jsonEncode(widget.selectedTrans)));
    tempTrans.wallet = walletController.listWallet
        .where((element) => element.id == widget.selectedTrans.walletId)
        .first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.Edittransaction.tr),
        actions: [
          TextButton(
            onPressed: () => _controller.updateTransaction(tempTrans),
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
                    TextFormField(
                      initialValue: tempTrans.amount.toString(),
                      onChanged: (val) => tempTrans.amount =
                          int.parse(val.trim().isEmpty ? "0" : val.trim()),
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.green,
                      ),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "0",
                        hintStyle: TextStyle(
                          color: Colors.green,
                        ),
                        fillColor: Colors.transparent,
                        suffixText: "đ",
                      ),
                    ),
                    const SizedBox(height: 10),
                    //wallet
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.transparent,
                          child: Image.asset(
                              "assets/icons/${tempTrans.wallet!.icon}.png"),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextField(
                            enabled: true,
                            onTap: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              var res = await Get.toNamed(myWalletRoute,
                                  arguments: true);
                              if (res != null) {
                                if (res.id != widget.selectedTrans.walletId) {
                                  tempTrans.category = null;
                                  setState(() {
                                    tempTrans.wallet = res;
                                  });
                                }
                              }
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              hintText: tempTrans.wallet?.name ?? "",
                              fillColor: Colors.transparent,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // //category
                    tempTrans.category == null
                        ? Row(
                            children: [
                              const CircleAvatar(
                                backgroundColor: Colors.grey,
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: TextField(
                                  onTap: () async {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    var res = await Get.to(
                                      ManageCategoryScreen(
                                        canChangeWallet: false,
                                        selectedWallet: tempTrans.wallet,
                                      ),
                                    );
                                    if (res != null) {
                                      setState(() {
                                        tempTrans.category = res;
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    hintText: R.Selectcategory.tr,
                                    fillColor: Colors.transparent,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Image.asset(
                                    "assets/icons/${tempTrans.category!.icon}.png"),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: TextField(
                                  onTap: () async {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    var res = await Get.to(
                                      ManageCategoryScreen(
                                        canChangeWallet: false,
                                        selectedWallet: tempTrans.wallet,
                                      ),
                                    );
                                    if (res != null) {
                                      setState(() {
                                        tempTrans.category = res;
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    hintText: tempTrans.category!.name,
                                    fillColor: Colors.transparent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                    const SizedBox(height: 10),
                    // //note
                    Row(
                      children: [
                        const Icon(Ionicons.list_outline),
                        const SizedBox(width: 30),
                        Expanded(
                          child: TextFormField(
                            onChanged: (val) => tempTrans.note = val.trim(),
                            initialValue: tempTrans.note,
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
                              setState(() {
                                tempTrans.createdAt = selectedDate;
                              });
                            }
                          },
                          child: Text(
                            FormatHelper().dateFormat(tempTrans.createdAt!),
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    //of event?
                    Row(
                      children: [
                        tempTrans.event != null
                            ? CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Image.asset(
                                    "assets/icons/${tempTrans.event?.icon}.png"),
                              )
                            : const CircleAvatar(),
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextField(
                            enabled: tempTrans.wallet != null ? true : false,
                            onTap: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              var res = await Get.to(() => EventScreen(
                                    canChangeWallet: false,
                                    selectedWallet: tempTrans.wallet,
                                  ));
                              if (res != null) {
                                setState(() {
                                  tempTrans.event = res;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              hintText:
                                  tempTrans.event?.name ?? R.Oftheevent.tr,
                              fillColor: Colors.transparent,
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
                        onTap: () async {
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
            Obx(
              () {
                if (_controller.pickedImage.value != null) {
                  return Stack(
                    children: [
                      Image.file(File(
                          _controller.pickedImage.value ?? tempTrans.image!)),
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
                } else {
                  if (tempTrans.image != null) {
                    return Stack(
                      children: [
                        Image.network(tempTrans.image!),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              tempTrans.image == null;
                            });
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
                }

                return const SizedBox.shrink();
              },
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                var res = await showDialog(
                  context: context,
                  builder: (_) => Center(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(R.Deletethistransactionquesttion.tr),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton(
                                    onPressed: () => Get.back(result: false),
                                    child: Text(R.No.tr)),
                                const SizedBox(width: 20),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.redAccent,
                                    ),
                                    onPressed: () => Get.back(result: true),
                                    child: Text(R.Yes.tr)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
                if (res != null && res) {
                  _controller.deleteTransaction(tempTrans);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Icon(
                    Ionicons.trash,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    R.Deletethistransaction.tr,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
