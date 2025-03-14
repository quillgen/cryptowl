import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../main.dart';
import 'pages/generator_page.dart';
import 'pages/introduction_page.dart';
import 'pages/login_page.dart';
import 'pages/onboarding_page.dart';
import 'pages/password_create_page.dart';
import 'pages/password_detail_page.dart';
import 'pages/password_edit_page.dart';
import 'pages/send_page.dart';
import 'pages/settings_page.dart';
import 'pages/splash_page.dart';
import 'pages/valut_page.dart';
import 'providers/providers.dart';
import 'scaffold_shell.dart';
import 'theme.dart';

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> passwordsNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'passwords');
final GlobalKey<NavigatorState> generatorNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'generator');
final GlobalKey<NavigatorState> sendNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'send');
final GlobalKey<NavigatorState> settingsNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'settings');

final routerProvider = Provider<GoRouter>((ref) {
  final onboardingState = ref.watch(onboardingProvider);
  final loginState = ref.watch(asyncLoginProvider);
  logger.fine(
      "Router rebuilding ---> onboardingState=$onboardingState loginState=$loginState");

  final GoRoute unauthenticatedRoutes = GoRoute(
    name: LoginPage.name,
    path: LoginPage.path,
    pageBuilder: (BuildContext context, GoRouterState state) {
      return const MaterialPage<void>(child: LoginPage());
    },
    // redirect: (BuildContext context, GoRouterState state) {
    //   print("-----> login redirect");
    //   if (loginState.unwrapPrevious().valueOrNull != null) {
    //     return ValutPage.path;
    //   } else {
    //     return null;
    //   }
    // },
    routes: <RouteBase>[
      GoRoute(
        name: OnboardingPage.name,
        path: OnboardingPage.path,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return const MaterialPage<void>(
            child: OnboardingPage(),
          );
        },
      ),
    ],
  );

  final StatefulShellRoute authenticatedRoutes =
      StatefulShellRoute.indexedStack(
    parentNavigatorKey: rootNavigatorKey,
    builder: (
      BuildContext context,
      GoRouterState state,
      StatefulNavigationShell navigationShell,
    ) {
      return ScaffoldShell(navigationShell: navigationShell);
    },
    redirect: (BuildContext context, GoRouterState state) {
      if (loginState.unwrapPrevious().valueOrNull == null) {
        return LoginPage.path;
      }
      return null;
    },
    branches: <StatefulShellBranch>[
      StatefulShellBranch(
        navigatorKey: passwordsNavigatorKey,
        routes: <RouteBase>[
          GoRoute(
            name: ValutPage.name,
            path: ValutPage.path,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return const NoTransitionPage<void>(
                child: ValutPage(),
              );
            },
            routes: <RouteBase>[
              GoRoute(
                name: PasswordDetailPage.name,
                path: PasswordDetailPage.path,
                parentNavigatorKey: rootNavigatorKey,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return const MaterialPage<void>(
                    //fullscreenDialog: true,
                    child: PasswordDetailPage(),
                  );
                },
              ),
              GoRoute(
                name: PasswordEditPage.name,
                path: PasswordEditPage.path,
                parentNavigatorKey: rootNavigatorKey,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return const MaterialPage<void>(
                    //fullscreenDialog: true,
                    child: PasswordEditPage(),
                  );
                },
              ),
              GoRoute(
                name: PasswordCreatePage.name,
                path: PasswordCreatePage.path,
                parentNavigatorKey: rootNavigatorKey,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return const MaterialPage<void>(
                    //fullscreenDialog: true,
                    child: PasswordCreatePage(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: sendNavigatorKey,
        routes: <RouteBase>[
          GoRoute(
            name: SendPage.name,
            path: SendPage.path,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return const NoTransitionPage<void>(child: SendPage());
            },
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: generatorNavigatorKey,
        routes: <RouteBase>[
          GoRoute(
            name: GeneratorPage.name,
            path: GeneratorPage.path,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return const NoTransitionPage<void>(child: GeneratorPage());
            },
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: settingsNavigatorKey,
        routes: <RouteBase>[
          GoRoute(
            name: SettingsPage.name,
            path: SettingsPage.path,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return const NoTransitionPage<void>(
                key: ValueKey<String>(SettingsPage.name),
                child: SettingsPage(),
              );
            },
            routes: <RouteBase>[],
          ),
        ],
      ),
    ],
  );

  final List<GoRoute> openRoutes = <GoRoute>[
    GoRoute(
      name: SplashPage.name,
      path: SplashPage.path,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return const MaterialPage<void>(
          child: SplashPage(),
        );
      },
    ),
    GoRoute(
      name: IntroductionPage.name,
      path: IntroductionPage.path,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return const MaterialPage<void>(
          child: IntroductionPage(),
        );
      },
    ),
  ];

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: false,
    initialLocation: ValutPage.path,
    redirect: (BuildContext context, GoRouterState state) {
      print("-----> root redirect");
      final skip = state.uri.queryParameters["skip"];

      if (onboardingState.isLoading) {
        return SplashPage.path;
      } else if (onboardingState.unwrapPrevious().valueOrNull == false) {
        if (skip == "true") {
          return null;
        } else {
          return IntroductionPage.path;
        }
      } else {
        return null;
      }
    },
    routes: <RouteBase>[
      unauthenticatedRoutes,
      authenticatedRoutes,
      ...openRoutes,
    ],
  );
});

class CryptowlApp extends ConsumerWidget {
  const CryptowlApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final theme = ref.watch(themeProvider);

    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
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
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: theme,
    );
  }
}
