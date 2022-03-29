class Failure {
  const Failure({
    required this.errorMessage,
    this.errorCode,
  });
  final String errorMessage;
  final String? errorCode;
}
