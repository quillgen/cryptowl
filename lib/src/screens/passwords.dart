import 'package:cryptowl/src/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/password.dart';

part 'passwords.g.dart';

@riverpod
Future<List<Password>> passwords(Ref ref) async {
  final db = ref.watch(userDatabaseProvider);
  return ref.read(passwordServiceProvider).fetchAll(db);
}

class PasswordListScreen extends ConsumerWidget {
  const PasswordListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwords = ref.watch(passwordsProvider);
    return passwords.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (e, _) => ErrorWidget(e),
      data: (items) => ListView.builder(
          itemCount: items.length,
          itemBuilder: (_, index) {
            return ListTile(
              leading: const Icon(Icons.admin_panel_settings),
              title: Text(items[index].title),
              trailing: Text("5"),
              shape: Border(
                bottom: BorderSide(),
              ),
            );
          }),
    );
  }
}
