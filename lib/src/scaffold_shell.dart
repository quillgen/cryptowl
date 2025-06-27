// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';

import 'pages/notes_page.dart';
import 'pages/photos_page.dart';
import 'pages/settings_page.dart';
import 'pages/valut_page.dart';

/// The [ScaffoldShell] is a [StatelessWidget] that uses the [AdaptiveScaffold]
/// to create a shell for the application.
class ScaffoldShell extends StatelessWidget {
  /// Create a new instance of [AppScaffoldShell]
  const ScaffoldShell({
    required this.navigationShell,
    super.key,
  });

  /// The navigation shell to use with the navigation.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      useDrawer: false,
      internalAnimations: false,
      leadingExtendedNavRail: IconButton(
        onPressed: () {},
        icon: Icon(Icons.search),
        tooltip: "Search",
      ),
      leadingUnextendedNavRail: IconButton(
        onPressed: () {},
        icon: Icon(Icons.login),
        tooltip: "Haha",
      ),
      trailingNavRail: IconButton(
        onPressed: () {},
        icon: Icon(Icons.category),
        tooltip: "Category",
      ),
      body: (BuildContext context) => navigationShell,
      selectedIndex: navigationShell.currentIndex,
      onSelectedIndexChange: (int index) {
        navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        );
      },
      destinations: navigationShell.route.branches.map(
        (StatefulShellBranch e) {
          return switch (e.defaultRoute?.name) {
            NotesPage.name => const NavigationDestination(
                icon: Icon(Icons.mail_lock), label: 'Notes'),
            PhotosPage.name => const NavigationDestination(
                icon: Icon(Icons.photo), label: 'Photos'),
            ValutPage.name => const NavigationDestination(
                icon: Icon(Icons.password), label: 'My vault'),
            SettingsPage.name => const NavigationDestination(
                icon: Icon(Icons.settings), label: 'Settings'),
            _ => throw UnimplementedError(
                'The route ${e.defaultRoute?.name} is not implemented.',
              ),
          };
        },
      ).toList(),
    );
  }
}
