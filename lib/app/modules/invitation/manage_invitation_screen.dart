import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/data/models/invitation.dart';

import '../../controllers/invitation_controller.dart';
import '../../core/values/r.dart';

class ManageInvitationScreen extends StatelessWidget {
  ManageInvitationScreen({Key? key}) : super(key: key);

  final _controller = Get.put(InvitationController())..getAllInvitation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.invitation.tr),
      ),
      body: Obx(
        () => ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (ctx, i) => _buildInviteItem(_controller.listInvite[i]),
          separatorBuilder: (_, __) => const Divider(),
          itemCount: _controller.listInvite.length,
        ),
      ),
    );
  }

  _buildInviteItem(Invitation invite) {
    Icon icon = Icon(
      Ionicons.mail_unread_outline,
      color: Colors.yellow[800],
    );

    switch (invite.status) {
      case "New":
        icon = Icon(
          Ionicons.mail_unread_outline,
          color: Colors.yellow[800],
        );
        break;
      case "Accepted":
        icon = const Icon(
          Ionicons.checkmark_circle_outline,
          color: Colors.green,
        );
        break;
      case "Declined":
        icon = const Icon(
          Ionicons.close_circle_outline,
          color: Colors.red,
        );
        break;
    }
    print(invite.toJson());

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Image.asset("assets/icons/invite.png"),
      ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Text(R.Youhavenewinvite.tr),
      ),
      subtitle: invite.status == "New"
          ? Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () =>
                        _controller.sendInvitationAnswer(invite.id!, false),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                    ),
                    child: Text(R.Decline.tr),
                  ),
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () =>
                        _controller.sendInvitationAnswer(invite.id!, true),
                    child: Text(R.Accept.tr),
                  ),
                )
              ],
            )
          : null,
      trailing: icon,
    );
  }
}
