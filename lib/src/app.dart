import 'package:cryptowl/main.dart';
import 'package:cryptowl/src/pages/introduction.dart';
import 'package:cryptowl/src/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'pages/generator_page.dart';
import 'pages/login.dart';
import 'pages/more_page.dart';
import 'pages/onboarding.dart';
import 'pages/password_create_page.dart';
import 'pages/password_detail_page.dart';
import 'pages/password_edit_page.dart';
import 'pages/send_page.dart';
import 'pages/valut_page.dart';
import 'providers.dart';
import 'scaffold_shell.dart';
import 'theme.dart';

part 'app.g.dart';

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

@riverpod
GoRouter goRouter(Ref ref) {
  final initState = ref.watch(initStateProvider);
  final credentials = ref.watch(currentUserProvider);
  logger.fine("Router rebuiding...");

  final GoRoute unauthenticatedRoutes = GoRoute(
    name: LoginScreen.name,
    path: LoginScreen.path,
    pageBuilder: (BuildContext context, GoRouterState state) {
      return const MaterialPage<void>(child: LoginScreen());
    },
    redirect: (BuildContext context, GoRouterState state) {
      final skip = state.uri.queryParameters["skip"];
      logger.fine("-> ${state.fullPath}");
      if (initState == null) {
        return SplashPage.path;
      } else if (initState == false) {
        if (skip != null && skip == "true") {
          return null;
        } else {
          return "${LoginScreen.path}/${IntroductionPage.path}";
        }
      } else {
        if (credentials != null) {
          return ValutPage.path;
        }
        return null;
      }
    },
    routes: <RouteBase>[
      GoRoute(
        name: IntroductionPage.name,
        path: IntroductionPage.path,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return const MaterialPage<void>(
            child: IntroductionPage(),
          );
        },
      ),
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
      if (credentials == null) {
        return LoginScreen.path;
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
            name: MorePage.name,
            path: MorePage.path,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return const NoTransitionPage<void>(
                key: ValueKey<String>(MorePage.name),
                child: MorePage(),
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
  ];

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      if (state.uri.path == '/') {
        return ValutPage.path;
      }
      return null;
    },
    routes: <RouteBase>[
      unauthenticatedRoutes,
      authenticatedRoutes,
      ...openRoutes,
    ],
  );
}

class CryptowlApp extends ConsumerWidget {
  const CryptowlApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

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
      //themeMode:  ThemeMo,
    );
  }
}
