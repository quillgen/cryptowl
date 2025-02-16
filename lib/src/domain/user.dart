import 'package:flutter/foundation.dart';
import 'package:kdbx/kdbx.dart';

import '../config/meta.dart';

@immutable
class User {
  final Meta meta;
  final ProtectedValue password;

  const User(this.meta, this.password);
}
