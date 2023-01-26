import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';

import '../../app/core/values/strings.dart';
import '../models/user.dart';

class AuthService extends GetConnect {
  AuthService._();

  static final ins = AuthService._();

  Future<Response> login({required User user}) async {
    return await post(
      "$api_url/auth/login",
      jsonEncode(user),
    );
  }

  Future<Response> signUp({required User user}) async {
    return await post(
      "$api_url/auth/register",
      jsonEncode(user),
    );
  }

  Future<Response> verifyAccount(
      {required String email, required String code}) async {
    return await post(
      "$api_url/auth/verify-account",
      jsonEncode({"email": email, "code": code}),
    );
  }

  Future<Response> forgotPassword({required String email}) async {
    return await post(
      "$api_url/auth/forgot-password",
      jsonEncode({"email": email}),
    );
  }

  Future<Response> verifyResetPassword(
      {required String email, required String code}) async {
    return await post(
      "$api_url/auth/verify-code-repassword",
      jsonEncode({"email": email, "code": code}),
    );
  }

  Future<Response> resetPassword(
      {required String token, required String password}) async {
    return await post(
      "$api_url/auth/reset-password",
      jsonEncode({"token": token, "password": password}),
    );
  }

  Future<Response> updateAvatar(String avatar, String s) async {
    return await put("$api_url/account/info", jsonEncode({"avatar": avatar}),
        headers: <String, String>{
          "Authorization": s,
        });
  }
}
