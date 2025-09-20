class IncorrectPasswordException implements Exception {}

class CorruptedConfigException implements Exception {
  String cause;
  CorruptedConfigException(this.cause);
}
