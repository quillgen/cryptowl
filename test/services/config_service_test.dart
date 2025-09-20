import 'dart:io';

import 'package:cryptowl/src/service/config_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:native_argon2/native_argon2.dart';
import 'package:path/path.dart' as path;

void main() {
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
    final service = ConfigService();
    final scriptDir = path.dirname(Platform.script.path);
    final file = File(path.join(scriptDir, 'test/services/PZE3Y.cfg'));
    final content = await file.readAsString();
    final config = await service.loadConfig(content);

    expect(config.version, "1.0.0");
    expect(config.data.encryptedKey,
        "3E3XJ-ZKW3X-WQ7SS-C4XC1-TDQ98-AFFZP-7BBGV-3YKV6-8J06D-1Q9QT-V6DJ5-DDRG3-34AHF-1KT9P-CX4KQ-DBYVA-VFH9Z-063FT-WWW8A-KGPGK-4HG");
    expect(config.hash,
        "ND7YN-PVD03-TXW6K-SYETM-VEJAV-0J69Y-P2F0B-HTPZW-2PQ0P-P48DW-QG");
  });
}
