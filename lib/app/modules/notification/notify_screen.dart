import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/core/utils/utils.dart';
import 'package:money_keeper/app/modules/planning/budget/screens/budget_info_screen.dart';
import 'package:money_keeper/data/models/notify.dart';

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
          IconButton(
              onPressed: () => _controller.getAllNotify(),
              icon: const Icon(Ionicons.refresh))
        ],
      ),
      body: Obx(
        () => ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (ctx, i) => _buildNotiItem(_controller.listNotify[i]),
          separatorBuilder: (_, __) => const Divider(),
          itemCount: _controller.listNotify.length,
        ),
      ),
    );
  }

  _buildNotiItem(Notify notify) {
    String icon = "";
    switch (notify.type) {
      case "BudgetExceed":
        icon = "assets/icons/warning.png";
        // onTap = () => Get.to(() => BudgetInfoScreen());
        break;
      case "Reminder":
        icon = "assets/icons/alarm.png";
        break;
      case "JoinWalletInvitation ":
        icon = "assets/icons/invite.png";
        break;
    }

    return ListTile(
      onTap: () {
        switch (notify.type) {
          case "BudgetExceed":
            Get.to(() => BudgetInfoScreen());
            break;
          case "Reminder":
            icon = "assets/icons/alarm.png";
            break;
          case "JoinWalletInvitation ":
            icon = "assets/icons/invite.png";
            break;
        }
      },
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Image.asset(icon),
      ),
      title: Row(
        children: [
          Expanded(
              flex: 20,
              child: Text(
                notify.description ?? "",
                maxLines: 3,
              )),
          const Spacer(),
          const Expanded(
            flex: 1,
            child: Icon(
              Icons.circle,
              size: 15,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
      subtitle: Row(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage:
                    AssetImage("assets/icons/${notify.wallet?.icon}.png"),
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(width: 10),
              Text(
                notify.wallet?.name ?? "",
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(FormatHelper().getTimeAgo(notify.createdAt) ?? ""),
        ],
      ),
    );
  }
}
