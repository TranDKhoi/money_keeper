import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../data/models/event.dart';
import '../../../controllers/planning/event/add_edit_event_controller.dart';
import '../../../core/utils/utils.dart';
import '../../../routes/routes.dart';
import '../../category/widgets/category_icon_modal.dart';

class AddEditEventScreen extends StatelessWidget {
  AddEditEventScreen({Key? key}) : super(key: key);

  final _controller = Get.put(AddEditEventController());
  final Event? selectedEvent = Get.arguments as Event?;

  @override
  Widget build(BuildContext context) {
    if (selectedEvent != null) {
      _controller.setSelectedEditEvent(selectedEvent!);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedEvent == null ? "Addevent".tr : "Editevent".tr),
        actions: [TextButton(onPressed: () {}, child: Text("Save".tr))],
      ),
      /////
      body: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              //event name
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      var res = await showModalBottomSheet<int>(
                          context: context,
                          builder: (BuildContext context) =>
                              const IconModalBottomSheet());

                      if (res != null) {
                        _controller.selectedIcon.value = res;
                      }
                    },
                    child: Obx(
                      () {
                        if (_controller.selectedIcon.value != null) {
                          return CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Image.asset(
                                "assets/icons/${_controller.selectedIcon.value!}.png"),
                          );
                        } else {
                          return const CircleAvatar();
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                      initialValue: _controller.eventName.value,
                      onChanged: (s) => _controller.eventName.value = s,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        hintText: "Eventname".tr,
                        fillColor: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              //end date
              Row(
                children: [
                  const SizedBox(width: 5),
                  const Icon(Ionicons.calendar_outline),
                  const SizedBox(width: 30),
                  GestureDetector(
                    onTap: () async {
                      DateTime? selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030));
                      if (selectedDate != null) {
                        _controller.endDate.value = selectedDate;
                      }
                    },
                    child: Obx(() {
                      if (_controller.endDate.value == null) {
                        return Text(
                          "Enddate".tr,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        );
                      }
                      return Text(
                        FormatHelper().dateFormat(_controller.endDate.value!),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      );
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              //wallet
              Row(
                children: [
                  const SizedBox(width: 5),
                  const Icon(Ionicons.cash),
                  const SizedBox(width: 30),
                  Obx(
                    () => Expanded(
                      child: TextField(
                        enabled: selectedEvent == null ? true : false,
                        onTap: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          var res =
                              await Get.toNamed(myWalletRoute, arguments: true);
                          if (res != null) {
                            _controller.selectedWallet.value = res;
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          hintText:
                              _controller.selectedWallet.value?.name == null
                                  ? "Selectwallet".tr
                                  : _controller.selectedWallet.value!.name,
                          fillColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
