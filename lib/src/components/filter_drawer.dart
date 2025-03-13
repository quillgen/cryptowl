import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum PasswordFilter { topSecret, secret, confidential, deleted }

const defaultFilters = [
  PasswordFilter.topSecret,
  PasswordFilter.secret,
  PasswordFilter.confidential
];

class PasswordFilterNotifier extends StateNotifier<List<PasswordFilter>> {
  PasswordFilterNotifier() : super(defaultFilters);

  Future<void> select(PasswordFilter option) async {
    state = check(state, option);
  }

  Future<void> clear() async {
    state = [...defaultFilters];
  }

  List<PasswordFilter> check(
      List<PasswordFilter> selected, PasswordFilter option) {
    if (selected.contains(option)) {
      final tmp = List<PasswordFilter>.from(selected);
      tmp.remove(option);
      return [...tmp];
    } else {
      return [option, ...selected];
    }
  }
}

final passwordFilterProvider =
    StateNotifierProvider<PasswordFilterNotifier, List<PasswordFilter>>((ref) {
  return PasswordFilterNotifier();
});

class FilterDrawer extends ConsumerWidget {
  const FilterDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFilters = ref.watch(passwordFilterProvider);
    final filterNotifier = ref.read(passwordFilterProvider.notifier);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
        children: [
          ListTile(
            leading: Icon(Icons.filter_alt),
            title: Text("Filters"),
          ),
          Divider(),
          CheckboxListTile(
            dense: true,
            title: const Text('Top secret'),
            value: selectedFilters.contains(PasswordFilter.topSecret),
            onChanged: (bool? value) {
              filterNotifier.select(PasswordFilter.topSecret);
            },
          ),
          CheckboxListTile(
            dense: true,
            title: const Text('Secret'),
            value: selectedFilters.contains(PasswordFilter.secret),
            onChanged: (bool? value) {
              filterNotifier.select(PasswordFilter.secret);
            },
          ),
          CheckboxListTile(
            dense: true,
            title: const Text('Confidential'),
            //value: filterState.confidential,
            value: selectedFilters.contains(PasswordFilter.confidential),
            onChanged: (bool? value) {
              filterNotifier.select(PasswordFilter.confidential);
            },
          ),
          Divider(),
          CheckboxListTile(
            dense: true,
            title: const Text('Show deleted items'),
            value: selectedFilters.contains(PasswordFilter.deleted),
            onChanged: (bool? value) {
              filterNotifier.select(PasswordFilter.deleted);
            },
          ),
          Divider(),
          TextButton(
              onPressed: () {
                filterNotifier.clear();
              },
              child: Text("Reset filters")),
        ],
      ),
    );
  }
}
