import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../main.dart';
import '../domain/password.dart';
import '../providers.dart';
import '../components/password_detail.dart';

part 'password_detail_page.g.dart';

@riverpod
Future<Password> passwordDetail(Ref ref, String id) async {
  logger.fine("Fetching password detail for $id");
  return ref.read(passwordRepositoryProvider).findById(id);
}

class PasswordDetailPage extends ConsumerWidget {
  const PasswordDetailPage({super.key});

  static const String path = 'detail/:id';
  static const String name = 'Detail';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = GoRouterState.of(context).pathParameters["id"]!;
    final detailFuture = ref.watch(passwordDetailProvider(id));
    return Scaffold(
      appBar: AppBar(
        title: Text('Password detail'),
      ),
      body: detailFuture.when(
        data: (p) => PasswordDetail(password: p),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (e, _) => ErrorWidget(e),
      ),
    );
  }
}
