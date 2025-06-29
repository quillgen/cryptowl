// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';

import 'localization/app_localizations.dart';
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
      leadingExtendedNavRail: Padding(
        padding: EdgeInsetsGeometry.all(8),
        child: Row(
          children: [
            Expanded(child: Text("123")),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.menu),
              tooltip: "Menu",
            )
          ],
        ),
      ),
      leadingUnextendedNavRail: IconButton(
        onPressed: () {},
        icon: Icon(Icons.menu),
        tooltip: "Menu",
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
            SettingsPage.name => NavigationDestination(
                icon: Icon(RemixIcons.camera_lens_ai_line),
                label: AppLocalizations.of(context)!.moments),
            PhotosPage.name => NavigationDestination(
                icon: Icon(RemixIcons.camera_ai_line),
                label: AppLocalizations.of(context)!.photos),
            NotesPage.name => NavigationDestination(
                icon: Icon(RemixIcons.list_check_3),
                label: AppLocalizations.of(context)!.notes),
            ValutPage.name => NavigationDestination(
                icon: Icon(RemixIcons.shield_keyhole_line),
                label: AppLocalizations.of(context)!.passwords),
            _ => throw UnimplementedError(
                'The route ${e.defaultRoute?.name} is not implemented.',
              ),
          };
        },
      ).toList(),
    );
  }
}
