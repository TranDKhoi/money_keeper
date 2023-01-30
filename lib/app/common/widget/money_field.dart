import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MoneyField extends StatelessWidget {
  const MoneyField({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(
        fontSize: 30,
        color: Colors.green,
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        CurrencyTextInputFormatter(locale: 'vi', decimalDigits: 0, symbol: "đ"),
      ],
      decoration: const InputDecoration(
        hintText: "VND",
        hintStyle: TextStyle(
          color: Colors.green,
        ),
        fillColor: Colors.transparent,
      ),
    );
  }
}
