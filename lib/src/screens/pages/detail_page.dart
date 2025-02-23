import 'package:cryptowl/src/screens/pages/passwords.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/empty.dart';
import '../components/password_detail.dart';

class DetailPage extends ConsumerWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedState = ref.watch(selectedPasswordDetailProvider);

    return selectedState.when(
      data: (password) => password == null
          ? Empty()
          : PasswordDetail(
              password: password,
            ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (e, _) => ErrorWidget(e),
    );
  }
}
