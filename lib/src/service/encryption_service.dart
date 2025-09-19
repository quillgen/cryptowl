import 'dart:convert';

import '../crypto/protected_value.dart';
import '../domain/password.dart';

class EncryptionService {
  Future<String> encryptPassword(
      int classification, ProtectedValue plain) async {
    switch (classification) {
      case CONFIDENTIAL:
        return base64.encode(plain.binaryValue);
      case TOP_SECRET:
      default:
        return "";
    }
  }
}
