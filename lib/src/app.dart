import 'package:cryptowl/main.dart';
import 'package:cryptowl/src/screens/onboarding.dart';
import 'package:cryptowl/src/service/kdbx_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/introduction.dart';
import 'service/app_service.dart';
import 'settings/settings_controller.dart';

part 'app.g.dart';

@riverpod
KdbxService kdbxService(Ref ref) {
  return KdbxService();
}

@riverpod
AppService appService(Ref ref) {
  return AppService(ref, ref.watch(kdbxServiceProvider));
}

@riverpod
GoRouter goRouter(Ref ref) {
  return GoRouter(
    redirect: (context, state) {
      final authState = ref.watch(authenticationProvider);
      logger.d("${authState}");
      return authState.when(
          data: (credentials) => credentials == null ? "/login" : "/",
          error: (_, __) => "/login",
          loading: () => "/login");
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => OnboardingScreen(),
      ),
      GoRoute(
        path: '/introduction',
        builder: (context, state) => AppIntroductionScreen(),
      ),
    ],
  );
}

class CryptowlApp extends ConsumerWidget {
  const CryptowlApp({
    super.key,
    required this.initialized,
    required this.settingsController,
  });

  final bool initialized;
  final SettingsController settingsController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp.router(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,
          routerConfig: router,
        );
      },
    );
  }
}
