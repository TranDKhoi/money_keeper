import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/controllers/auth/forgot_controller.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
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
            const Text(
              "Nhập địa chỉ email mà bạn muốn khôi phục mật khẩu",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller.emailTextController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "Email",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _controller.toVerifyScreen();
              },
              child: const Text("GỬI MÃ"),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
