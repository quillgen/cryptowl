// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

/// The profile page.
class PasswordDetailPage extends StatelessWidget {
  /// Construct the profile page.
  const PasswordDetailPage({super.key});

  /// The path for the profile page.
  static const String path = 'detail';

  /// The name for the profile page.
  static const String name = 'Detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password detail'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => <void>{},
              child: const Text('Hello'),
            ),
          ],
        ),
      ),
    );
  }
}
