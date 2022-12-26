import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../data/models/event.dart';
import '../../../core/utils/utils.dart';
import '../../../routes/routes.dart';

class EventInfoScreen extends StatefulWidget {
  EventInfoScreen({Key? key}) : super(key: key);

  @override
  State<EventInfoScreen> createState() => _EventInfoScreenState();
}

class _EventInfoScreenState extends State<EventInfoScreen> {
  final selectedEvent = Get.arguments as Event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              GestureDetector(
                  onTap: () => Get.toNamed(addEventScreenRoute,
                      arguments: selectedEvent),
                  child: const Icon(Ionicons.pencil)),
              const SizedBox(width: 20),
              const Icon(Ionicons.trash),
              const SizedBox(width: 20),
            ],
          )
        ],
      ),
      //////////
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            //name and icon
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.transparent,
                  child: Image.asset("assets/icons/${selectedEvent.icon}.png"),
                ),
                const SizedBox(width: 10),
                Text(
                  selectedEvent.name!,
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            //end date
            Row(
              children: [
                const SizedBox(width: 10),
                const Icon(
                  Ionicons.calendar_outline,
                ),
                const SizedBox(width: 25),
                Text(
                  "${"Enddate".tr}: ",
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  FormatHelper().dateFormat(selectedEvent.endDate!),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(width: 25),
              ],
            ),
            const SizedBox(height: 20),
            //wallet
            Row(
              children: [
                const SizedBox(width: 10),
                const Icon(
                  Ionicons.wallet_outline,
                ),
                const SizedBox(width: 25),
                Text(
                  selectedEvent.wallet!.name!,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(width: 25),
              ],
            ),
            const SizedBox(height: 20),
            //button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () => setState(() {
                          selectedEvent.isFinished = !selectedEvent.isFinished!;
                        }),
                    child: Text(selectedEvent.isFinished!
                        ? "Markasunfinished".tr
                        : "Markasfinished".tr)),
                const Spacer(),
                ElevatedButton(
                    onPressed: () {}, child: Text("Listoftransaction".tr)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
