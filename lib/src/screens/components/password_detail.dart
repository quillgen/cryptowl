import 'package:cryptowl/main.dart';
import 'package:cryptowl/src/screens/components/passwords.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../domain/password.dart';

class PasswordDetailPage extends StatelessWidget {
  final Password password;

  PasswordDetailPage({super.key, required this.password});
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  Widget _renderActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          tooltip: "Edit",
          onPressed: () {},
          icon: Icon(Icons.edit),
        ),
        IconButton(
          tooltip: "Move to trash",
          onPressed: () {},
          icon: Icon(Icons.delete),
        ),
        IconButton(
          tooltip: "Send",
          onPressed: () {},
          icon: Icon(Icons.forward),
        ),
        IconButton(
          tooltip: "Close",
          onPressed: () {},
          icon: Icon(Icons.close),
        ),
      ],
    );
  }

  Widget _renderDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _renderActions(),
        SizedBox(
          height: 20,
        ),
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
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text("Created at: ${formatter.format(password.createTime)}"),
        Text("Updated at: ${formatter.format(password.lastUpdateTime)}"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: _renderDetail(),
    );
  }
}

class PasswordDetail extends ConsumerWidget {
  const PasswordDetail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedState = ref.watch(selectedPasswordDetailProvider);

    return selectedState.when(
      data: (password) => password == null
          ? Container()
          : PasswordDetailPage(
              password: password,
            ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (e, _) => ErrorWidget(e),
    );
  }
}
