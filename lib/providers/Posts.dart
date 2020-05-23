import 'package:flutter/cupertino.dart';
import 'package:followMe/models/Post.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Posts with ChangeNotifier {
  List<Post> _posts = [
    // Post(
    //     post:
    //         "Sample post by Krishn Kumar. I don't know what to say but had to say something just to have some content see ya !"),
    // Post(
    //     post:
    //         "Sample post by Krishn Kumar. I don't know what to say but had to say something just to have some content see ya !"),
    // Post(
    //     post:
    //         "Sample post by Krishn Kumar. I don't know what to say but had to say something just to have some content see ya !"),
    // Post(
    //     post:
    //         "Sample post by Krishn Kumar. I don't know what to say but had to say something just to have some content see ya !"),
    // Post(
    //     post:
    //         "Sample post by Krishn Kumar. I don't know what to say but had to say something just to have some content see ya !"),
    // Post(
    //     post:
    //         "Sample post by Krishn Kumar. I don't know what to say but had to say something just to have some content see ya !"),
  ];

  // Posts(this._posts);

  List<Post> get posts {
    return [..._posts];
  }

  final String authToken;
  final String userId;
  // final List<String> ids;
  Posts(this.authToken, this.userId, this._posts);

//Putting posts in database
  Future<void> addPost(Post post) async {
    final url =
        "https://followme-a0fcb.firebaseio.com/allPosts.json?auth=$authToken";

    try {
      final res = await http.post(
        url,
        body: json.encode(
          {
            'post': post.post,
            'user': post.user,
            'creatorId': userId,
            'userpic': post.userdp,
            'postDate': post.postDate.toIso8601String(),
          },
        ),
      );
      final newPost = Post(
          post: post.post,
          user: post.user,
          id: json.decode(res.body)['name'],
          postDate: post.postDate);
      _posts.insert(0, newPost);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

//Fetch Posts
  Future<void> fetchAndSetPosts([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    final url =
        'https://followme-a0fcb.firebaseio.com/allPosts.json?auth=$authToken&$filterString';
    try {
      final res = await http.get(url);

      final extractedData = json.decode(res.body) as Map<String, dynamic>;
      final List<Post> loadedPosts = [];

      if (extractedData != null) {
        extractedData.forEach((postId, postData) {
          loadedPosts.insert(
            0,
            Post(
                id: postId,
                user: postData["user"],
                post: postData["post"],
                postDate: DateTime.parse(postData["postDate"]),
                userdp: postData["userpic"]),
          );
        });
      }

      _posts = loadedPosts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  //Update Posts
  Future<void> updatePosts(String id, Post newPost) async {
    final postIndex = _posts.indexWhere((post) => post.id == id);
    if (postIndex >= 0) {
      final url =
          "https://followme-a0fcb.firebaseio.com/allPosts/$id.json?auth=$authToken";
      await http.patch(url, body: json.encode({'post': newPost.post}));
      _posts[postIndex] = newPost;
      notifyListeners();
    } else {
      print('...');
    }
  }

  //Update Posts userpic
  Future<void> updatePostPic(String id, String dpurl) async {
    final postIndex = _posts.indexWhere((post) => post.id == id);
    if (postIndex >= 0) {
      final url =
          "https://followme-a0fcb.firebaseio.com/allPosts/$id.json?auth=$authToken";
      await http.patch(url, body: json.encode({'userpic': dpurl}));
      notifyListeners();
    } else {
      print('...');
    }
  }

  //Delete Posts
  void deletePosts(String id) async {
    final url =
        "https://followme-a0fcb.firebaseio.com/allPosts/$id.json?auth=$authToken";
    http.delete(url);
    _posts.removeWhere((post) => post.id == id);
    notifyListeners();
  }
}
