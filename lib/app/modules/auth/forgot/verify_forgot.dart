import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/controllers/forgot_controller.dart';
import 'package:money_keeper/app/controllers/login_controller.dart';
import 'package:money_keeper/app/core/utils/utils.dart';

class VerifyForgotScreen extends StatefulWidget {
  const VerifyForgotScreen({Key? key}) : super(key: key);

  @override
  State<VerifyForgotScreen> createState() => _VerifyForgotScreenState();
}

class _VerifyForgotScreenState extends State<VerifyForgotScreen> {
  final _controller = Get.put(ForgotPassController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Một mã gồm 6 ký tự đã được gửi đến ${_controller.emailTextController.text}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: VerificationCode(
                digitsOnly: true,
                fullBorder: true,
                itemSize: context.screenSize.width / 8,
                underlineColor: Colors.grey,
                keyboardType: TextInputType.number,
                length: 6,
                onCompleted: (String value) {
                  setState(() {
                    _controller.secureCode = int.parse(value);
                  });
                },
                onEditing: (bool value) {
                  if (!value) FocusScope.of(context).unfocus();
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _controller.verifyCodeFunc();
              },
              child: const Text("XÁC MINH"),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Align(
                alignment: Alignment.topRight,
                child: Text("Không nhận được mã?"),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
