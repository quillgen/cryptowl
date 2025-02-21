import 'package:cryptowl/main.dart';
import 'package:cryptowl/src/providers.dart';
import 'package:cryptowl/src/screens/components/password_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/password.dart';

part 'passwords.g.dart';

@riverpod
Future<List<Password>> passwords(Ref ref) async {
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
      return repository.listByType(selectedCategory);
    default:
      return repository.listByCategory(selectedCategory);
  }
}

class PasswordList extends ConsumerWidget {
  const PasswordList({super.key});

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
              dense: true,
              contentPadding: EdgeInsets.only(right: 10),
              leading: const Icon(Icons.admin_panel_settings),
              title: Text(items[index].title),
              shape: Border(
                bottom: BorderSide(
                  color: const Color.fromARGB(255, 233, 231, 231),
                ),
              ),
            );
          }),
    );
  }
}
