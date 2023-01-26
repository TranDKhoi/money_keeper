import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/core/utils/utils.dart';
import 'package:money_keeper/app/routes/routes.dart';
import 'package:money_keeper/data/services/wallet_service.dart';

import '../../../data/models/wallet.dart';
import '../../core/values/r.dart';

class MyWalletController extends GetxController {
  var listWallet = <Wallet>[].obs;
  var categoryGroupList = <Wallet>[].obs;
  var selectedCategoryGroup = Wallet().obs;
  var selectedCategoryPic = Rxn<int>();

  void getAllCategoryGroup() {
    selectedCategoryPic.value = null;
    categoryGroupList.value = [
      Wallet(name: R.Standard.tr, id: -1),
      ...listWallet
    ];
    selectedCategoryGroup.value = categoryGroupList[0];
  }

  Future<void> getAllWallet() async {
    listWallet.value = [];
    EasyLoading.show();
    var res = await WalletService.ins.getAllWallet();
    EasyLoading.dismiss();
    if (res.isOk) {
      for (int i = 0; i < res.data.length; i++) {
        listWallet.add(Wallet.fromJson(res.data[i]));
      }
    }else{
      EasyLoading.showToast(res.message);
    }
  }

  void toEditWallet(Wallet selectedWallet) {
    Get.toNamed(editWalletRoute, arguments: selectedWallet);
  }

  void toAddWallet() {
    Get.toNamed(addWalletRoute);
  }

  void createNewWallet(Wallet wallet) async {
    EasyLoading.show();
    var res = await WalletService.ins.createNewWallet(wallet: wallet);
    if (res.isOk) {
      Get.back();
      getAllWallet();
    } else {
      EasyLoading.showToast(res.message);
    }
    EasyLoading.dismiss();
  }
}
