import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Post with ChangeNotifier {
  final String user;
  final String post;
  final String id;
  final String userdp;
  final DateTime postDate;
  bool isFavorite;

  Post({
    @required this.user,
    @required this.post,
    this.id,
    this.userdp,
    this.postDate,
    this.isFavorite = false,
  });

  Future<void> toggleFavorite(String token, String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    print(isFavorite);
    notifyListeners();
    final url =
        "https://followme-a0fcb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token";
    try {
      await http.put(
        url,
        body: json.encode(isFavorite),
      );
    } catch (error) {
      isFavorite = oldStatus;
    }
  }
}
