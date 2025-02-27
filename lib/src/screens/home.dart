import 'package:cryptowl/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pages/passwords.dart';
import 'components/app_drawer.dart';
import 'pages/category_page.dart';
import 'pages/detail_panel.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentPageIndex = 0;

  Future<void> _securityInfoDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Valut information'),
            content: const Text(
              'Your valut is encrypted ...',
            ),
          );
        });
  }

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
            child: CategoryPage(),
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
              child: DetailPanel(),
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
    // Define the children to display within the body at different breakpoints.
    final List<Widget> children = <Widget>[
      for (int i = 0; i < 10; i++)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: const Color.fromARGB(255, 255, 201, 197),
            height: 400,
          ),
        )
    ];
    return AdaptiveScaffold(
      // An option to override the default transition duration.
      transitionDuration: Duration(milliseconds: 1),
      // An option to override the default breakpoints used for small, medium,
      // mediumLarge, large, and extraLarge.
      smallBreakpoint: const Breakpoint(endWidth: 700),
      mediumBreakpoint: const Breakpoint(beginWidth: 700, endWidth: 1000),
      mediumLargeBreakpoint: const Breakpoint(beginWidth: 1000, endWidth: 1200),
      largeBreakpoint: const Breakpoint(beginWidth: 1200, endWidth: 1600),
      extraLargeBreakpoint: const Breakpoint(beginWidth: 1600),
      useDrawer: false,
      selectedIndex: 1,
      onSelectedIndexChange: (int index) {
        setState(() {
          //1 = index;
        });
      },
      destinations: const <NavigationDestination>[
        NavigationDestination(
          icon: Icon(Icons.inbox_outlined),
          selectedIcon: Icon(Icons.inbox),
          label: 'Inbox',
        ),
        NavigationDestination(
          icon: Icon(Icons.article_outlined),
          selectedIcon: Icon(Icons.article),
          label: 'Articles',
        ),
        NavigationDestination(
          icon: Icon(Icons.chat_outlined),
          selectedIcon: Icon(Icons.chat),
          label: 'Chat',
        ),
        NavigationDestination(
          icon: Icon(Icons.video_call_outlined),
          selectedIcon: Icon(Icons.video_call),
          label: 'Video',
        ),
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Inbox',
        ),
      ],
      smallBody: (_) => ListView.builder(
        itemCount: children.length,
        itemBuilder: (_, int idx) => children[idx],
      ),
      body: (_) => GridView.count(crossAxisCount: 2, children: children),
      mediumLargeBody: (_) =>
          GridView.count(crossAxisCount: 3, children: children),
      largeBody: (_) => GridView.count(crossAxisCount: 4, children: children),
      extraLargeBody: (_) =>
          GridView.count(crossAxisCount: 5, children: children),
      // Define a default secondaryBody.
      // Override the default secondaryBody during the smallBreakpoint to be
      // empty. Must use AdaptiveScaffold.emptyBuilder to ensure it is properly
      // overridden.
      smallSecondaryBody: AdaptiveScaffold.emptyBuilder,
      secondaryBody: (_) => Container(
        color: const Color.fromARGB(255, 234, 158, 192),
      ),
      mediumLargeSecondaryBody: (_) => Container(
        color: const Color.fromARGB(255, 234, 158, 192),
      ),
      largeSecondaryBody: (_) => Container(
        color: const Color.fromARGB(255, 234, 158, 192),
      ),
      extraLargeSecondaryBody: (_) => Container(
        color: const Color.fromARGB(255, 234, 158, 192),
      ),
    );
  }

  Widget build1(BuildContext context) {
    final isLargeScreen = false;
    // final isLargeScreen = ResponsiveBreakpoints.of(context).largerThan(MOBILE);
    logger.fine("is the device desktop? $isLargeScreen");
    final detailPanelNotifier = ref.read(detailPanelStateProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text("My passwords"),
        titleSpacing: 8,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Create password',
            onPressed: () {
              detailPanelNotifier.setCreateMode();
            },
          ),
          IconButton(
            icon: const Icon(Icons.admin_panel_settings),
            tooltip: 'Current user information',
            onPressed: () => _securityInfoDialog(context),
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
