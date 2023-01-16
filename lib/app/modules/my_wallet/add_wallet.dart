import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/data/models/wallet.dart';

import '../../controllers/wallet/my_wallet_controller.dart';
import '../../core/values/r.dart';
import '../category/widgets/category_icon_modal.dart';

class AddWalletScreen extends StatefulWidget {
  const AddWalletScreen({Key? key}) : super(key: key);

  @override
  State<AddWalletScreen> createState() => _AddWalletScreenState();
}

class _AddWalletScreenState extends State<AddWalletScreen> {
  final MyWalletController _controller = Get.find()..getAllCategoryGroup();

  bool isGroupWallet = false;
  final textWalletName = TextEditingController();
  final textWalletBalance = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //app bar
      appBar: AppBar(
        title: Text(R.Addwallet.tr),
        actions: [
          Row(
            children: [
              Text(R.Groupwallet.tr),
              Switch(
                  value: isGroupWallet,
                  onChanged: (val) {
                    setState(() => isGroupWallet = val);
                  }),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //wallet name and icon
                  Row(
                    children: [
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
                        child: Obx(() {
                          if (_controller.selectedCategoryPic.value != null) {
                            return CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.transparent,
                              child: Image.asset(
                                  "assets/icons/${_controller.selectedCategoryPic.value}.png"),
                            );
                          }
                          return const CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.grey,
                          );
                        }),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                          controller: textWalletName,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            hintText: R.Walletname.tr,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  //wallet balance
                  Row(
                    children: [
                      const Icon(
                        Ionicons.trending_up,
                        size: 30,
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                          controller: textWalletBalance,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            hintText: R.Balance.tr,
                            suffix: const Text("VND"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  //wallet category list
                  Row(
                    children: [
                      const Icon(
                        Ionicons.list_outline,
                        size: 30,
                      ),
                      const SizedBox(width: 20),
                      Obx(
                        () => DropdownButton<Wallet>(
                          value: _controller.selectedCategoryGroup.value,
                          items:
                              _controller.categoryGroupList.map((Wallet value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(
                                "  ${value.name!}",
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (val) {
                            _controller.selectedCategoryGroup.value = val!;
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Get.dialog(
                            Center(
                              child: SizedBox(
                                width: 300,
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      R.instructionofcategorylist.tr,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        child: const Icon(
                          Ionicons.information_circle_outline,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          //include in total
          SwitchListTile(
            value: false,
            onChanged: (val) {},
            isThreeLine: true,
            title: Text(R.Notincludeintotalbalance.tr),
            subtitle:
                Text(R.Createanewwalletanddonotincludeitintototalbalance.tr),
          ),
          const Spacer(),
          //add new Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: _createNewWallet,
              child: Text(R.ADDNEW.tr),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  _createNewWallet() {
    if (textWalletBalance.text.isEmpty ||
        textWalletName.text.isEmpty ||
        _controller.selectedCategoryPic.value == null) {
      return;
    }
    final newWallet = Wallet(
      balance: int.parse(textWalletBalance.text),
      name: textWalletName.text.trim(),
      type: "Personal",
      icon: _controller.selectedCategoryPic.value.toString(),
      clonedCategoryWalletId: _controller.selectedCategoryGroup.value.id == -1
          ? null
          : _controller.selectedCategoryGroup.value.id,
    );
    _controller.createNewWallet(newWallet);
  }
}
