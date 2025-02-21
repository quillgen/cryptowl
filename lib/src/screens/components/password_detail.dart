import 'package:cryptowl/main.dart';
import 'package:cryptowl/src/screens/components/passwords.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordDetail extends ConsumerWidget {
  const PasswordDetail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final password = ref.watch(selectedPasswordProvider);
    logger.fine("Selected password changed: ${password?.id}");
    if (password == null) {
      return Container();
    }
    return Column(
      children: [
        TextFormField(
          style: TextStyle(fontSize: 14),
          key: Key(password.id),
          readOnly: true,
          initialValue: password.id,
          obscureText: false,
          decoration: InputDecoration(
            labelText: "ID",
          ),
        ),
        TextFormField(
          key: Key(password.id + password.title),
          style: TextStyle(fontSize: 14),
          readOnly: true,
          initialValue: password.title,
          obscureText: false,
          decoration: InputDecoration(
            labelText: "TITLE",
          ),
        ),
      ],
    );
  }
}
