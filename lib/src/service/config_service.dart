import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:cryptowl/src/common/exceptions.dart';
import 'package:cryptowl/src/crypto/aead_crypto.dart';
import 'package:cryptowl/src/crypto/hmac.dart';
import 'package:cryptowl/src/crypto/protected_value.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logging/logging.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../config/app_config.dart';
import '../crypto/crockford_base32.dart';
import 'version_service.dart';

class ConfigService {
  final logger = Logger('ConfigService');
  final secureStore = FlutterSecureStorage();
  final hmac = CryptoHmac();

  final VersionService versionService;

  ConfigService(this.versionService);

  Future<AppConfig> loadConfig(String content) async {
    try {
      final jsonMap = jsonDecode(content) as Map<String, dynamic>;
      final config = AppConfig.fromJson(jsonMap);

      return config;
    } catch (e) {
      throw CorruptedConfigException('Failed to load config: $e');
    }
  }

  Future<bool> verifyConfig(AppConfig config, ProtectedValue macKey) async {
    final message = utf8.encode(json.encode(config.data.toJson()));
    final hash =
        await hmac.calculateMac(ProtectedValue.fromBinary(message), macKey);
    return hex.encode(CrockfordBase32.decode(config.hash).binaryValue) ==
        hex.encode(hash);
  }

  Future<AppConfig> createConfig(
      String instanceId,
      Uint8List transformSeed,
      Uint8List masterSeed,
      AuthEncryptedResult protectedSymmetricKey,
      ProtectedValue macKey,
      Uint8List nonce) async {
    final now = DateTime.now();
    final configData = ConfigData(
      instanceId: instanceId,
      createdAt: now,
      updatedAt: now,
      kdf: KdfParams(algorithm: "argon2id", m: 19, t: 2, p: 1),
      transformSeed: CrockfordBase32.encode(transformSeed),
      masterSeed: CrockfordBase32.encode(masterSeed),
      encryptedKey: CrockfordBase32.encode(protectedSymmetricKey.cipherData),
      authTag: CrockfordBase32.encode(protectedSymmetricKey.authTag),
      nonce: CrockfordBase32.encode(nonce),
    );

    final message = utf8.encode(json.encode(configData..toJson()));
    final hash =
        await hmac.calculateMac(ProtectedValue.fromBinary(message), macKey);
    return AppConfig(
        version: await versionService.getPackageVersion(),
        data: configData,
        hash: CrockfordBase32.encode(hash));
  }

  Future<String> saveConfig(AppConfig config) async {
    final jsonString = jsonEncode(config.toJson());
    return jsonString;
  }

  Future<ProtectedValue?> readSecureStore(String key) async {
    String? value = await secureStore.read(key: key);
    if (value != null) {
      return CrockfordBase32.decode(value);
    }
    return null;
  }

  Future<void> saveSecureStore(String key, ProtectedValue data) async {
    await secureStore.write(
        key: key, value: CrockfordBase32.encodeProtected(data));
  }

  Future<Uint8List> generateEmergencyKit(String secretKey) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Center(
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text(
                'SECRET KEY BACKUP',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Generated on: ${DateTime.now().toString()}',
                style: const pw.TextStyle(fontSize: 12),
              ),
              pw.Divider(),
              pw.Text(
                secretKey,
                style: pw.TextStyle(
                  fontSize: 18,
                  font: pw.Font.courier(), // Monospace font
                ),
              ),
              pw.SizedBox(height: 30),
              pw.Text(
                '⚠️ Keep this key secure! Do not share it.',
                style: pw.TextStyle(color: PdfColors.red),
              ),
            ],
          ),
        ),
      ),
    );

    return pdf.save();
  }
}
