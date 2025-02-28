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
              TextFormField(
                style: TextStyle(fontSize: 14),
                key: Key("password.${password.id}.id"),
                readOnly: true,
                initialValue: password.id,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: "ID",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                key: Key("password.${password.id}.title"),
                style: TextStyle(fontSize: 14),
                readOnly: true,
                initialValue: password.title,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: "TITLE",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                key: Key("password.${password.id}.value"),
                style: TextStyle(fontSize: 14),
                readOnly: true,
                initialValue: password.value.toString(),
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "PASSWORD",
                  suffixIcon: PopupMenuButton<Menu>(
                    icon: const Icon(Icons.more_vert),
                    onSelected: (Menu item) {},
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<Menu>>[
                      const PopupMenuItem<Menu>(
                        value: Menu.copy,
                        child: ListTile(
                          leading: Icon(Icons.copy),
                          title: Text('Copy'),
                        ),
                      ),
                      const PopupMenuItem<Menu>(
                        value: Menu.show,
                        child: ListTile(
                          leading: Icon(Icons.remove_red_eye),
                          title: Text('Show'),
                        ),
                      ),
                      const PopupMenuItem<Menu>(
                        value: Menu.generate,
                        child: ListTile(
                          leading: Icon(Icons.change_circle),
                          title: Text('Generate'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Created at: ${formatter.format(password.createTime)}"),
              Text("Updated at: ${formatter.format(password.lastUpdateTime)}"),
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
