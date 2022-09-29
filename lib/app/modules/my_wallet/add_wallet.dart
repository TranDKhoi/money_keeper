import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../controllers/wallet/my_wallet_controller.dart';

class AddWalletScreen extends StatelessWidget {
  AddWalletScreen({Key? key}) : super(key: key);
  final _controller = Get.put(MyWalletController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thêm ví mới"),
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
                    children: const [
                      Icon(
                        Ionicons.wallet,
                        size: 30,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            hintText: "Tên ví",
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: const [
                      Icon(
                        Ionicons.trending_up,
                        size: 30,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            hintText: "Số dư",
                            suffix: Text("VND"),
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
            title: const Text("Không bao gồm vào ví tổng"),
            subtitle: const Text(
                "Tạo ví này và không bao gồm số dư của nó vào ví tổng"),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("THÊM MỚI"),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
