import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:followMe/models/User.dart';
import 'package:http/http.dart' as http;

class CurrentUser with ChangeNotifier {
  final String authToken;
  final String userId;
  // final String userName;
  CurrentUser(this.authToken, this.userId);

  User _currentUser;
  List<User> _discoverUsers = [];
  List<User> _following = [];
  List<User> _followers = [];

  User get currentUser {
    return _currentUser;
  }

  List<User> get discoverUser {
    print("discover");
    return [..._discoverUsers];
  }

  List<User> get following {
    return [..._following];
  }

  List<User> get followers {
    return [..._followers];
  }

  List<String> _followingIds = [];

  List<String> get followingIds {
    _followingIds = _following.map((e) => e.id).toList();
    print("here");
    print(_followingIds);
    return [..._followingIds];
  }

  Future<void> getCurrentUser() async {
    final url =
        'https://followme-a0fcb.firebaseio.com/allUsers.json?auth=$authToken&orderBy="id"&equalTo="$userId"';
    try {
      final res = await http.get(url);
      // print(res.body);
      User loadedUser;
      final extractedData = json.decode(res.body) as Map<String, dynamic>;
      extractedData.forEach((key, value) {
        loadedUser = User(
            id: value["id"],
            dbId: key,
            name: value["name"],
            dpUrl: value["dp"]);
      });
      print(loadedUser.name);
      _currentUser = loadedUser;
    } catch (error) {
      throw (error);
    }
  }

  Future<void> updateDp(File dp, String username, String key) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('user_Dps')
        .child(username + '.jpg');
    await ref.putFile(dp).onComplete;
    final dpurl = await ref.getDownloadURL();
    _currentUser.dpUrl = dpurl;
    final url =
        'https://followme-a0fcb.firebaseio.com/allUsers/$key.json?auth=$authToken';
    try {
      await http.patch(url, body: json.encode({'dp': dpurl}));
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchAllUsers() async {
    final url =
        'https://followme-a0fcb.firebaseio.com/allUsers.json?auth=$authToken';
    try {
      final res = await http.get(url);
      final extractedData = json.decode(res.body) as Map<String, dynamic>;
      final List<User> loadedUsers = [];
      if (extractedData != null) {
        extractedData.forEach((key, value) {
          // print("idhr h");
          if (!followingIds.contains(value["id"]) || _following.isEmpty) {
            if (value["id"] != userId) {
              loadedUsers.insert(
                0,
                User(
                    id: value["id"],
                    dbId: key,
                    name: value["name"],
                    dpUrl: value["dp"]),
              );
            }
          } else {
            // if (value["id"] != userId) {
            //   loadedUsers.insert(
            //     0,
            //     User(
            //         id: value["id"],
            //         dbId: key,
            //         name: value["name"],
            //         dpUrl: value["dp"]),
            //   );
            // }
          }
        });
      }
      _discoverUsers = loadedUsers;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  void addFollower(String id, String name, String dp) async {
    final url =
        'https://followme-a0fcb.firebaseio.com/followList.json?auth=$authToken';
    _discoverUsers.removeWhere((user) => user.id == id);
    notifyListeners();
    try {
      final res = http.post(url,
          body: json.encode({
            'followerId': userId,
            'followerName': currentUser.name,
            'followerDp': currentUser.dpUrl,
            'followingId': id,
            'followingName': name,
            'followingDp': dp
          }));
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> fetchFollowingList() async {
    final url =
        'https://followme-a0fcb.firebaseio.com/followList.json?auth=$authToken&orderBy="followerId"&equalTo="$userId"';
    try {
      final res = await http.get(url);
      final extractedData = json.decode(res.body) as Map<String, dynamic>;
      final List<User> loadedUsers = [];
      if (extractedData != null) {
        extractedData.forEach((key, value) {
          loadedUsers.insert(
              0,
              User(
                  dbId: key,
                  id: value["followingId"],
                  name: value["followingName"],
                  dpUrl: value["followingDp"]));
        });
      }
      // print(res.body);
      _following = loadedUsers;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> fetchFollowersList() async {
    final url =
        'https://followme-a0fcb.firebaseio.com/followList.json?auth=$authToken&orderBy="followingId"&equalTo="$userId"';
    try {
      final res = await http.get(url);
      final extractedData = json.decode(res.body) as Map<String, dynamic>;
      final List<User> loadedUsers = [];
      if (extractedData != null) {
        extractedData.forEach((key, value) {
          loadedUsers.insert(
              0,
              User(
                  id: value["followerId"],
                  name: value["followerName"],
                  dpUrl: value["followerDp"]));
        });
      }
      // print(res.body);
      _followers = loadedUsers;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  void unfollow(String id) async {
    final url =
        'https://followme-a0fcb.firebaseio.com/followList/$id.json?auth=$authToken';
    http.delete(url);
    _following.removeWhere((element) => element.dbId == id);
    print("idhr hai");
    notifyListeners();
  }
}
