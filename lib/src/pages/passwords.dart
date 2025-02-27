import 'package:cryptowl/main.dart';
import 'package:cryptowl/src/providers.dart';
import 'package:cryptowl/src/screens/pages/category_page.dart';
import 'package:cryptowl/src/screens/pages/detail_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/password.dart';

part 'passwords.g.dart';

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

class PasswordList extends ConsumerWidget {
  const PasswordList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwords = ref.watch(passwordsProvider);
    final selected = ref.watch(selectedPasswordProvider);
    final detailPanelNotifier = ref.read(detailPanelStateProvider.notifier);
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
            final isSelected = selected?.id == item.id;
            return ListTile(
              dense: true,
              contentPadding: EdgeInsets.only(right: 10),
              leading: const Icon(Icons.admin_panel_settings),
              title: Text(item.title),
              onTap: () {
                //detailPanelNotifier.setViewMode(item);
                context.push("/passwords/${item.id}");
              },
              tileColor: isSelected ? Theme.of(context).highlightColor : null,
              shape: Border(
                left: isSelected
                    ? BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 5,
                      )
                    : BorderSide.none,
                bottom: BorderSide(
                  color: const Color.fromARGB(255, 233, 231, 231),
                ),
              ),
            );
          }),
    );
  }
}

/// The home page.
class PasswordsPage extends StatelessWidget {
  /// Construct the home page.
  const PasswordsPage({super.key});

  /// The path for the home page.
  static const String path = '/passwords';

  /// The name for the home page.
  static const String name = 'Passwords';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Passwords Page'),
      ),
      body: PasswordList(),
    );
  }
}
