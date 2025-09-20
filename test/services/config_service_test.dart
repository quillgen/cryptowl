import 'dart:io';

import 'package:cryptowl/src/service/config_service.dart';
import 'package:cryptowl/src/service/version_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:native_argon2/native_argon2.dart';
import 'package:path/path.dart' as path;

@GenerateNiceMocks([MockSpec<VersionService>()])
import 'config_service_test.mocks.dart';

void main() {
  final mockVersionService = MockVersionService();
  setUp(() {
    String testLibPath;

    if (Platform.isMacOS) {
      testLibPath = 'deps/native_argon2/src/build/libnative_argon2.dylib';
    } else if (Platform.isLinux) {
      testLibPath = 'deps/native_argon2/src/build/libnative_argon2.so';
    } else if (Platform.isWindows) {
      testLibPath = 'deps/native_argon2/src/build/libnative_argon2.dll';
    } else {
      throw UnsupportedError(
        'Tests on ${Platform.operatingSystem} not supported',
      );
    }
    Argon2LibraryLoader.instance.configure(libraryPath: testLibPath);
  });

  test('should return parsed config object', () async {
    final service = ConfigService(mockVersionService);
    final scriptDir = path.dirname(Platform.script.path);
    final file = File(path.join(scriptDir, 'test/services/WJB6W.cfg'));
    final content = await file.readAsString();
    final config = await service.loadConfig(content);

    when(mockVersionService.getPackageVersion())
        .thenAnswer((_) async => "1.0.0");

    expect(config.version, "1.0.0");
    expect(config.data.encryptedKey,
        "KD0VT-X2J3J-HKNTR-ZG4QF-YKFXN-DTK4T-B1SKY-XN88W-SF7J1-6DRCB-PFY6W-PHZN0-R3FST-ENAQT-8BT72-MYYDR-CF18N-69P56-N89BF-42M6G-0H0");
    expect(config.hash,
        "8E2HZ-DBJ19-WJGS0-73B4A-E98BF-KJJPF-DF6N7-ZW8NE-47HJ4-V7SH0-WG");
  });
}
