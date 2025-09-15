import 'package:cryptowl/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '../common/protected_value.dart';
import '../components/form_input.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  static const String path = '/onboarding';
  static const String name = 'Onboarding';

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final onboardingNotifier = ref.read(onboardingProvider.notifier);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(32.0),
        child: Form(
          key: _formKey,
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
              FormInput(
                name: "Master password",
                protected: true,
                required: true,
                controller: _passwordController,
              ),
              SizedBox(height: 10),
              TextFormField(
                style: TextStyle(fontSize: 14),
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Confirm password",
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  labelText: "Password hint",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      onboardingNotifier.completeOnboarding(
                          ProtectedValue.fromString(_passwordController.text));
                    }
                  },
                  child: const Text("Create database"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
