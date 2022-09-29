import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/controllers/bottombar_controller.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final _controller = Get.put(BottomBarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _controller.listPage[_controller.currentIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomAppBar(
          elevation: 100,
          clipBehavior: Clip.antiAlias,
          notchMargin: 5,
          shape: const CircularNotchedRectangle(),
          child: Wrap(
            children: [
              BottomNavigationBar(
                currentIndex: _controller.currentIndex.value,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                selectedFontSize: 25,
                type: BottomNavigationBarType.fixed,
                onTap: (i) => _controller.changePage(i),
                items: [
                  BottomNavigationBarItem(
                    icon: const Icon(Ionicons.home),
                    label: "Home".tr,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Ionicons.wallet),
                    label: "Transaction".tr,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Ionicons.stats_chart),
                    label: "Report".tr,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Ionicons.person),
                    label: "Account".tr,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(
          Ionicons.add,
          color: Colors.white,
        ),
        onPressed: () {
          _controller.toCreateTransactionScreen();
        },
      ),
    );
  }
}
