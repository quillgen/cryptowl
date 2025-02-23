import 'package:cryptowl/main.dart';
import 'package:cryptowl/src/screens/pages/detail_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kdbx/kdbx.dart';

class PasswordCreatePage extends ConsumerStatefulWidget {
  const PasswordCreatePage({super.key});

  @override
  ConsumerState<PasswordCreatePage> createState() => _PasswordCreatePageState();
}

class _PasswordCreatePageState extends ConsumerState<PasswordCreatePage> {
  final _titleController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> onCreate() async {
    logger.fine("Creating new password");
    await ref.read(detailPanelStateProvider.notifier).createPassword(
          _titleController.text,
          ProtectedValue.fromString(_passwordController.text),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          TextFormField(
            controller: _titleController,
            style: TextStyle(fontSize: 14),
            decoration:
                InputDecoration(labelText: "TITLE", hintText: "Password title"),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "PASSWORD",
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "CONFIRM PASSWORD",
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          TextButton(
            onPressed: onCreate,
            child: Text('Create'),
          )
        ],
      ),
    );
  }
}
