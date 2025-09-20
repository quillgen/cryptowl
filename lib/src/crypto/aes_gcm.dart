import 'dart:typed_data';

import 'package:cryptography/cryptography.dart' as cg;
import 'package:cryptowl/src/crypto/protected_value.dart';

class EcnryptedData {
  final Uint8List data;
  final Uint8List authTag;

  EcnryptedData(this.data, this.authTag);
}

abstract class AesGcm {
  Future<EcnryptedData> encrypt(
      ProtectedValue data, ProtectedValue key, Uint8List nonce, Uint8List? aad);
  Future<ProtectedValue> decrypt(EcnryptedData encryptedData,
      ProtectedValue key, Uint8List nonce, Uint8List? aad);
}

class CryptographyAesGcm extends AesGcm {
  final algorithm = cg.AesGcm.with256bits();

  @override
  Future<EcnryptedData> encrypt(ProtectedValue data, ProtectedValue key,
      Uint8List nonce, Uint8List? aad) async {
    final secretKey = cg.SecretKey(key.binaryValue);

    final secretBox = await algorithm.encrypt(
      data.binaryValue,
      secretKey: secretKey,
      nonce: nonce,
      aad: aad ?? Uint8List(0),
    );
    return EcnryptedData(
        secretBox.cipherText as Uint8List, secretBox.mac.bytes as Uint8List);
  }

  @override
  Future<ProtectedValue> decrypt(EcnryptedData encryptedData,
      ProtectedValue key, Uint8List nonce, Uint8List? aad) async {
    final secretKey = cg.SecretKey(key.binaryValue);
    final secretBox = cg.SecretBox(encryptedData.data,
        nonce: nonce, mac: cg.Mac(encryptedData.authTag));
    final clearText = await algorithm.decrypt(
      secretBox,
      secretKey: secretKey,
      aad: aad ?? Uint8List(0),
    );
    return ProtectedValue.fromBinary(clearText as Uint8List);
  }
}
