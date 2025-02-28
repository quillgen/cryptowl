import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'password_detail_page.dart';

class PasswordEditPage extends ConsumerWidget {
  const PasswordEditPage({super.key});

  static const String path = 'edit/:id';
  static const String name = 'Edit';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = GoRouterState.of(context).pathParameters["id"]!;
    final detailFuture = ref.watch(passwordDetailProvider(id));
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit password'),
      ),
      body: detailFuture.when(
        data: (p) => Padding(
          padding: EdgeInsets.all(12),
          child: Text("test"),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (e, _) => ErrorWidget(e),
      ),
    );
  }
}
