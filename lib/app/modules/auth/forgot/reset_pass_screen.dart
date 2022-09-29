import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/controllers/auth/forgot_controller.dart';

class ResetPassScreen extends StatefulWidget {
  const ResetPassScreen({Key? key}) : super(key: key);

  @override
  State<ResetPassScreen> createState() => _ResetPassScreenState();
}

class _ResetPassScreenState extends State<ResetPassScreen> {

  final _controller = Get.put(ForgotPassController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Resetpassword".tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => TextField(
                controller: _controller.passTextController,
                keyboardType: TextInputType.emailAddress,
                obscureText: _controller.isSecureText.value,
                decoration: InputDecoration(
                  hintText: "Newpassword".tr,
                  suffixIcon: GestureDetector(
                    onTap: _controller.changeSecureText,
                    child: Obx(
                      () => Icon(
                        _controller.isSecureText.value
                            ? Ionicons.eye
                            : Ionicons.eye_off,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Obx(
                  () => TextField(
                controller: _controller.rePassTextController,
                keyboardType: TextInputType.emailAddress,
                obscureText: _controller.isSecureText.value,
                decoration: InputDecoration(
                  hintText: "Confirmpassword".tr,
                  suffixIcon: GestureDetector(
                    onTap: _controller.changeSecureText,
                    child: Obx(
                          () => Icon(
                        _controller.isSecureText.value
                            ? Ionicons.eye
                            : Ionicons.eye_off,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _controller.setNewPassFunc();
              },
              child: Text("CONFIRM".tr),
            ),
          ],
        ),
      ),
    );
  }
}
