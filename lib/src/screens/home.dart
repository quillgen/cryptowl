import 'dart:io';

import 'package:cryptowl/main.dart';
import 'package:flutter/material.dart';

import 'components/app_drawer.dart';
import 'components/password_categories.dart';
import 'passwords.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop =
        Platform.isMacOS || Platform.isLinux || Platform.isWindows;
    logger.fine("is the device desktop? $isDesktop ${Platform.isMacOS}");

    if (isDesktop) {
      return DesktopHomeScreen();
    } else {
      return MobileHomeScreen();
    }
  }
}

class MobileHomeScreen extends StatefulWidget {
  const MobileHomeScreen({super.key});

  @override
  State<MobileHomeScreen> createState() => _MobileHomeScreenState();
}

class _MobileHomeScreenState extends State<MobileHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentPageIndex = 0;

  NavigationBar _renderNavigationBar() {
    return NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
        });
      },
      selectedIndex: currentPageIndex,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.password),
          icon: Icon(Icons.password_outlined),
          label: 'Passwords',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.reply),
          icon: Icon(Icons.reply_outlined),
          label: 'Send',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.auto_fix_high),
          icon: Icon(Icons.auto_fix_high_outlined),
          label: 'Generator',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.settings),
          icon: Icon(Icons.settings_outlined),
          label: 'Settings',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop =
        Platform.isMacOS || Platform.isLinux || Platform.isWindows;
    logger.fine("is the device desktop? $isDesktop ${Platform.isMacOS}");

    return Scaffold(
      appBar: AppBar(
        title: Text("My passwords"),
        titleSpacing: 8,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.admin_panel_settings),
            tooltip: 'Current user information',
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            tooltip: 'More options',
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: <Widget>[
          PasswordListScreen(),
          Text("2"),
          Text("3"),
          Text("4")
        ][currentPageIndex],
      ),
      bottomNavigationBar: _renderNavigationBar(),
    );
  }
}

class DesktopHomeScreen extends StatefulWidget {
  const DesktopHomeScreen({super.key});

  @override
  State<DesktopHomeScreen> createState() => _DesktopHomeScreenState();
}

class _DesktopHomeScreenState extends State<DesktopHomeScreen> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isDesktop =
        Platform.isMacOS || Platform.isLinux || Platform.isWindows;
    logger.fine("is the device desktop? $isDesktop ${Platform.isMacOS}");

    return Scaffold(
      appBar: AppBar(
        title: Text("My passwords"),
        titleSpacing: 8,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.admin_panel_settings),
            tooltip: 'Current user information',
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            tooltip: 'More options',
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 240,
              child: PasswordCategories(),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: const Color.fromARGB(255, 222, 222, 222),
                    width: 1,
                  ),
                  right: BorderSide(
                    color: const Color.fromARGB(255, 222, 222, 222),
                    width: 1,
                  ),
                ),
              ),
              padding: EdgeInsets.only(left: 10, right: 10),
              child: SizedBox(
                width: 350,
                child: PasswordListScreen(),
              ),
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 100),
              child: Center(
                child: Text("Details"),
              ),
            ),
          ],
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
