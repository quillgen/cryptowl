import 'dart:convert';

import 'package:fleather/fleather.dart';
import 'package:flutter/widgets.dart';

class FleatherText extends StatelessWidget {
  final String content;

  const FleatherText({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    final document = ParchmentDocument.fromJson(jsonDecode(content));
    final controller = FleatherController(document: document);

    return FleatherField(controller: controller);
  }
}
