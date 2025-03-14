import 'dart:collection';

import 'package:cryptowl/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kdbx/kdbx.dart';

import '../components/dropdown_formfield.dart';
import '../components/form_input.dart';
import '../domain/password.dart';

class PasswordCreatePage extends ConsumerStatefulWidget {
  const PasswordCreatePage({super.key});

  static const String path = '/create';
  static const String name = 'Password Create';

  @override
  ConsumerState<PasswordCreatePage> createState() => _PasswordCreatePageState();
}

const formTextStyle = TextStyle(fontSize: 14);

typedef IconEntry = DropdownMenuEntry<ClassificationLabel>;

enum ClassificationLabel {
  confidential(
      'Confidential',
      Icon(
        Icons.remove_moderator,
        color: Colors.green,
      ),
      CONFIDENTIAL),
  secret('Secret', Icon(Icons.verified_user, color: Colors.orange), SECRET),
  topSecret(
      'Top Secret', Icon(Icons.verified_user, color: Colors.red), TOP_SECRET);

  const ClassificationLabel(this.label, this.icon, this.level);

  final String label;
  final Icon icon;
  final int level;

  static final List<IconEntry> entries = UnmodifiableListView<IconEntry>(
    values.map<IconEntry>(
      (ClassificationLabel icon) =>
          IconEntry(value: icon, label: icon.label, leadingIcon: icon.icon),
    ),
  );

  static ClassificationLabel from(int level) {
    switch (level) {
      case TOP_SECRET:
        return ClassificationLabel.topSecret;
      case CONFIDENTIAL:
        return ClassificationLabel.confidential;
      default:
        return ClassificationLabel.secret;
    }
  }
}

class _PasswordCreatePageState extends ConsumerState<PasswordCreatePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _usernameController = TextEditingController();
  final _uriController = TextEditingController();
  final _passwordController = TextEditingController();
  final _remarkController = TextEditingController();
  final _classificationController = TextEditingController();

  ClassificationLabel classification = ClassificationLabel.secret;

  @override
  void dispose() {
    _titleController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _uriController.dispose();
    _remarkController.dispose();
    _classificationController.dispose();
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
                  await passwordRepository.create(
                      classification.level,
                      _titleController.text,
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
              DropdownMenuFormField<ClassificationLabel>(
                enableFilter: true,
                expandedInsets: EdgeInsets.zero,
                controller: _classificationController,
                initialSelection: ClassificationLabel.secret,
                requestFocusOnTap: true,
                leadingIcon: classification.icon,
                label: const Text('Classification'),
                inputDecorationTheme: const InputDecorationTheme(
                  filled: true,
                  isDense: true,
                ),
                onSelected: (ClassificationLabel? value) {
                  setState(() {
                    classification = value ?? ClassificationLabel.secret;
                  });
                },
                dropdownMenuEntries: ClassificationLabel.entries,
                validator: (ClassificationLabel? value) {
                  final input = _classificationController.text;
                  if (value == null ||
                      !ClassificationLabel.values
                          .map((label) => label.label)
                          .contains(input)) {
                    return 'Please select a classification.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              FormInput(
                controller: _titleController,
                name: "Name",
                protected: false,
                required: true,
              ),
              SizedBox(height: 10),
              FormInput(
                controller: _usernameController,
                name: "Username",
                protected: false,
                required: true,
              ),
              SizedBox(height: 10),
              FormInput(
                controller: _passwordController,
                name: "Password",
                protected: true,
                required: true,
              ),
              SizedBox(height: 10),
              FormInput(
                controller: _uriController,
                name: "URI",
                protected: false,
                required: false,
              ),
              SizedBox(height: 10),
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
