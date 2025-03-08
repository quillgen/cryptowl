import 'package:cryptowl/main.dart';
import 'package:cryptowl/src/common/exceptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kdbx/kdbx.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:toastification/toastification.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '../providers.dart';

part 'login.g.dart';

@riverpod
class LoginState extends _$LoginState {
  @override
  AsyncValue<bool> build() {
    return AsyncValue.data(false);
  }

  Future<void> login(ProtectedValue password) async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(seconds: 1));
    state = await AsyncValue.guard(() async {
      final user = await ref.read(appServiceProvider).login(password);
      ref.read(currentUserProvider.notifier).setUser(user);
      return true;
    });
  }

  Future<void> logout() async {
    logger.fine("Logging out...");
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      ref.read(currentUserProvider.notifier).setUser(null);
      return false;
    });
  }
}

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  static const String path = '/login';
  static const String name = 'Login';

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
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
        .read(loginStateProvider.notifier)
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
      return "Unknown error";
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginStateProvider);
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
              data: (success) =>
                  success ? const Text('Already logged in') : _loginButton(),
            ),
          ],
        ),
      ),
    );
  }
}
