import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/home/home_screen.dart';

class BottomBarController extends GetxController {
  List<Widget> listPage = [
    const HomeScreen(),
    Text("2"),
    Text("3"),
    Text("4"),
  ];

  var currentIndex = 0.obs;

  void changePage(int val) {
    currentIndex.value = val;
  }
}
