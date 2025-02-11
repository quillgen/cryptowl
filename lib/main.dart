import 'package:cryptowl/src/providers/app_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:sqlcipher_flutter_libs/sqlcipher_flutter_libs.dart';
import 'package:sqlite3/open.dart';
import 'package:sqlite3/sqlite3.dart';

import 'src/app.dart';
import 'src/common/path_util.dart';
import 'src/service/app_service.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

final logger = Logger();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  open.overrideFor(OperatingSystem.android, openCipherOnAndroid);
  final dataPath = await PathUtil.getLocalPath("data.enc");

  final db = sqlite3.open(dataPath);
  if (db.select('PRAGMA cipher_version;').isEmpty) {
    throw StateError(
        'SQLCipher library is not available, please check your dependencies!');
  }

  db.execute("PRAGMA key = 'your passphrase';");
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  final container = ProviderContainer();
  final AppService appService = container.read(appServiceProvider);
  final initialized = await appService.isInitialized();

  logger.i("Application has initialized? =$initialized");
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(
    ProviderScope(
      child: CryptowlApp(
        initialized: initialized,
        settingsController: settingsController,
      ),
    ),
  );
}
