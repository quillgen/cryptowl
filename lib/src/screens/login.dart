import 'package:cryptowl/src/common/exceptions.dart';
import 'package:cryptowl/src/providers/app_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kdbx/kdbx.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '../config/meta.dart';

part 'login.g.dart';

@immutable
class Credentials {
  final Meta meta;
  final ProtectedValue password;

  const Credentials(this.meta, this.password);
}

@riverpod
class Authentication extends _$Authentication {
  @override
  AsyncValue<Credentials?> build() {
    return const AsyncData(null);
  }

  Future<void> login(ProtectedValue password) async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(seconds: 1));
    state = await AsyncValue.guard(() async {
      final meta = await ref.read(appServiceProvider).login(password);
      return Credentials(meta, password);
    });
  }
}

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _controller = TextEditingController();
  bool loading = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _loginButton() {
    return ElevatedButton(
      onPressed: () {
        if (_controller.text.isEmpty) {
          return;
        }
        ref
            .read(authenticationProvider.notifier)
            .login(ProtectedValue.fromString(_controller.text));
      },
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
    final authState = ref.watch(authenticationProvider);

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
              controller: _controller,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Master password",
                errorText: getError(authState.error),
              ),
            ),
            SizedBox(height: 10),
            authState.when(
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => _loginButton(),
              data: (user) => user != null
                  ? const Text('Already logged in')
                  : _loginButton(),
            ),
          ],
        ),
      ),
    );
  }
}
