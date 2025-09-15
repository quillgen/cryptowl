import 'dart:convert';

import 'package:cryptowl/src/common/argon2.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:native_argon2/native_argon2_bindings_generated.dart';

void main() {
  test('should return argon2 arguments from encoded string', () async {
    final args = Argon2Arguments.parse(
        "\$argon2id\$v=19\$m=36,t=2,p=2\$ZHJAcmlndXouY29t\$hKxpGm8mI6BUUB9bofN944EXwzGI1dr2HM8H0+wK40Y");
    expect(args.type, Argon2_type.Argon2_id);
    expect(args.version, 19);
    expect(args.memory, 36);
    expect(args.parallelism, 2);
    expect(args.salt, utf8.encode("dr@riguz.com"));
  });
}
