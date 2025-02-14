import 'package:cryptowl/main.dart';
import 'package:cryptowl/src/common/password_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kdbx/kdbx.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '../app.dart';

part 'onboarding.g.dart';

@immutable
class PasswordFormState {
  final ProtectedValue? password;
  final ProtectedValue? confirmPassword;
  final String? passwordError;
  final String? confirmPasswordError;
  final String? passwordHint;

  const PasswordFormState({
    this.password,
    this.confirmPassword,
    this.passwordError,
    this.confirmPasswordError,
    this.passwordHint,
  });

  bool get isValid => passwordError == null && confirmPasswordError == null;
}

@riverpod
class PasswordForm extends _$PasswordForm {
  @override
  PasswordFormState build() {
    return PasswordFormState();
  }

  void updatePassword(String password) {
    ProtectedValue passwordValue = ProtectedValue.fromString(password);
    String? error = validatePassword(password);
    String? confirmPasswordError;
    if (error == null && state.confirmPassword != null) {
      if (state.confirmPassword != passwordValue) {
        confirmPasswordError = "Confirm password does not match";
      }
    }
    state = PasswordFormState(
        password: passwordValue,
        confirmPassword: state.confirmPassword,
        passwordError: error,
        confirmPasswordError: confirmPasswordError,
        passwordHint: state.passwordHint);
  }

  void updateConfirmPassword(String password) {
    ProtectedValue passwordValue = ProtectedValue.fromString(password);
    String? confirmPasswordError;
    if (state.passwordError == null) {
      if (state.password != passwordValue) {
        confirmPasswordError = "Confirm password does not match";
      }
    }
    state = PasswordFormState(
        password: state.password,
        confirmPassword: passwordValue,
        passwordError: state.passwordError,
        confirmPasswordError: confirmPasswordError,
        passwordHint: state.passwordHint);
  }

  void updatePasswordHint(String hint) {
    state = PasswordFormState(
        password: state.password,
        confirmPassword: state.confirmPassword,
        passwordError: state.passwordError,
        confirmPasswordError: state.confirmPasswordError,
        passwordHint: hint);
  }
}

@riverpod
class OnboardingState extends _$OnboardingState {
  @override
  Future<bool> build() async {
    return await ref.read(appServiceProvider).isInitialized();
  }

  Future<void> completeOnboarding(ProtectedValue password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(appServiceProvider).initialize(password!);
      ref.invalidate(passwordFormProvider);
      return true;
    });
  }
}

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(passwordFormProvider);
    final formNotifier = ref.read(passwordFormProvider.notifier);
    final onboardingNotifier = ref.read(onboardingStateProvider.notifier);

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
            const Text("You need to set a master password to continue."),
            SizedBox(height: 20),
            TextField(
              obscureText: true,
              onChanged: formNotifier.updatePassword,
              decoration: InputDecoration(
                labelText: "Master password",
                errorText: formState.passwordError,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              obscureText: true,
              onChanged: formNotifier.updateConfirmPassword,
              decoration: InputDecoration(
                labelText: "Confirm password",
                errorText: formState.confirmPasswordError,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              onChanged: formNotifier.updatePasswordHint,
              decoration: const InputDecoration(
                labelText: "Password hint",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              child: ElevatedButton(
                onPressed: () async {
                  if (formState.isValid) {
                    onboardingNotifier.completeOnboarding(formState.password!);
                  }
                },
                child: const Text("Create database"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
