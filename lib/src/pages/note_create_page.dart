import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NoteCreatePage extends HookConsumerWidget {
  const NoteCreatePage({super.key});

  static const String path = '/create';
  static const String name = 'Note Create';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Add item'),
        actions: [TextButton(onPressed: () async {}, child: Text("Save"))],
      ),
      body: Center(child: Text("Ok")),
    );
  }
}
