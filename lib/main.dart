import 'package:cryptowl/src/providers/app_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:sqlcipher_flutter_libs/sqlcipher_flutter_libs.dart';
import 'package:sqlite3/open.dart';

import 'src/app.dart';
import 'src/service/app_service.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

final logger = Logger();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  open.overrideFor(OperatingSystem.android, openCipherOnAndroid);

  final settingsController = SettingsController(SettingsService());

  final container = ProviderContainer();
  final AppService appService = container.read(appServiceProvider);
  final initialized = await appService.isInitialized();

  logger.i("Application has initialized? =$initialized");
  await settingsController.loadSettings();

  runApp(
    ProviderScope(
      child: CryptowlApp(
        initialized: initialized,
        settingsController: settingsController,
      ),
    ),
  );
}
