import 'package:cryptowl/main.dart';
import 'package:cryptowl/src/pages/category_page.dart';
import 'package:cryptowl/src/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/password.dart';
import 'drawer_menu.dart';
import 'password_create_page.dart';
import 'password_detail_page.dart';

part 'password_list_page.g.dart';

@riverpod
Future<List<PasswordBasic>> passwords(Ref ref) async {
  final selectedCategory = ref.watch(selectedCategoryProvider);
  final repository = ref.read(passwordRepositoryProvider);
  logger.fine("Fetching passwords with category=$selectedCategory");
  switch (selectedCategory) {
    case CATEGORY_ALL_ITEMS:
      return repository.list();
    case CATEGORY_FAVORITE:
      return repository.listFavorite();
    case CATEGORY_DELETED:
      return repository.listDeleted();
    case CATEGORY_LOGIN:
    case CATEGORY_CARD:
    case CATEGORY_SSH_KEY:
      {
        final type = -(10 + selectedCategory);
        return repository.listByType(type);
      }
    default:
      return repository.listByCategory(selectedCategory);
  }
}

class PasswordListPage extends ConsumerWidget {
  const PasswordListPage({super.key});

  static const String path = '/passwords';
  static const String name = 'Passwords';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwords = ref.watch(passwordsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Passwords'),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: DrawerMenu(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed(
            PasswordCreatePage.name,
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: passwords.when(
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
                contentPadding: EdgeInsets.only(right: 10),
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
        ),
      ),
    );
  }
}
