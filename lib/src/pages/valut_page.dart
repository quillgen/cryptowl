import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../components/password_list.dart';
import '../providers.dart';
import 'filter_drawer.dart';
import 'menu_drawer.dart';
import 'password_create_page.dart';

class ValutPage extends ConsumerStatefulWidget {
  const ValutPage({super.key});

  static const String path = '/myvalut';
  static const String name = 'MyValut';

  @override
  ConsumerState<ValutPage> createState() => _ValutPageState();
}

class _ValutPageState extends ConsumerState<ValutPage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
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
    final filterState = ref.watch(classificationFiltersProvider);
    int filterCount = 0;
    if (filterState.topSecret) filterCount++;
    if (filterState.secret) filterCount++;
    if (filterState.confidential) filterCount++;
    if (filterState.includeDeleted) filterCount++;

    return Scaffold(
      key: _scaffoldKey,
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
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
            icon: filterCount == 0
                ? Icon(Icons.filter_alt)
                : Badge.count(
                    count: filterCount, child: const Icon(Icons.filter_alt)),
            tooltip: "Filter",
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
      drawer: MenuDrawer(),
      endDrawer: FilterDrawer(),
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
