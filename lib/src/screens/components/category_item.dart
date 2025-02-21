import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final int count;

  const CategoryItem(
      {super.key, required this.name, required this.icon, required this.count});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.only(right: 10),
      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
      leading: Icon(icon),
      title: Text(name),
      trailing: Text("$count"),
      onTap: () {},
    );
  }
}
