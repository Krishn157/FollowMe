import 'package:flutter/material.dart';
import 'package:followMe/models/Post.dart';
import 'package:followMe/providers/AuthService.dart';
import 'package:followMe/providers/Posts.dart';
import 'package:followMe/widgets/PostItem.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AllPosts extends StatefulWidget {
  @override
  _AllPostsState createState() => _AllPostsState();
}

class _AllPostsState extends State<AllPosts> {
  var _isLoading = false;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });

    // TODO: implement initState
    Provider.of<Posts>(context, listen: false).fetchAndSetPosts().then((_) {
      setState(() {
        _isLoading = false;
      });
    });

    super.initState();
  }

  Future<void> _refresh(BuildContext context) async {
    await Provider.of<Posts>(context, listen: false).fetchAndSetPosts();
  }

  @override
  Widget build(BuildContext context) {
    List<Post> _posts = Provider.of<Posts>(context).posts;
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : _posts.isEmpty
            ? Center(child: Text("No Posts yet !"))
            : RefreshIndicator(
                onRefresh: () => _refresh(context),
                child: ListView.builder(
                    padding:
                        EdgeInsets.only(left: 25.0, right: 20.0, top: 45.0),
                    itemCount: _posts.length,
                    itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                          value: Post(
                              user: _posts[i].user,
                              post: _posts[i].post,
                              id: _posts[i].id,
                              isFavorite: _posts[i].isFavorite,
                              userdp: _posts[i].userdp,
                              postDate: _posts[i].postDate),
                          child: PostItem(
                            post1: _posts[i].post,
                            postDate: _posts[i].postDate,
                            user: _posts[i].user,
                            userdp: _posts[i].userdp,
                          ),
                        )),
              );
  }
}
