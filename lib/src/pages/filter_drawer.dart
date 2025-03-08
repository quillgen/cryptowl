import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

class FilterDrawer extends ConsumerWidget {
  const FilterDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterState = ref.watch(classificationFiltersProvider);
    final filterNotifier = ref.read(classificationFiltersProvider.notifier);

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
            value: filterState.topSecret,
            onChanged: (bool? value) {
              filterNotifier.checkTopSecret(value ?? false);
            },
          ),
          CheckboxListTile(
            dense: true,
            title: const Text('Secret'),
            value: filterState.secret,
            onChanged: (bool? value) {
              filterNotifier.checkSecret(value ?? false);
            },
          ),
          CheckboxListTile(
            dense: true,
            title: const Text('Confidential'),
            value: filterState.confidential,
            onChanged: (bool? value) {
              filterNotifier.checkConfidential(value ?? false);
            },
          ),
          Divider(),
          CheckboxListTile(
            dense: true,
            title: const Text('Show deleted items'),
            value: filterState.includeDeleted,
            onChanged: (bool? value) {
              filterNotifier.checkIncludeDeleted(value ?? false);
            },
          ),
          Divider(),
          TextButton(
              onPressed: () {
                filterNotifier.clearFilters();
              },
              child: Text("Clear filters")),
        ],
      ),
    );
  }
}
