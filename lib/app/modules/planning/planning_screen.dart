import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/routes/routes.dart';

import '../../controllers/planning/planning_controller.dart';

class PlanningScreen extends StatefulWidget {
  const PlanningScreen({Key? key}) : super(key: key);

  @override
  State<PlanningScreen> createState() => _PlanningScreenState();
}

class _PlanningScreenState extends State<PlanningScreen> {
  final _controller = Get.put(PlanningController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Planning".tr),
        actions: [
          Obx(
            () => DropdownButton<String>(
              value: _controller.selectedWallet.value,
              icon: const Icon(Ionicons.caret_down),
              onChanged: (String? value) {
                _controller.changeWallet(value!);
              },
              items: _controller.listWallet.map((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      //////////////////
      body: ListView(
        children: [
          ListTile(
            onTap: () {},
            contentPadding: const EdgeInsets.all(20),
            leading: const Icon(
              Ionicons.pie_chart,
              color: Colors.green,
              size: 30,
            ),
            trailing: const Icon(Ionicons.chevron_forward_outline),
            title: Text(
              "Budget".tr,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            subtitle: Text("Afinancial".tr),
          ),
          ListTile(
            onTap: () => Get.toNamed(eventScreenRoute),
            contentPadding: const EdgeInsets.all(20),
            leading: const Icon(
              Ionicons.calendar_sharp,
              color: Colors.green,
              size: 30,
            ),
            trailing: const Icon(Ionicons.chevron_forward_outline),
            title: Text(
              "Event".tr,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            subtitle: Text("Createaneventto".tr),
          ),
        ],
      ),
    );
  }
}