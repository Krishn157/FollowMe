import 'package:flutter/cupertino.dart';

class Post with ChangeNotifier {
  final String user;
  final String post;
  final String id;

  Post({this.user = "Krishn", @required this.post, this.id});
}
