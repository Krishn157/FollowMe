class HttpException implements Exception {
  final String msg;
  HttpException(this.msg);

  @override
  String toString() {
    // TODO: implement toString
    // return super.toString();
    return msg;
  }
}
