import 'dart:convert';

import 'package:http/http.dart';
import 'package:money_keeper/app/core/utils/utils.dart';

import '../../app/core/values/strings.dart';
import '../models/user.dart';

class AuthService {
  AuthService._();

  static final ins = AuthService._();

  Future<Response> login({required User user}) async {
    return await post(
      Uri.parse("$api_url/auth/sign-in"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user),
    );
  }

  Future<Response> signUp({required User user}) async {
    return await post(
      Uri.parse("$api_url/auth/sign-up"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user),
    );
  }

  Future<Response> verifyAccount(
      {required String email, required String otp}) async {
    return await post(
      Uri.parse("$api_url/auth/verify-account"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"email": email, "otp": otp}),
    );
  }

  Future<Response> forgotPassword({required String email}) async {
    return await post(
      Uri.parse("$api_url/auth/forgot-password"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(email),
    );
  }

  Future<Response> verifyResetPassword(
      {required String email, required String otp}) async {
    return await post(
      Uri.parse("$api_url/auth/verify-reset-password"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"email": email, "otp": otp}),
    );
  }

  Future<Response> resetPassword(
      {required String email, required String password}) async {
    return await post(
      Uri.parse("$api_url/auth/reset-password"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "email": email,
        "newPassword": password,
        "retypePassword": password
      }),
    );
  }
}
