import 'package:flutter/material.dart';

import '../../my_icons_icons.dart';

class CategoryGroup extends StatelessWidget {
  final String name;

  const CategoryGroup({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: [
          Icon(
            MyIcons.chevron_right,
            size: 12,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              name,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
      onTap: () {},
    );
  }
}
