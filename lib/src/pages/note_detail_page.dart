import 'dart:convert';

import 'package:cryptowl/src/providers/notes.dart';
import 'package:cryptowl/src/providers/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../components/error.dart';

class NodeDetailPage extends ConsumerStatefulWidget {
  const NodeDetailPage({super.key});

  static const String path = '/detail/:id';
  static const String name = 'Note Detail';

  @override
  ConsumerState<NodeDetailPage> createState() => _NodeDetailPageState();
}

class _NodeDetailPageState extends ConsumerState<NodeDetailPage> {
  final QuillController _controller = QuillController.basic();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final id = GoRouterState.of(context).pathParameters["id"]!;
    final detailFuture = ref.watch(noteDetailProvider(id));

    detailFuture.whenData((d) {
      _controller.document = Document.fromJson(jsonDecode(d.content));
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('View Note'),
        actions: [
          TextButton(
              onPressed: () async {
                await ref.read(noteServiceProvider).createNote(
                    jsonEncode(_controller.document.toDelta().toJson()),
                    _controller.document.toPlainText());
                ref.invalidate(notesProvider);
                if (context.mounted) {
                  context.pop();
                }
              },
              child: Text("Save"))
        ],
      ),
      body: detailFuture.when(
        data: (note) => Column(
          children: [
            Expanded(
              child: QuillEditor.basic(
                controller: _controller,
                config: const QuillEditorConfig(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    autoFocus: true,
                    placeholder: "Start writing something here"),
              ),
            ),
          ],
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (e, _) => ErrorInfo(e.toString()),
      ),
    );
  }
}
