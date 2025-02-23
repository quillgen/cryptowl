import 'package:cryptowl/src/screens/pages/passwords.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordCreatePage extends ConsumerWidget {
  const PasswordCreatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedState = ref.watch(selectedPasswordDetailProvider);

    return selectedState.when(
      data: (password) => password == null ? Container() : Text("Add"),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (e, _) => ErrorWidget(e),
    );
  }
}
