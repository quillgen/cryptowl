import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../domain/password.dart';

class PasswordDetail extends StatelessWidget {
  final Password password;

  PasswordDetail({super.key, required this.password});
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  Widget _renderDetail() {
    return Column(
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
