import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/controllers/wallet/my_wallet_controller.dart';
import 'package:money_keeper/app/routes/routes.dart';

class MyWalletScreen extends StatelessWidget {
  MyWalletScreen({Key? key}) : super(key: key);

  final _controller = Get.put(MyWalletController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mywallet".tr),
      ),
      body: Column(
        children: [
          const Divider(thickness: 1),
          ListTile(
            isThreeLine: true,
            dense: true,
            leading: Icon(
              Ionicons.earth,
              size: 40,
            ),
            title: Text(
              "All".tr,
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            subtitle: Text(
              "100.000 đ",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          const Divider(thickness: 1),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20, bottom: 10),
              child: Text(
                "Including".tr,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context1, index1) {
                return ListTile(
                  onTap: () {
                    _controller.toEditWallet();
                  },
                  isThreeLine: true,
                  dense: true,
                  leading: const Icon(Ionicons.cash),
                  title: Text(
                    "Ví số $index1",
                    style: const TextStyle(fontSize: 25),
                  ),
                  subtitle: const Text(
                    "100.000 d",
                    style: TextStyle(fontSize: 15),
                  ),
                );
              },
              separatorBuilder: (context2, index2) {
                return const Divider(thickness: 1);
              },
              itemCount: 5,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.toAddWallet();
        },
        backgroundColor: Colors.green,
        child: const Icon(
          Ionicons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
