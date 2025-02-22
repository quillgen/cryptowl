import 'package:cryptowl/main.dart';
import 'package:cryptowl/src/providers.dart';
import 'package:cryptowl/src/screens/components/password_categories.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/password.dart';

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

@riverpod
class SelectedPassword extends _$SelectedPassword {
  @override
  PasswordBasic? build() {
    return null;
  }

  void setSelectedPassword(PasswordBasic? selected) {
    state = selected;
  }
}

@riverpod
Future<Password?> selectedPasswordDetail(Ref ref) async {
  final p = ref.watch(selectedPasswordProvider);
  if (p == null) {
    return null;
  }
  logger.fine("Fetching password detail for ${p.id}");
  return ref.read(passwordRepositoryProvider).findById(p.id);
}

class PasswordList extends ConsumerWidget {
  const PasswordList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwords = ref.watch(passwordsProvider);
    final selected = ref.watch(selectedPasswordProvider);
    final selectedNotifier = ref.read(selectedPasswordProvider.notifier);
    return passwords.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (e, _) => ErrorWidget(e),
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
                selectedNotifier.setSelectedPassword(item);
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
