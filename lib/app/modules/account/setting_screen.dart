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
        title: Text("Setting".tr),
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Ionicons.moon_outline),
            title: Text("Darkmode".tr),
            trailing: Obx(
              () => Switch(
                onChanged: (val) {
                  _controller.changeThemeMode(val);
                },
                value: _controller.isDarkMode.value,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Ionicons.earth_outline),
            title: Text("Vietnamese".tr),
            trailing: Obx(
              () => Switch(
                onChanged: (val) {
                  _controller.changeLanguage(val);
                },
                value: _controller.isVietnamese.value,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
