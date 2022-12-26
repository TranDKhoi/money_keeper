import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/routes/routes.dart';

import '../../../controllers/planning/event/event_controller.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen>
    with SingleTickerProviderStateMixin {
  final _controller = Get.put(EventController());

  late TabController _tabController;

  @override
  void initState() {
    _controller.getAllEvent();

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _controller.changeEventTabBar(_tabController.index);
      }
    });
    _tabController.index = 0;
    _controller.changeEventTabBar(_tabController.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Text("Event".tr),
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
        bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.transparent,
            labelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            tabs: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text("Running".tr),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text("Finished".tr),
              )
            ]),
      ),
      //////////////
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Obx(
          () => Column(
            children: _controller.listEvent.value!
                .map(
                  (e) => Card(
                    child: InkWell(
                      onTap: () =>
                          Get.toNamed(eventInfoScreenRoute, arguments: e)?.then((value) => _controller.changeEventTabBar(_tabController.index)),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Image.asset("assets/icons/${e.icon}.png"),
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.name!,
                                  style: const TextStyle(fontSize: 20),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Spent".tr,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                    const Text(
                                      ": 100.000d",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(addEventScreenRoute),
        backgroundColor: Colors.green,
        child: const Icon(
          Ionicons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
