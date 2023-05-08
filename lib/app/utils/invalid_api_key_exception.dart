class InvalidApiKeyException implements Exception {
  final String message;

  InvalidApiKeyException(this.message);

  @override
  String toString() => 'InvalidApiKeyException: $message';
}
