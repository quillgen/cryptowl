import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

class CustomLeading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(RemixIcons.arrow_left_line),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}
