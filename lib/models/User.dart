import 'dart:io';

import 'package:flutter/cupertino.dart';

class User with ChangeNotifier {
  final String id;
  final String name;
  // final String bdate;
  // final String bio;
  // final String education;
  // final String role;
  final String dbId;
  String dpUrl;

  User(
      {@required this.id,
      @required this.name,
      // this.bio,
      this.dbId,
      // this.bdate,
      // this.education,
      // this.role,
      this.dpUrl});
}
