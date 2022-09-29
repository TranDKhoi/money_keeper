import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class InExItem extends StatelessWidget {
  const InExItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      leading: Icon(Ionicons.wallet),
      title: Text("Ăn và ún nè"),
      subtitle: Text("25/9/2022"),
      trailing: Text("25.000đ"),
    );
  }
}
