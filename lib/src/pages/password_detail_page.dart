import 'package:cryptowl/src/components/form_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../main.dart';
import '../domain/password.dart';
import '../providers.dart';

part 'password_detail_page.g.dart';

@riverpod
Future<Password> passwordDetail(Ref ref, String id) async {
  logger.fine("Fetching password detail for $id");
  return ref.read(passwordRepositoryProvider).findById(id);
}

final DateFormat formatter = DateFormat('yyyy-MM-dd');

enum Menu { copy, show, generate }

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
                value: "",
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
                value: "",
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
