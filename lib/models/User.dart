import 'package:flutter/cupertino.dart';

class User with ChangeNotifier {
  final String id;
  final String name;
  final String bdate;
  final String bio;
  final String education;
  final String role;

  User({
    @required this.id,
    @required this.name,
    this.bio,
    this.bdate,
    this.education,
    this.role,
  });
}
