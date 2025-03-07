import 'package:cryptowl/src/components/password_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'drawer_menu.dart';
import 'password_create_page.dart';

enum FilterMenu {
  all,
  favorite,
  deleted,
}

class ValutPage extends StatefulWidget {
  const ValutPage({super.key});

  static const String path = '/myvalut';
  static const String name = 'MyValut';

  @override
  State<ValutPage> createState() => _ValutPageState();
}

class _ValutPageState extends State<ValutPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My valut'),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: "Menu",
            );
          },
        ),
        bottom: TabBar(
          isScrollable: false,
          controller: _tabController,
          tabs: [
            Tab(text: "Passwords"),
            Tab(text: "Notes"),
            Tab(text: "Cards"),
            Tab(text: "Files"),
          ],
        ),
        actions: [
          PopupMenuButton<FilterMenu>(
            icon: const Icon(Icons.filter_alt),
            tooltip: "Filter passwords",
            onSelected: (FilterMenu item) {},
            itemBuilder: (BuildContext context) => <PopupMenuEntry<FilterMenu>>[
              PopupMenuItem<FilterMenu>(
                value: FilterMenu.all,
                child: CheckboxListTile(
                  title: Text("Top secret"),
                  value: true,
                  onChanged: (bool? value) {},
                ),
              ),
              PopupMenuItem<FilterMenu>(
                value: FilterMenu.favorite,
                child: CheckboxListTile(
                  title: Text("Secret"),
                  value: true,
                  onChanged: (bool? value) {},
                ),
              ),
              PopupMenuItem<FilterMenu>(
                value: FilterMenu.deleted,
                child: CheckboxListTile(
                  title: Text("Confidential"),
                  value: true,
                  onChanged: (bool? value) {},
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
            tooltip: "Search",
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
            tooltip: "More operations",
          ),
        ],
      ),
      drawer: DrawerMenu(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed(
            PasswordCreatePage.name,
          );
        },
        child: const Icon(Icons.add),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          PasswordListPage(),
          Icon(Icons.directions_transit),
          Icon(Icons.directions_bike),
          Icon(Icons.directions_bike),
        ],
      ),
    );
  }
}
