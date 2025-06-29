import 'package:cryptowl/src/providers/notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../components/error.dart';
import '../components/fleather_text.dart';

class NodeDetailPage extends ConsumerStatefulWidget {
  const NodeDetailPage({super.key});

  static const String path = '/detail/:id';
  static const String name = 'Note Detail';

  @override
  ConsumerState<NodeDetailPage> createState() => _NodeDetailPageState();
}

class _NodeDetailPageState extends ConsumerState<NodeDetailPage> {
  @override
  Widget build(BuildContext context) {
    final id = GoRouterState.of(context).pathParameters["id"]!;
    final detailFuture = ref.watch(noteDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('View Note'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
            tooltip: "More operations",
          )
        ],
      ),
      body: detailFuture.when(
        data: (note) => Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsetsGeometry.all(4),
                child: FleatherText(content: note.content),
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
