import 'package:kdbx/kdbx.dart';

class Meta {
  final String appVersion;
  final String sqlCipherVersion;
  final String dbInstance;
  final ProtectedValue dbEncryptionKey;

  Meta(this.appVersion, this.sqlCipherVersion, this.dbInstance,
      this.dbEncryptionKey);
}
