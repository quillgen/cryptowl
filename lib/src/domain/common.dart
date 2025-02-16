enum EncryptType {
  none(0),
  aes(1);

  final int value;

  const EncryptType(this.value);

  static EncryptType getByValue(num i) {
    return EncryptType.values.firstWhere((x) => x.value == i);
  }
}
