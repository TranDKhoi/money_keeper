//routes navigation
import 'package:get/get.dart';
import 'package:money_keeper/app/modules/auth/main_auth.dart';
import 'package:money_keeper/app/modules/auth/signup/signup_screen.dart';
import 'package:money_keeper/app/modules/auth/signup/verify_signup.dart';
import 'package:money_keeper/app/routes/routes.dart';

import '../modules/auth/forgot/forgot_pass_screen.dart';
import '../modules/auth/forgot/reset_pass_screen.dart';
import '../modules/auth/login/login_screen.dart';
import '../modules/auth/forgot/verify_forgot.dart';

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
  ];
}
