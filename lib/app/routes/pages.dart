//routes navigation
import 'package:get/get.dart';
import 'package:money_keeper/app/modules/auth/main_auth.dart';
import 'package:money_keeper/app/modules/auth/signup/signup_screen.dart';
import 'package:money_keeper/app/modules/auth/signup/verify_signup.dart';
import 'package:money_keeper/app/modules/bottom_bar/bottom_bar.dart';
import 'package:money_keeper/app/modules/my_wallet/add_wallet.dart';
import 'package:money_keeper/app/modules/my_wallet/edit_wallet.dart';
import 'package:money_keeper/app/modules/my_wallet/my_wallet_screen.dart';
import 'package:money_keeper/app/modules/report/expense_detail.dart';
import 'package:money_keeper/app/routes/routes.dart';

import '../modules/account/setting_screen.dart';
import '../modules/auth/forgot/forgot_pass_screen.dart';
import '../modules/auth/forgot/reset_pass_screen.dart';
import '../modules/auth/login/login_screen.dart';
import '../modules/auth/forgot/verify_forgot.dart';
import '../modules/category/manage_category.dart';
import '../modules/report/income_detail.dart';
import '../modules/transaction/add_transaction.dart';
import '../modules/transaction/edit_transaction.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: mainAuthScreenRoute,
      page: () => const MainAuthScreen(),
    ),
    GetPage(
      name: loginScreenRoute,
      page: () => const LoginScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: signUpScreenRoute,
      page: () => const SignupScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: verifySignupRoute,
      page: () => const VerifySignupScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: forgotPassRoute,
      page: () => const ForgotPassScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: verifyForgotRoute,
      page: () => const VerifyForgotScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: resetPassRoute,
      page: () => const ResetPassScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: bottomBarRoute,
      page: () => const BottomBar(),
      transition: Transition.fade,
    ),
    GetPage(
      name: myWalletRoute,
      page: () => MyWalletScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: addWalletRoute,
      page: () => AddWalletScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: editWalletRoute,
      page: () => EditWalletScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: addTransactionRoute,
      page: () => AddTransactionScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: editTransactionRoute,
      page: () => EditTransactionScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: incomeDetailRoute,
      page: () => IncomeDetail(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: expenseDetailRoute,
      page: () => ExpenseDetail(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: settingRoute,
      page: () => SettingScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: manageCategoryRoute,
      page: () => ManageCategoryScreen(),
      transition: Transition.rightToLeft,
    ),
  ];
}
