import 'package:cryptowl/src/pages/password_edit_page.dart';
import 'package:cryptowl/src/providers/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../main.dart';
import '../components/form_input.dart';
import '../domain/password.dart';

final passwordDetailProvider =
    FutureProvider.autoDispose.family<Password, String>((ref, id) async {
  logger.fine("Fetching password detail for $id");
  return ref.read(passwordRepositoryProvider).findById(id);
});

final DateFormat formatter = DateFormat('yyyy-MM-dd');

enum Menu { copy, show, generate }

class PasswordDetailPage extends ConsumerWidget {
  const PasswordDetailPage({super.key});

  static const String path = '/detail/:id';
  static const String name = 'Password Detail';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = GoRouterState.of(context).pathParameters["id"]!;
    final detailFuture = ref.watch(passwordDetailProvider(id));
    return Scaffold(
      appBar: AppBar(
        title: Text('Password detail'),
        actions: [
          IconButton(
              onPressed: () {
                context.replaceNamed(
                  PasswordEditPage.name,
                  pathParameters: <String, String>{'id': id},
                );
              },
              icon: Icon(Icons.edit_note)),
          IconButton(onPressed: () {}, icon: Icon(Icons.delete_outline)),
        ],
      ),
      body: detailFuture.when(
        data: (password) => Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormInput(
                name: "Name",
                readonly: true,
                value: password.title,
              ),
              SizedBox(height: 20),
              FormInput(
                name: "Username",
                readonly: true,
                value: password.username,
              ),
              FormInput(
                name: "Password",
                readonly: true,
                protected: true,
                value: password.title,
              ),
              SizedBox(height: 20),
              FormInput(
                name: "URI",
                readonly: true,
                value: password.uri,
              ),
              SizedBox(height: 20),
              FormInput(
                name: "Remark",
                readonly: true,
                value: password.remark,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "ID: ${password.id}",
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
              Text(
                "Updated at ${formatter.format(password.lastUpdateTime)}",
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (e, _) => ErrorWidget(e),
      ),
    );
  }
}
