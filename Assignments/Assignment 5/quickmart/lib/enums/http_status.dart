class HttpStatus {
  // Success
  static const ok = HttpStatus(200);
  static const created = HttpStatus(201);
  static const noContent = HttpStatus(204);


  // Client errors
  static const badRequest = HttpStatus(400);
  static const unauthorized = HttpStatus(401);
  static const forbidden = HttpStatus(403);
  static const notFound = HttpStatus(404);

  // Server errors
  static const internalServerError = HttpStatus(500);
  static const serviceUnavailable = HttpStatus(503);
  static const gatewayTimeout = HttpStatus(504);

  final int code;

  const HttpStatus(this.code);

  // override equality operator to enable == comparison with int
  @override
  bool operator ==(Object other) {
    if (other is int) {
      return code == other;
    }
    return super == other;
  }
}