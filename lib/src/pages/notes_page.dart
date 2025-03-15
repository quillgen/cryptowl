import 'package:cryptowl/src/components/note_list.dart';
import 'package:flutter/material.dart';
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
        title: const Text('Notes'),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: "Menu",
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
            tooltip: "Search",
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
            tooltip: "More operations",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
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
