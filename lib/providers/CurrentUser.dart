import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:followMe/models/User.dart';
import 'package:http/http.dart' as http;

class CurrentUser with ChangeNotifier {
  final String authToken;
  // final String userId;
  // final String userName;
  CurrentUser(this.authToken);

//Putting posts in database
  Future<void> addUser(User user) async {
    final url =
        "https://followme-a0fcb.firebaseio.com/allUsers.json?auth=$authToken";

    try {
      final res = await http.post(url,
          body: json.encode({'id': user.id, 'name': user.name}));
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
