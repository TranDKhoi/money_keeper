import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/controllers/transaction/transaction_controller.dart';
import 'package:money_keeper/app/core/utils/utils.dart';

import '../../common/widget/card_transction_item.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen>
    with SingleTickerProviderStateMixin {
  final _controller = Get.put(TransactionController());
  late TabController _tabController;

  @override
  void initState() {
    _tabController =
        TabController(length: _controller.listTimeline.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _controller.changeTimeLine(_tabController.index);
      }
    });
    _tabController.index = _controller.listTimeline.length - 2;
    _controller.changeTimeLine(_tabController.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: Column(
          children: const [
            Text("Số dư"),
            Text("100.000đ"),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(context.screenSize.height * 0.1),
          child: Column(
            children: [
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
              TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorColor: Colors.transparent,
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                tabs: _controller.listTimeline
                    .map((e) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(e),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Obx(() {
          if (_controller.selectedTimeLine.value != null) {
            return Column(
              children: [
                Visibility(
                  visible: false,
                  child: Text(
                    _controller.selectedTimeLine.value!,
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            Text("Khoản thu"),
                            Spacer(),
                            Text(
                              "0",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: const [
                            Text("Khoản chi"),
                            Spacer(),
                            Text(
                              "100.000đ",
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          children: const [
                            Spacer(),
                            Text(
                              "-100.000đ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text("Xem thống kê kỳ này"),
                        )
                      ],
                    ),
                  ),
                ),
                CardTransactionItem(onTap: () {}),
                CardTransactionItem(onTap: () {}),
              ],
            );
          }
          return const SizedBox.shrink();
        }),
      ),
    );
  }
}