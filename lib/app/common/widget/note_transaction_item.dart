import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class NoteTransactionItem extends StatelessWidget {
  const NoteTransactionItem({Key? key, required this.onTap}) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      isThreeLine: true,
      dense: true,
      leading: const Icon(Ionicons.wallet),
      title: const Text(
        "Ún và ăn",
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      subtitle: const Text(
        "this a note",
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      trailing: const Text(
        "100.000 đ",
        style: TextStyle(
          color: Colors.redAccent,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
