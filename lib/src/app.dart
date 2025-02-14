import 'package:cryptowl/main.dart';
import 'package:cryptowl/src/screens/onboarding.dart';
import 'package:cryptowl/src/screens/splash.dart';
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
  return AppService(ref, ref.read(kdbxServiceProvider));
}

@riverpod
class InitState extends _$InitState {
  @override
  bool? build() {
    return null;
  }

  Future<void> checkInit() async {
    final appService = ref.read(appServiceProvider);
    final inited = await appService.isInitialized();
    await Future.delayed(const Duration(seconds: 1));
    state = inited;
  }

  void setInitState(bool? inited) => state = inited;
}

@riverpod
GoRouter goRouter(Ref ref) {
  logger.fine("~~~~~~~~~~~~~~~router rebuild");

  final initState = ref.watch(initStateProvider);
  final credentials = ref.watch(currentUserProvider);
  return GoRouter(
    initialLocation: "/splash",
    redirect: (context, state) {
      if (initState == null) {
        return null;
      } else if (initState == false) {
        return "/onboarding";
      } else {
        return credentials == null ? "/login" : "/";
      }
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => SplashScreen(),
      ),
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
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp.router(
          restorationScopeId: 'app',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
          ],
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,
          routerConfig: router,
        );
      },
    );
  }
}
