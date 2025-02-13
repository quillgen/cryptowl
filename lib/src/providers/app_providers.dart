import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../service/app_service.dart';
import '../service/kdbx_service.dart';

// learn riverpod: https://codewithandrea.com/articles/flutter-state-management-riverpod/

final kdbxServiceProvider = Provider<KdbxService>((ref) => KdbxService());
final appServiceProvider = Provider<AppService>((ref) {
  return AppService(ref, ref.watch(kdbxServiceProvider));
});
