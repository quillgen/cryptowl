import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:cryptowl/src/crypto/protected_value.dart';
import 'package:cryptowl/src/service/config_service.dart';
import 'package:cryptowl/src/service/kdf_service.dart';
import 'package:cryptowl/src/service/version_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:native_argon2/native_argon2.dart';

@GenerateNiceMocks([MockSpec<ConfigService>(), MockSpec<VersionService>()])
import 'kdf_service_test.mocks.dart';

void main() {
  final mockVersionService = MockVersionService();
  late KdfService service;
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
    service = KdfService(ConfigService(mockVersionService));
  });

  test('should return 32 bytes secret key', () async {
    final key = await service.generateRandomBytes(length: 32);
    expect(key.binaryValue, hasLength(32));
  });

  test('should return 16 bytes salt', () async {
    final key = await service.generateRandomBytes(length: 16);
    expect(key.binaryValue, hasLength(16));
  });

  test('should return master key based on master password and email as salt',
      () async {
    // https://argon2.online/
    // $argon2id$v=19$m=19456,t=2,p=1$ZHJAcmlndXouY29t$CMiXFHTwhEhxwgjjl7BDk65dnX3p8plUpMKY95AE2o4

    final secretKey = hex.decode(
            "9a54bef1921ce1c89255dc67229ffffd2dd1efb5ef3cdd3da66ae9ab53fb974f")
        as Uint8List;
    final key = await service.createTransformedMasterKey(
        ProtectedValue.fromString("123456"),
        ProtectedValue.fromBinary(secretKey),
        hex.decode("b27f6e2bd596308c190c4f1d68660bc3") as Uint8List);
    String encoded = hex.encode(key.binaryValue);
    expect(
        encoded,
        equals(
            "509f825b859521f72fe511d2c120f53ed52bf641932d92ba086b89be3d65153a"));
  });

  test(
      'should create config and could decrypt the symmetric key if credentials correct',
      () async {
    final masterPassword = utf8.encode("123456");
    final secretKey = hex.decode(
            "9a54bef1921ce1c89255dc67229ffffd2dd1efb5ef3cdd3da66ae9ab53fb974f")
        as Uint8List;
    final transformSeed = hex.decode(
            "9a54bef1921ce1c89255dc67229ffffd2dd1efb5ef3cdd3da66ae9ab53fb974f")
        as Uint8List;
    final masterSeed = hex.decode(
            "9a54bef1921ce1c89255dc67229ffffd2dd1efb5ef3cdd3da66ae9ab53fb974f")
        as Uint8List;
    final symmetricKey = hex.decode(
            "9a54bef1921ce1c89255dc67229ffffd2dd1efb5ef3cdd3da66ae9ab53fb974f")
        as Uint8List;
    final nonce = hex.decode(
            "9a54bef1921ce1c89255dc67229ffffd2dd1efb5ef3cdd3da66ae9ab53fb974f")
        as Uint8List;
    final config = await service.generateAppConfig(
        ProtectedValue.fromBinary(masterPassword),
        ProtectedValue.fromBinary(secretKey),
        "001",
        transformSeed,
        masterSeed,
        ProtectedValue.fromBinary(symmetricKey),
        nonce);

    expect(config.data.instanceId, "001");
  });
}
