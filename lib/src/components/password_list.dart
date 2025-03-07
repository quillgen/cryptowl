import 'package:cryptowl/main.dart';
import 'package:cryptowl/src/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../pages/password_detail_page.dart';

enum FilterMenu {
  all,
  favorite,
  deleted,
}

class PasswordListPage extends ConsumerWidget {
  const PasswordListPage({super.key});

  static const String path = '/passwords';
  static const String name = 'Passwords';

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
      data: (items) => ListView.builder(
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
      ),
    );
  }
}
