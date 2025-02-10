import 'package:uuid/data.dart';
import 'package:uuid/rng.dart';
import 'package:uuid/uuid.dart';

class UuidUtil {
  static final _uuid = Uuid(goptions: GlobalOptions(CryptoRNG()));

  static String generateUUID() {
    return _uuid.v4();
  }
}
