import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/core/utils/utils.dart';
import 'package:money_keeper/data/models/wallet.dart';
import 'package:textfield_tags/textfield_tags.dart';
import '../../controllers/wallet/my_wallet_controller.dart';
import '../../core/values/r.dart';
import '../category/widgets/category_icon_modal.dart';

class AddWalletGroup extends StatefulWidget {
  final MyWalletController controller;
  final TextEditingController textWalletName;
  final TextEditingController textWalletBalance;

  const AddWalletGroup({
    Key? key,
    required this.controller,
    required this.textWalletName,
    required this.textWalletBalance,
  }) : super(key: key);

  @override
  State<AddWalletGroup> createState() => _AddWalletGroupState();
}

class _AddWalletGroupState extends State<AddWalletGroup> {
  final TextfieldTagsController _tagController = TextfieldTagsController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //wallet name and icon
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        var res = await showModalBottomSheet<int>(context: context, builder: (BuildContext context) => const IconModalBottomSheet());

                        if (res != null) {
                          widget.controller.selectedCategoryPic.value = res;
                        }
                      },
                      child: Obx(() {
                        if ( widget.controller.selectedCategoryPic.value != null) {
                          return CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.transparent,
                            child: Image.asset("assets/icons/${ widget.controller.selectedCategoryPic.value}.png"),
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
                      child: TextField(
                        controller: widget.textWalletName,
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
                //wallet balance
                Row(
                  children: [
                    const Icon(
                      Ionicons.trending_up,
                      size: 30,
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        controller: widget.textWalletBalance,
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
                const SizedBox(height: 20),
                //wallet category list
                Row(
                  children: [
                    const Icon(
                      Ionicons.list_outline,
                      size: 30,
                    ),
                    const SizedBox(width: 20),
                    Obx(
                      () => DropdownButton<Wallet>(
                        value: widget.controller.selectedCategoryGroup.value,
                        items: widget.controller.categoryGroupList.map((Wallet value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(
                              "  ${value.name!}",
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          widget.controller.selectedCategoryGroup.value = val!;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Get.dialog(
                          Center(
                            child: SizedBox(
                              width: 300,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    R.instructionofcategorylist.tr,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: const Icon(
                        Ionicons.information_circle_outline,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                //wallet category list
                Row(
                  children: [
                    const Icon(
                      Icons.groups,
                      size: 30,
                    ),
                    const SizedBox(width: 20),
                    Text(R.Addmembers.tr, style: const TextStyle(fontSize: 13),)
                  ],
                ),
                const SizedBox(height: 5),
                TextFieldTags(
                  textfieldTagsController: _tagController,
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
                          prefixIconConstraints: BoxConstraints(maxWidth: context.screenSize.width * 0.74),
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
        //include in total
        SwitchListTile(
          value: false,
          onChanged: (val) {},
          isThreeLine: true,
          title: Text(R.Notincludeintotalbalance.tr),
          subtitle: Text(R.Createanewwalletanddonotincludeitintototalbalance.tr),
        ),
        const Spacer(),
        //add new Button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
            onPressed: _createNewWallet,
            child: Text(R.ADDNEW.tr),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  _createNewWallet() {
    // if (textWalletBalance.text.isEmpty || textWalletName.text.isEmpty || _controller.selectedCategoryPic.value == null) {
    //   EasyLoading.showToast(R.Pleaseenteralltheinformation.tr);
    //   return;
    // }
    // final newWallet = Wallet(
    //   balance: int.parse(textWalletBalance.text),
    //   name: textWalletName.text.trim(),
    //   type: "Personal",
    //   icon: _controller.selectedCategoryPic.value.toString(),
    // );
    //
    // if (_controller.selectedCategoryGroup.value.id != -1) {
    //   newWallet.clonedCategoryWalletId = _controller.selectedCategoryGroup.value.id;
    // }
    //
    // _controller.createNewWallet(newWallet);
  }
}
