import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '../providers.dart';

const infoTextStyle = TextStyle(fontSize: 10, color: Colors.black38);

class VersionInfo extends ConsumerWidget {
  const VersionInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packageInfo = ref.watch(packageInfoProvider);

    return packageInfo.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text("$error"),
      data: (info) => Text(info.version, style: infoTextStyle),
    );
  }
}

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            //decoration: BoxDecoration(color: Colors.grey),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture(
                      AssetBytesLoader("assets/images/cryptowl-full.svg.vec"),
                      height: 40,
                    ),
                    VersionInfo(),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  "© by Riguz Lee, 2024-2025",
                  style: infoTextStyle,
                ),
                SizedBox(height: 10),
                Text(
                  "https://github.com/quillgen/cryptowl",
                  style: infoTextStyle,
                )
              ],
            ),
          ),
          ListTile(
            title: const Text('Backup'),
          ),
          ListTile(
            title: const Text('Help'),
          ),
          ListTile(
            title: const Text('About'),
          ),
        ],
      ),
    );
  }
}
