import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../main.dart';
import '../domain/password.dart';
import '../pages/password_create_page.dart';
import '../pages/password_detail_page.dart';
import '../providers/providers.dart';
import 'empty.dart';

enum FilterMenu {
  all,
  favorite,
  deleted,
}

class PasswordList extends HookConsumerWidget {
  const PasswordList({super.key});

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
      data: (items) => items.isEmpty
          ? Empty()
          : RefreshIndicator(
              child: _buildList(context, items),
              onRefresh: () async {
                ref.invalidate(passwordsProvider);
              }),
    );
  }

  Widget _buildList(BuildContext context, List<PasswordBasic> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (_, index) {
        final item = items[index];
        return ListTile(
          dense: true,
          contentPadding: EdgeInsets.only(left: 10, right: 10),
          leading: ClassificationLabel.from(item.classification).icon,
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
}
