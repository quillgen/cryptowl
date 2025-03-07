import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';
import 'category_group.dart';
import 'category_item.dart';

class CategoryPage extends ConsumerWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);

    return SingleChildScrollView(
      child: Column(
        children: [
          CategoryItem(
            name: "All items",
            icon: Icons.dashboard,
            category: CATEGORY_ALL_ITEMS,
          ),
          CategoryItem(
            name: "Favorite",
            icon: Icons.favorite,
            category: CATEGORY_FAVORITE,
          ),
          CategoryItem(
            name: "Trash",
            icon: Icons.recycling,
            category: CATEGORY_DELETED,
          ),
          SizedBox(height: 15),
          CategoryGroup(name: "TYPES"),
          SizedBox(height: 15),
          CategoryItem(
            name: "Login",
            icon: Icons.password,
            category: CATEGORY_LOGIN,
          ),
          CategoryItem(
            name: "Card",
            icon: Icons.credit_card,
            category: CATEGORY_CARD,
          ),
          CategoryItem(
            name: "SSH Key",
            icon: Icons.vpn_key,
            category: CATEGORY_SSH_KEY,
          ),
          SizedBox(height: 15),
          CategoryGroup(
            name: "CATEGORIES",
          ),
          SizedBox(height: 15),
          categories.when(
            data: (list) {
              return Column(
                children: [
                  ...list.map((c) {
                    return CategoryItem(
                      name: c.name,
                      icon: Icons.tab,
                      category: c.id!,
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
