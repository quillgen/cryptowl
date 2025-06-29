import 'package:cryptowl/src/components/note_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remixicon/remixicon.dart';

import '../localization/app_localizations.dart';
import 'note_create_page.dart';

class NotesPage extends HookConsumerWidget {
  const NotesPage({super.key});

  static const String path = '/notes';
  static const String name = 'Notes';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLarge = Breakpoints.mediumAndUp.isActive(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppLocalizations.of(context)!.notes),
        leading: isLarge
            ? null
            : IconButton(
                onPressed: () {},
                icon: Icon(RemixIcons.menu_line),
                tooltip: "Menu",
              ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(RemixIcons.filter_line),
            tooltip: "Filter",
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(RemixIcons.search_line),
            tooltip: "Search",
          ),
          if (isLarge)
            IconButton(
              onPressed: () {
                context.goNamed(
                  NoteCreatePage.name,
                );
              },
              icon: Icon(RemixIcons.add_circle_line),
              tooltip: AppLocalizations.of(context)!.createNote,
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
              child: const Icon(RemixIcons.add_line),
            ),
      body: NoteList(),
    );
  }
}
