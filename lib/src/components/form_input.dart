import 'package:flutter/material.dart';

const formTextStyle = TextStyle(fontSize: 14);

enum Menu { copy, show, generate }

class FormInput extends StatelessWidget {
  final String name;
  final bool protected;
  final bool required;
  final bool readonly;
  final TextEditingController? controller;
  final String? value;

  const FormInput(
      {super.key,
      this.controller,
      required this.name,
      this.value,
      this.protected = false,
      this.required = false,
      this.readonly = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: formTextStyle,
      controller: controller,
      obscureText: protected,
      readOnly: readonly,
      initialValue: value,
      decoration: InputDecoration(
        prefixIcon: Icon(protected ? Icons.shield : Icons.abc),
        labelText: name,
        labelStyle: formTextStyle,
        suffixIcon: protected
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.remove_red_eye)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.lock_reset)),
                  PopupMenuButton<Menu>(
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
                  )
                ],
              )
            : null,
      ),
      validator: (value) {
        if (required && (value == null || value.isEmpty)) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }
}
