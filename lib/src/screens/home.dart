import 'dart:io';

import 'package:cryptowl/main.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'components/app_drawer.dart';
import 'components/password_categories.dart';
import 'components/password_detail.dart';
import 'components/passwords.dart';

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

  Widget _renderColumnLayout() {
    return Padding(
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
            child: SizedBox(
              width: 350,
              child: PasswordList(),
            ),
          ),
          Expanded(
            child: Center(
              child: SizedBox(
                width: 200,
                child: PasswordDetail(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderTabContent() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: <Widget>[
        PasswordList(),
        Text("2"),
        Text("3"),
        Text("4")
      ][currentPageIndex],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = ResponsiveBreakpoints.of(context).largerThan(MOBILE);
    logger.fine("is the device desktop? $isLargeScreen");

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
      body: isLargeScreen ? _renderColumnLayout() : _renderTabContent(),
      bottomNavigationBar: isLargeScreen ? null : _renderNavigationBar(),
      drawer: AppDrawer(),
    );
  }
}
