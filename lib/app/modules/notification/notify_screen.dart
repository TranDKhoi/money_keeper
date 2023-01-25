import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../controllers/notification/notification_controller.dart';
import '../../core/values/r.dart';

class NotifyScreen extends StatelessWidget {
  NotifyScreen({Key? key}) : super(key: key);
  final _controller = Get.find<NotificationController>()..getAllNotify();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.Notification.tr),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Ionicons.refresh))
        ],
      ),
      body: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (ctx, i) => _buildNotiItem(),
          separatorBuilder: (_, __) => const Divider(),
          itemCount: 10),
    );
  }

  _buildNotiItem() {
    return ListTile(
      leading: Icon(Ionicons.albums),
      title: Row(
        children: [
          Expanded(
              flex: 20,
              child: Text(
                "Orverspent 5000 on An uong Category and bla bla on something aloalao",
                maxLines: 3,
              )),
          Spacer(),
          Expanded(flex: 1, child: Icon(Icons.add)),
        ],
      ),
      subtitle: Row(
        children: [
          Row(
            children: [
              Icon(Icons.account_balance_wallet),
              SizedBox(width: 10),
              Text("vi 1"),
            ],
          ),
          const Spacer(),
          Text("3 minutes ago"),
        ],
      ),
    );
  }
}
