import 'dart:math';
import 'dart:typed_data';

import 'package:uuid/data.dart';
import 'package:uuid/rng.dart';
import 'package:uuid/uuid.dart';

class RandomUtil {
  static final _uuid = Uuid(goptions: GlobalOptions(CryptoRNG()));

  static String generateUUID() {
    return _uuid.v4();
  }

  static Uint8List generateSecureBytes(int length) {
    final random = Random.secure();
    return Uint8List.fromList(
        List.generate(length, (_) => random.nextInt(256)));
  }
}
