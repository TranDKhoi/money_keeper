import 'package:flutter/material.dart';

import '../../../data/models/transaction.dart';
import '../../core/utils/utils.dart';

class HomeTransactionItem extends StatelessWidget {
  const HomeTransactionItem(
      {Key? key, required this.onTap, required this.transaction})
      : super(key: key);

  final VoidCallback onTap;
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(vertical: 5),
      isThreeLine: true,
      dense: true,
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Image.asset("assets/icons/${transaction.category?.icon}.png"),
      ),
      title: Text(
        transaction.category?.name ?? "Unnamed",
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
      subtitle: Text(
        FormatHelper().dateFormat(transaction.createdAt!),
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
      trailing: Text(
        FormatHelper().moneyFormat(transaction.amount),
        style: TextStyle(
          color: transaction.category!.type == "Income"
              ? Colors.green
              : Colors.redAccent,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
