import 'dart:convert';

import 'package:cryptowl/src/common/encoding_util.dart';
import 'package:cryptowl/src/common/protected_value.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should return crockford base32 string', () async {
    final password = utf8.encode("hello world!");

    final str =
        EncodingUtil.encodeCrockfordBase32(ProtectedValue.fromBinary(password));

    expect(str, equals("D1JPR-V3F41-VPYWK-CCGGG"));
  });

  test('should return decoded key from crockford base32 string', () async {
    final password = utf8.encode("hello world!");
    final key1 = EncodingUtil.decodeCrockfordBase32("D1JP-RV3F-41VP-YWKC-CGGG");
    final key2 = EncodingUtil.decodeCrockfordBase32("D1JPRV3F41VPYWKCCGGG");

    expect(key1.binaryValue, equals(password));
    expect(key2.binaryValue, equals(password));
  });
}
