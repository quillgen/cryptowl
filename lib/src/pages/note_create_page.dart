import 'dart:convert';

import 'package:cryptowl/src/providers/notes.dart';
import 'package:cryptowl/src/providers/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NoteCreatePage extends ConsumerStatefulWidget {
  const NoteCreatePage({super.key});

  static const String path = '/create';
  static const String name = 'Note Create';

  @override
  ConsumerState<NoteCreatePage> createState() => _NoteCreatePageState();
}

class _NoteCreatePageState extends ConsumerState<NoteCreatePage> {
  final QuillController _controller = QuillController.basic();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Add item'),
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
      body: Column(
        children: [
          QuillSimpleToolbar(
            controller: _controller,
            config: const QuillSimpleToolbarConfig(
              showFontFamily: false,
              showFontSize: false,
              showIndent: false,
              showInlineCode: false,
              showLink: false,
              showSearchButton: false,
              showSubscript: false,
              showSuperscript: false,
            ),
          ),
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
    );
  }
}
