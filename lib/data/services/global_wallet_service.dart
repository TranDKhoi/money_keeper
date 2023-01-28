import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/controllers/account/account_controller.dart';
import '../../app/core/values/strings.dart';

class GlobalWalletService extends GetConnect {
  final AccountController _ac = Get.find();

  static final GlobalWalletService ins = GlobalWalletService._();

  GlobalWalletService._() {
    timeout = const Duration(seconds: 10);
  }

  Future<Response> getRecentlyTrans() async {
    return await get("$api_url/global-wallets/transactions/recently?Take=5",
        headers: <String, String>{
          'Authorization': _ac.currentUser.value!.token!,
        });
  }

  Future<Response> getExpenseReportByMonth(DateTime time) async {
    return await get("$api_url/global-wallets/expense", query: <String, String>{
      "StartDate": "${time.year}-${time.month}-1",
      "EndDate":
          "${time.year}-${time.month}-${DateUtils.getDaysInMonth(time.year, time.month)}",
    }, headers: <String, String>{
      'Authorization': _ac.currentUser.value!.token!,
    });
  }

  // Future<Response> getExpenseReportByWeek() async {
  //   return await get("$api_url/global-wallets/expense", query: <String, String>{
  //     "StartDate": _getStartWeek(),
  //     "EndDate": _getEndWeek(),
  //   }, headers: <String, String>{
  //     'Authorization': _ac.currentUser.value!.token!,
  //   });
  // }
}
