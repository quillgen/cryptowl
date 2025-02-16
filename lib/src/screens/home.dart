import 'package:flutter/material.dart';

import 'passwords.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: <Widget>[
        PasswordListScreen(),
        Text("2"),
        Text("3"),
        Text("4")
      ][currentPageIndex],
      bottomNavigationBar: _renderNavigationBar(),
    );
  }
}
