import 'package:flutter/cupertino.dart';

class Post with ChangeNotifier {
  final String user;
  final String post;
  final String id;
  final String userdp;
  final DateTime postDate;

  Post(
      {@required this.user,
      @required this.post,
      this.id,
      this.userdp,
      this.postDate});
}
