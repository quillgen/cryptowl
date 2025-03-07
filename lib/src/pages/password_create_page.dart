import 'package:cryptowl/src/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kdbx/kdbx.dart';

import '../components/form_input.dart';

class PasswordCreatePage extends ConsumerStatefulWidget {
  const PasswordCreatePage({super.key});

  static const String path = 'create';
  static const String name = 'Create';

  @override
  ConsumerState<PasswordCreatePage> createState() => _PasswordCreatePageState();
}

const formTextStyle = TextStyle(fontSize: 14);

class _PasswordCreatePageState extends ConsumerState<PasswordCreatePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _usernameController = TextEditingController();
  final _uriController = TextEditingController();
  final _passwordController = TextEditingController();
  final _remarkController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _uriController.dispose();
    _remarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final passwordRepository = ref.read(passwordRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Add item'),
        actions: [
          TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await passwordRepository.create(_titleController.text,
                      ProtectedValue.fromString(_passwordController.text),
                      username: _usernameController.text,
                      url: _uriController.text,
                      remark: _remarkController.text);
                  ref.invalidate(passwordsProvider);
                  if (context.mounted) {
                    context.pop();
                  }
                }
              },
              child: Text("Save"))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              FormInput(
                controller: _titleController,
                name: "Name",
                protected: false,
                required: true,
              ),
              SizedBox(height: 20),
              FormInput(
                controller: _usernameController,
                name: "Username",
                protected: false,
                required: true,
              ),
              FormInput(
                controller: _passwordController,
                name: "Password",
                protected: true,
                required: true,
              ),
              SizedBox(height: 20),
              FormInput(
                controller: _uriController,
                name: "URI",
                protected: false,
                required: false,
              ),
              SizedBox(height: 20),
              FormInput(
                controller: _remarkController,
                name: "Remark",
                protected: false,
                required: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
