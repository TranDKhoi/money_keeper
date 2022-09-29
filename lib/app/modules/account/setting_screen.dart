import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/controllers/account/account_controller.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);

  final AccountController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cài đặt và bảo mật"),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Ionicons.moon_outline),
            title: Text("Chế độ ban đêm"),
            trailing: Obx(
              () => Switch(
                onChanged: (val) {
                  _controller.changeThemeMode(val);
                },
                value: _controller.isDarkMode.value,
              ),
            ),
          )
        ],
      ),
    );
  }
}
