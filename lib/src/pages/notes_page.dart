import 'package:cryptowl/src/components/note_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'note_create_page.dart';

class NotesPage extends HookConsumerWidget {
  const NotesPage({super.key});

  static const String path = '/notes';
  static const String name = 'Notes';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Notes'),
        leading: null,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
            tooltip: "Search",
          ),
          if (Breakpoints.mediumAndUp.isActive(context))
            IconButton(
              onPressed: () {
                context.goNamed(
                  NoteCreatePage.name,
                );
              },
              icon: Icon(Icons.add),
              tooltip: "Add note",
            ),
        ],
      ),
      floatingActionButton: Breakpoints.mediumAndUp.isActive(context)
          ? null
          : FloatingActionButton(
              heroTag: "note_add",
              onPressed: () {
                context.goNamed(
                  NoteCreatePage.name,
                );
              },
              child: const Icon(Icons.add),
            ),
      body: NoteList(),
    );
  }
}
