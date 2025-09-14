import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:kdbx/kdbx.dart';
import 'package:native_argon2/native_argon2.dart';

class Argon2Util {
  static Future<Uint8List> deriveKey(Argon2Arguments args) async {
    final nativeArgon2 = NativeArgon2();
    final int hashLen = args.length;
    final Pointer<Uint8> hashStr = malloc.allocate<Uint8>(hashLen);

    var params = Argon2RawParams(
      tCost: args.iterations,
      mCost: args.memory,
      parallelism: args.parallelism,
      password: args.key,
      salt: args.salt,
      hashLen: args.length,
      hash: hashStr.cast<Void>(),
    );
    final int result;
    switch (args.type) {
      case ARGON2_i:
        result = nativeArgon2.argon2iHashRaw(params);
        break;
      case ARGON2_d:
        result = nativeArgon2.argon2dHashRaw(params);
        break;
      case ARGON2_id:
        result = nativeArgon2.argon2idHashRaw(params);
        break;
      default:
        throw ArgumentError('Invalid Argon2 type: ${args.type}');
    }
    if (result != 0) {
      malloc.free(hashStr);
      throw Exception('Argon2 hashing failed with error code: $result');
    }
    final uint8list = Uint8List.fromList(
      hashStr.cast<Uint8>().asTypedList(hashLen),
    );
    malloc.free(hashStr);
    return uint8list;
  }
}
