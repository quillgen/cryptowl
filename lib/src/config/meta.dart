import 'package:flutter/material.dart';
import 'package:kdbx/kdbx.dart';

@immutable
class Meta {
  final String appVersion;
  final String sqlCipherVersion;
  final String dbInstance;
  final ProtectedValue dbEncryptionKey;

  const Meta(this.appVersion, this.sqlCipherVersion, this.dbInstance,
      this.dbEncryptionKey);
}
