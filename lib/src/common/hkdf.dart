import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:cryptowl/src/common/protected_value.dart';

class HKDF {
  static ProtectedValue deriveKey({
    required ProtectedValue ikm,
    Uint8List? salt,
    Uint8List? info,
    int outputLength = 64,
  }) {
    final _salt = salt ?? Uint8List(0);
    final hmac = Hmac(sha256, _salt);
    final prk = hmac.convert(ikm.binaryValue).bytes;

    final t = <Uint8List>[];
    final okm = <int>[];
    final infoBytes = info ?? Uint8List(0);
    int i = 1;
    while (okm.length < outputLength) {
      // T(i) = HMAC-Hash(PRK, T(i-1) | info | i)
      final input = Uint8List.fromList(
          (t.isEmpty ? Uint8List(0) : t.last) + infoBytes + [i]);
      final hmacExpand = Hmac(sha256, prk);
      t.add(Uint8List.fromList(hmacExpand.convert(input).bytes));
      okm.addAll(t.last);
      i++;
    }

    return ProtectedValue.fromBinary(
        Uint8List.fromList(okm.sublist(0, outputLength)));
  }
}
