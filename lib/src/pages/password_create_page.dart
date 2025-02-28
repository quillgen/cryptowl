import 'package:cryptowl/src/pages/password_list_page.dart';
import 'package:cryptowl/src/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kdbx/kdbx.dart';

class PasswordCreatePage extends ConsumerStatefulWidget {
  const PasswordCreatePage({super.key});

  static const String path = 'create';
  static const String name = 'Create';

  @override
  ConsumerState<PasswordCreatePage> createState() => _PasswordCreatePageState();
}

class _PasswordCreatePageState extends ConsumerState<PasswordCreatePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final passwordRepository = ref.read(passwordRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Create password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                style: TextStyle(fontSize: 14),
                controller: _titleController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: "TITLE",
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
                style: TextStyle(fontSize: 14),
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await passwordRepository.create(_titleController.text,
                        ProtectedValue.fromString(_passwordController.text));
                    ref.invalidate(passwordsProvider);
                    if (context.mounted) {
                      context.pop();
                    }
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
