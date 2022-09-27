import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/controllers/bottombar_controller.dart';

class AddTransactionScreen extends StatelessWidget {
  AddTransactionScreen({Key? key}) : super(key: key);

  final BottomBarController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
