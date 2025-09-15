class AppConfig {
  final String version;
  final ConfigData data;
  final String hash;

  AppConfig({
    required this.version,
    required this.data,
    required this.hash,
  });

  factory AppConfig.fromJson(Map<String, dynamic> json) {
    return AppConfig(
      version: json['version'] as String,
      data: ConfigData.fromJson(json['data'] as Map<String, dynamic>),
      hash: json['hash'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'data': data.toJson(),
      'hash': hash,
    };
  }
}

class ConfigData {
  final String db;
  final DateTime createdAt;
  final DateTime updatedAt;
  final KdfParams kdf;
  final String seed;

  ConfigData({
    required this.db,
    required this.createdAt,
    required this.updatedAt,
    required this.kdf,
    required this.seed,
  });

  factory ConfigData.fromJson(Map<String, dynamic> json) {
    return ConfigData(
      db: json['db'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      kdf: KdfParams.fromJson(json['kdf'] as Map<String, dynamic>),
      seed: json['seed'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'db': db,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'kdf': kdf.toJson(),
      'seed': seed,
    };
  }
}

class KdfParams {
  final String algorithm;
  final int m;
  final int t;
  final int p;

  KdfParams({
    required this.algorithm,
    required this.m,
    required this.t,
    required this.p,
  });

  factory KdfParams.fromJson(Map<String, dynamic> json) {
    return KdfParams(
      algorithm: json['algorithm'] as String,
      m: json['m'] as int,
      t: json['t'] as int,
      p: json['p'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'algorithm': algorithm,
      'm': m,
      't': t,
      'p': p,
    };
  }
}
