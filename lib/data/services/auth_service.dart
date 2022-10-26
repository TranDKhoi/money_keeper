import 'dart:convert';

import 'package:get/get_connect/connect.dart';

import '../../app/core/values/strings.dart';
import '../models/user.dart';

class AuthService extends GetConnect {
  AuthService._();

  static final ins = AuthService._();

  Future<Response> login({required User user}) async {
    return await post(
      "$api_url/auth/sign-in", jsonEncode(user),
    );
  }

  Future<Response> signUp({required User user}) async {
    return await post(
      "$api_url/auth/sign-up",
      jsonEncode(user),
    );
  }

  Future<Response> verifyAccount(
      {required String email, required String otp}) async {
    return await post(
      "$api_url/auth/verify-account",
      jsonEncode({"email": email, "otp": otp}),
    );
  }

  Future<Response> forgotPassword({required String email}) async {
    return await post(
      "$api_url/auth/forgot-password",
      jsonEncode(email),
    );
  }

  Future<Response> verifyResetPassword(
      {required String email, required String otp}) async {
    return await post(
      "$api_url/auth/verify-reset-password",
      jsonEncode({"email": email, "otp": otp}),
    );
  }

  Future<Response> resetPassword(
      {required String email, required String password}) async {
    return await post(
      "$api_url/auth/reset-password",
      jsonEncode({
        "email": email,
        "newPassword": password,
        "retypePassword": password
      }),
    );
  }
}
