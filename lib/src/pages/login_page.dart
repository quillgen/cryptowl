import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toastification/toastification.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '../common/exceptions.dart';
import '../common/protected_value.dart';
import '../providers/providers.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  static const String path = '/login';
  static const String name = 'Login';

  @override
  ConsumerState<LoginPage> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginPage> {
  final _inputController = TextEditingController();

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void onLoginSubmitted() {
    if (_inputController.text.isEmpty) {
      toastification.show(
        context: context,
        title: Text('Please input your password!'),
        autoCloseDuration: const Duration(seconds: 3),
      );
      return;
    }
    ref
        .read(asyncLoginProvider.notifier)
        .login(ProtectedValue.fromString(_inputController.text));
  }

  Widget _loginButton() {
    return ElevatedButton(
      onPressed: onLoginSubmitted,
      child: const Text("Login"),
    );
  }

  String? getError(Object? error) {
    if (error == null) {
      return null;
    } else if (error is IncorrectPasswordException) {
      return "Password incorrect, please try again";
    } else {
      return "Unknown error: $error";
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(asyncLoginProvider);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture(
              AssetBytesLoader("assets/images/cryptowl-full.svg.vec"),
              height: 50,
            ),
            const Text("Please login use you master password."),
            SizedBox(height: 20),
            TextField(
              autofocus: true,
              controller: _inputController,
              obscureText: true,
              textInputAction: TextInputAction.go,
              onSubmitted: (_) => onLoginSubmitted(),
              decoration: InputDecoration(
                labelText: "Master password",
                errorText: getError(loginState.error),
              ),
            ),
            SizedBox(height: 10),
            loginState.when(
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => _loginButton(),
              data: (kdbx) =>
                  kdbx != null ? const Text('Login success') : _loginButton(),
            ),
          ],
        ),
      ),
    );
  }
}
