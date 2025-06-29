import 'package:cryptowl/src/domain/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';

import '../../main.dart';
import '../pages/note_detail_page.dart';
import '../providers/providers.dart';
import 'empty.dart';

enum FilterMenu {
  all,
  favorite,
  deleted,
}

class NoteList extends ConsumerWidget {
  const NoteList({super.key});

  Widget _buildList(BuildContext context, List<NoteBasic> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (_, index) {
        final item = items[index];
        return ListTile(
          dense: true,
          contentPadding: EdgeInsets.only(left: 10, right: 10),
          trailing:
              IconButton(onPressed: () {}, icon: Icon(RemixIcons.more_line)),
          titleAlignment: ListTileTitleAlignment.top,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.abstract,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text("6月18日")
            ],
          ),
          onTap: () {
            context.goNamed(
              NodeDetailPage.name,
              pathParameters: <String, String>{'id': item.id},
            );
          },
          shape: Border(
            bottom: BorderSide(
              color: const Color.fromARGB(255, 233, 231, 231),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(notesProvider);

    return notes.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (e, _) {
        logger.severe(e);
        return ErrorWidget(e);
      },
      data: (items) => items.isEmpty
          ? Empty()
          : RefreshIndicator(
              child: _buildList(context, items),
              onRefresh: () async {
                ref.invalidate(notesProvider);
              }),
    );
  }
}
