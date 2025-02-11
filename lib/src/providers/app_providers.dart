import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../service/app_service.dart';
import '../service/kdbx_service.dart';

final kdbxServiceProvider = Provider<KdbxService>((ref) => KdbxService());
final appServiceProvider = Provider<AppService>((ref) {
  final kdbxService = ref.watch(kdbxServiceProvider);

  return AppService(kdbxService);
});
