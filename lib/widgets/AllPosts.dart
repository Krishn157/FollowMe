import 'package:flutter/material.dart';
import 'package:followMe/models/Post.dart';
import 'package:followMe/providers/Posts.dart';
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
        : RefreshIndicator(
            onRefresh: () => _refresh(context),
            child: ListView.builder(
              padding: EdgeInsets.only(left: 25.0, right: 20.0, top: 45.0),
              itemCount: _posts.length,
              itemBuilder: (ctx, i) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(Icons.account_circle),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                _posts[i].user,
                                style: TextStyle(fontSize: 22),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              _posts[i].post,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "On : 23rd May, 2020",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 13),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }
}
