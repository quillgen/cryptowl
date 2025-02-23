import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/category.dart';
import '../../providers.dart';
import '../components/category_group.dart';
import '../components/category_item.dart';

part 'category_page.g.dart';

const CATEGORY_ALL_ITEMS = 0;
const CATEGORY_FAVORITE = -1;
const CATEGORY_DELETED = -2;
const CATEGORY_LOGIN = -11;
const CATEGORY_CARD = -12;
const CATEGORY_SSH_KEY = -13;

@riverpod
Future<List<Category>> categories(Ref ref) async {
  return ref.watch(categoryRepositoryProvider).list();
}

@riverpod
class SelectedCategory extends _$SelectedCategory {
  @override
  int build() {
    return 0;
  }

  void setSelectedCategory(int selected) {
    state = selected;
  }
}

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
