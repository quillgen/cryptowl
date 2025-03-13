import 'package:flutter/material.dart';

@immutable
class SqliteConfig {
  final String version;
  final String instance;
  final String kdfParameters;

  const SqliteConfig(this.version, this.instance, this.kdfParameters);
}
