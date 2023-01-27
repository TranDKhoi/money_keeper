import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/controllers/wallet/my_wallet_controller.dart';
import 'package:money_keeper/app/core/utils/utils.dart';
import 'package:textfield_tags/textfield_tags.dart';
import '../../../data/models/wallet.dart';
import '../../core/values/r.dart';
import '../category/widgets/category_icon_modal.dart';

class EditWalletGroupScreen extends StatelessWidget {
  EditWalletGroupScreen({Key? key}) : super(key: key);

  final MyWalletController _controller = Get.find();
  final selectedWallet = Get.arguments as Wallet;
  final TextfieldTagsController _tagController = TextfieldTagsController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.editgroupwallet.tr),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          var res = await showModalBottomSheet<int>(
                              context: context,
                              builder: (BuildContext context) =>
                              const IconModalBottomSheet());

                          if (res != null) {
                            _controller.selectedCategoryPic.value = res;
                          }
                        },
                        child: Obx(() {
                          if (_controller.selectedCategoryPic.value != null) {
                            return CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.transparent,
                              child: Image.asset(
                                  "assets/icons/${_controller.selectedCategoryPic.value}.png"),
                            );
                          }
                          if (selectedWallet.icon != null) {
                            return CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.transparent,
                              child: Image.asset(
                                  "assets/icons/${selectedWallet.icon}.png"),
                            );
                          }
                          return const CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.grey,
                          );
                        }),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          initialValue: selectedWallet.name,
                          onChanged: (s) {},
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            hintText: R.Walletname.tr,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Icon(
                        Ionicons.trending_up,
                        size: 30,
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          initialValue: selectedWallet.balance.toString(),
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            hintText: R.Balance.tr,
                            suffix: const Text("VND"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.groups,
                        size: 30,
                      ),
                      const SizedBox(width: 20),
                      Text(R.memberGroup.tr, style: const TextStyle(fontSize: 13),)
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextFieldTags(
                    textfieldTagsController: _tagController,
                    initialTags: ['20521743@gm.uit.edu.vn', '20520594@gm.uit.edu.vn'],
                    inputfieldBuilder: (context, tec, fn, error, onChanged, onSubmitted) {
                      return ((context, sc, tags, onTagDelete) {
                        return TextField(
                          controller: tec,
                          focusNode: fn,
                          decoration: InputDecoration(
                            isDense: true,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.0,
                              ),
                            ),
                            hintText: _tagController.hasTags ? '' : "Enter email...",
                            errorText: error,
                            prefixIcon: tags.isNotEmpty
                                ? SingleChildScrollView(
                              controller: sc,
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: tags.map((String tag) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                      color: Colors.green,
                                    ),
                                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          child: Text(
                                            '#$tag',
                                            style: const TextStyle(color: Colors.white),
                                          ),
                                          onTap: () {
                                            print("$tag selected");
                                          },
                                        ),
                                        const SizedBox(width: 4.0),
                                        InkWell(
                                          child: const Icon(
                                            Icons.cancel,
                                            size: 14.0,
                                            color: Colors.white,
                                          ),
                                          onTap: () {
                                            onTagDelete(tag);
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            )
                                : null,
                          ),
                          onChanged: onChanged,
                          onSubmitted: onSubmitted,
                        );
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          SwitchListTile(
            value: false,
            onChanged: (val) {},
            isThreeLine: true,
            title: Text(R.Notincludeintotalbalance.tr),
            subtitle:
            Text(R.Createanewwalletanddonotincludeitintototalbalance.tr),
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Icon(
                  Ionicons.trash,
                  color: Colors.red,
                ),
                const SizedBox(width: 5),
                Text(
                  R.DELETETHISWALLETFOREVER.tr,
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {},
              child: Text(R.UPDATE.tr),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}