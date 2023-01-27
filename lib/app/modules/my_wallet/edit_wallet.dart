import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/controllers/wallet/my_wallet_controller.dart';

import '../../../data/models/wallet.dart';
import '../../core/values/r.dart';
import '../category/widgets/category_icon_modal.dart';

class EditWalletScreen extends StatelessWidget {
  EditWalletScreen({Key? key}) : super(key: key);

  final MyWalletController _controller = Get.find();
  final selectedWallet = Get.arguments as Wallet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.Editwallet.tr),
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
                          if (selectedWallet.icon != null) {
                            return CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.transparent,
                              child: Image.asset(
                                  "assets/icons/${selectedWallet.icon}.png"),
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
                        child: TextFormField(
                          initialValue: selectedWallet.name,
                          onChanged: (s) {},
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
                  Row(
                    children: [
                      const Icon(
                        Ionicons.trending_up,
                        size: 30,
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          initialValue: selectedWallet.balance.toString(),
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
                ],
              ),
            ),
          ),
          SwitchListTile(
            value: false,
            onChanged: (val) {},
            isThreeLine: true,
            title: Text(R.Notincludeintotalbalance.tr),
            subtitle:
                Text(R.Createanewwalletanddonotincludeitintototalbalance.tr),
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () async{
              var res = await showDialog(
                context: context,
                builder: (_) => Center(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(R.DELETETHISWALLETFOREVER.tr),
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
                _controller.deleteWallet(selectedWallet.id);
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
                  R.DELETETHISWALLETFOREVER.tr,
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {},
              child: Text(R.UPDATE.tr),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
