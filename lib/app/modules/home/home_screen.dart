import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/controllers/bottombar_controller.dart';
import 'package:money_keeper/app/controllers/home_controller.dart';
import 'package:money_keeper/app/controllers/transaction/transaction_controller.dart';
import 'package:money_keeper/app/modules/home/widgets/home_chart_bar.dart';

import '../../common/widget/home_transaction_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = Get.put(HomeController());

  final BottomBarController _bottomController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                //total balance
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "100.000 đ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                          ),
                        ),
                        Text("Totalbalance".tr),
                      ],
                    ),
                    const Spacer(),
                    const Icon(Ionicons.notifications)
                  ],
                ),
                // my wallets
                const SizedBox(height: 20),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Mywallet".tr,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                _controller.toAllWalletScreen();
                              },
                              child: Text(
                                "Seemore".tr,
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Ionicons.earth),
                            const SizedBox(width: 10),
                            Text(
                              "All".tr,
                              style: const TextStyle(fontSize: 25),
                            ),
                            const Spacer(),
                            const Text(
                              "100.000 đ",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                //report
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Text(
                      "Report".tr,
                    ),
                    const Spacer(),
                    Text(
                      "Detail".tr,
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                //week-month
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Card(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          elevation: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Obx(
                                () => Expanded(
                                  child: GestureDetector(
                                    onTap: _controller.changeSelectedReport,
                                    child: Card(
                                      elevation: 0,
                                      color:
                                          _controller.selectedReport.value == 0
                                              ? Colors.grey[100]
                                              : Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Week".tr,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Obx(
                                () => Expanded(
                                  child: GestureDetector(
                                    onTap: _controller.changeSelectedReport,
                                    child: Card(
                                      elevation: 0,
                                      color:
                                          _controller.selectedReport.value == 0
                                              ? Theme.of(context)
                                                  .scaffoldBackgroundColor
                                              : Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Month".tr,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 20, color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //total spent
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "100.000 đ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                            Obx(
                              () => Text(
                                _controller.selectedReport.value == 0
                                    ? "Totalexpenseofthisweek".tr
                                    : "Totalexpenseofthismonth".tr,
                              ),
                            ),
                          ],
                        ),
                        //charts
                        const SizedBox(height: 30),
                        HomeChartBar(),
                        //most spent
                        const SizedBox(height: 10),
                        Text(
                          "Mostexpense".tr,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ListTile(
                          onTap: () {},
                          contentPadding: EdgeInsets.zero,
                          isThreeLine: true,
                          dense: true,
                          leading: const Icon(Ionicons.wallet),
                          title: const Text(
                            "Ăn và ún",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          subtitle: const Text(
                            "100.000 đ",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          trailing: const Text(
                            "100%",
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //recent spent
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Text(
                      "Recently".tr,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        _bottomController.changePage(1);
                      },
                      child: Text(
                        "Detail".tr,
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: HomeTransactionItem(
                      onTap: _controller.toEditTransactionScreen,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
