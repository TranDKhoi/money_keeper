import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/controllers/account/account_controller.dart';

import '../../core/values/R.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final AccountController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //AVT
                GestureDetector(
                  onTap: () {
                    _controller.pickAvatar();
                  },
                  child: const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.green,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  _controller.currentUser.value?.email ?? "",
                  textAlign: TextAlign.center,
                ),
                const Divider(thickness: 1),
                //my wallet
                ListTile(
                  onTap: () {
                    _controller.toMyWalletScreen();
                  },
                  leading: const Icon(Ionicons.wallet_outline),
                  title: Text(R.Mywallet.tr),
                  trailing: const Icon(Ionicons.chevron_forward),
                ),
                ListTile(
                  onTap: () {
                    _controller.toManageCategoryScreen();
                  },
                  leading: const Icon(Ionicons.file_tray_full_outline),
                  title: Text(R.ManageCategory.tr),
                  trailing: const Icon(Ionicons.chevron_forward),
                ),
                //setting
                ListTile(
                  onTap: () {
                    _controller.toSettingScreen();
                  },
                  leading: const Icon(Ionicons.settings_outline),
                  title: Text(R.Setting.tr),
                  trailing: const Icon(Ionicons.chevron_forward),
                ),
                //log out
                ListTile(
                  onTap: () {
                    _controller.toLoginScreen();
                  },
                  leading: const Icon(Ionicons.log_in_outline),
                  title: Text(R.Signout.tr),
                  trailing: const Icon(Ionicons.chevron_forward),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
