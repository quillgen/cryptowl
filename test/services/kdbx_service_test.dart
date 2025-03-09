import 'package:cryptowl/src/service/kdbx_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kdbx/kdbx.dart';

void main() {
  final service = KdbxService();
  final kdbxFormat = KdbxFormat();
  test('should create kdbx store when initialize', () async {
    final password = ProtectedValue.fromString("fakepassword");
    final kdbx = await service.create(password);
    final data = await kdbx.save();
    expect(data, isNotNull);

    final file = await kdbxFormat.read(data, Credentials(password));
    expect(file.body.rootGroup.entries, isNotNull);
    expect(file.body.rootGroup.entries.length, 1);
    expect(
        file.body.rootGroup.entries[0]
            .getString(KdbxKeyCommon.TITLE)
            ?.getText(),
        "CONFIG");
  });

  test('should load meta when read kdbx', () async {
    final password = ProtectedValue.fromString("fakepassword");
    final kdbx = await service.create(password);
    final data = await kdbx.save();
    expect(data, isNotNull);

    final meta = await service.loadMeta(kdbx);

    expect(meta.appVersion, "1.0.0");
    expect(meta.dbEncryptionKey, isNotNull);
    expect(meta.dbInstance, isNotNull);
  });
}
