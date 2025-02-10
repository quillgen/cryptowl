import 'dart:typed_data';

import 'package:kdbx/kdbx.dart';

class Argon2Util {
  static const argon2 = PointyCastleArgon2();
  static Future<Uint8List> deriveKey(Argon2Arguments args) async {
    return argon2.argon2Async(args);
  }
}
