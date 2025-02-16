import 'package:cryptowl/main.dart';
import 'package:cryptowl/src/providers.dart';
import 'package:cryptowl/src/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/password.dart';

part 'passwords.g.dart';

@riverpod
Future<List<Password>> passwords(Ref ref) async {
  final db = ref.watch(userDatabaseProvider);
  logger.fine("fetching passwords...");

  return ref.read(passwordServiceProvider).fetchAll(db);
}

class PasswordListScreen extends ConsumerWidget {
  const PasswordListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwords = ref.watch(passwordsProvider);
    return passwords.when(
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => ErrorWidget(e),
      data: (items) => ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Container(
            height: 50,
            color: Colors.amber[600],
            child: const Center(child: Text('Entry A')),
          ),
          Container(
            height: 50,
            color: Colors.amber[500],
            child: const Center(child: Text('Entry B')),
          ),
          Container(
            height: 50,
            color: Colors.amber[100],
            child: const Center(child: Text('Entry C')),
          ),
        ],
      ),
    );
  }
}
