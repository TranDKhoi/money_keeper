import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/controllers/wallet/my_wallet_controller.dart';

class EditWalletScreen extends StatelessWidget {
  EditWalletScreen({Key? key}) : super(key: key);

  final MyWalletController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editwallet".tr),
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
                      const Icon(
                        Ionicons.wallet,
                        size: 30,
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            hintText: "Walletname".tr,
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
                        child: TextField(
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            hintText: "Balance".tr,
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
            title: Text("Notincludeintotalbalance".tr),
            subtitle: Text(
                "Createanewwalletanddonotincludeitintototalbalance".tr),
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () {},
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
                  "DELETETHISWALLETFOREVER".tr,
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
              child: Text("UPDATE".tr),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
