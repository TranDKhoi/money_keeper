import 'package:flutter/material.dart';

import 'note_transaction_item.dart';

class CardTransactionItem extends StatelessWidget {
  CardTransactionItem({Key? key, required this.onTap}) : super(key: key);

  final VoidCallback onTap;
  final List<Widget> listTransaction = [
    NoteTransactionItem(onTap: () {}),
    NoteTransactionItem(onTap: () {}),
    NoteTransactionItem(onTap: () {}),
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const ListTile(
              contentPadding: EdgeInsets.zero,
              isThreeLine: true,
              leading: Text(
                "29",
                style: TextStyle(fontSize: 30),
              ),
              title: Text("Hôm nay"),
              subtitle: Text("9/2022"),
              trailing: Text(
                "100.000đ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(),
            ...listTransaction,
          ],
        ),
      ),
    );
  }
}
