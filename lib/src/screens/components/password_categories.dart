import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/category.dart';
import '../../providers.dart';
import '../passwords.dart';
import 'category_group.dart';
import 'category_item.dart';

part 'password_categories.g.dart';

@riverpod
Future<List<Category>> categories(Ref ref) async {
  return ref.watch(categoryRepositoryProvider).list();
}

class PasswordCategories extends ConsumerWidget {
  const PasswordCategories({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);

    return SingleChildScrollView(
      child: Column(
        children: [
          CategoryItem(
            name: "All items",
            icon: Icons.dashboard,
            count: 10,
          ),
          CategoryItem(
            name: "Favourite",
            icon: Icons.favorite,
            count: 10,
          ),
          CategoryItem(
            name: "Trash",
            icon: Icons.recycling,
            count: 10,
          ),
          SizedBox(height: 15),
          CategoryGroup(name: "TYPES"),
          CategoryItem(
            name: "Login",
            icon: Icons.recycling,
            count: 10,
          ),
          CategoryItem(
            name: "Card",
            icon: Icons.recycling,
            count: 10,
          ),
          CategoryItem(
            name: "SSH Key",
            icon: Icons.recycling,
            count: 10,
          ),
          SizedBox(height: 15),
          CategoryGroup(name: "CATEGORIES"),
          categories.when(
            data: (list) {
              return Column(
                children: [
                  ...list.map((c) {
                    return CategoryItem(
                      name: c.name,
                      icon: Icons.folder_outlined,
                      count: 10,
                    );
                  })
                ],
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (e, _) => ErrorWidget(e),
          ),
        ],
      ),
    );
  }
}
