import 'dart:async';

import 'package:cryptowl/src/providers/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../main.dart';
import '../domain/password.dart';
import '../pages/password_detail_page.dart';
import 'empty.dart';

class AsyncPasswordsNotifier extends AsyncNotifier<List<PasswordBasic>> {
  @override
  FutureOr<List<PasswordBasic>> build() {
    return ref.read(passwordRepositoryProvider).list();
  }
}

final passwordsProvider =
    AsyncNotifierProvider<AsyncPasswordsNotifier, List<PasswordBasic>>(() {
  return AsyncPasswordsNotifier();
});

enum FilterMenu {
  all,
  favorite,
  deleted,
}

class PasswordListPage extends ConsumerWidget {
  const PasswordListPage({super.key});

  static const String path = '/passwords';
  static const String name = 'Passwords';

  Widget _buildList(BuildContext context, List<PasswordBasic> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (_, index) {
        final item = items[index];
        return ListTile(
          dense: true,
          contentPadding: EdgeInsets.only(left: 10, right: 10),
          leading: const Icon(
            Icons.admin_panel_settings,
          ),
          title: Text(item.title),
          onTap: () {
            context.goNamed(
              PasswordDetailPage.name,
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
    final passwords = ref.watch(passwordsProvider);

    return passwords.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (e, _) {
        logger.severe(e);
        return ErrorWidget(e);
      },
      data: (items) => items.isEmpty ? Empty() : _buildList(context, items),
    );
  }
}
