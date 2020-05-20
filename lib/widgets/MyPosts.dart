import 'package:flutter/material.dart';
import 'package:followMe/models/Post.dart';
import 'package:followMe/widgets/LoadingSpinner.dart';
import 'package:provider/provider.dart';
import '../providers/Posts.dart';

class MyPosts extends StatefulWidget {
  const MyPosts({
    Key key,
  }) : super(key: key);

  @override
  _MyPostsState createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
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

  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<Post> _posts = Provider.of<Posts>(context).posts;

    return _isLoading
        ? LoadingSpinner()
        : ListView.builder(
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
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(_posts[i].post),
                        ),
                        ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: const Text('EDIT'),
                              onPressed: () {
                                myController.text = _posts[i].post;
                                print(_posts[i].id);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Edit"),
                                      content: TextField(
                                        decoration: InputDecoration(
                                            labelText: "Edit your post"),
                                        maxLines: 3,
                                        keyboardType: TextInputType.multiline,
                                        controller: myController,
                                      ),
                                      actions: <Widget>[
                                        FlatButton.icon(
                                            onPressed: () {
                                              myController.text = "";
                                              Navigator.of(context).pop();
                                            },
                                            icon: Icon(Icons.cancel),
                                            label: Text("Cancel")),
                                        FlatButton.icon(
                                          onPressed: () async {
                                            Navigator.of(context).pop();
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            await Provider.of<Posts>(context,
                                                    listen: false)
                                                .updatePosts(
                                              _posts[i].id,
                                              Post(post: myController.text),
                                            );
                                            setState(() {
                                              _isLoading = false;
                                            });
                                            myController.text = "";
                                          },
                                          label: Text("Edit"),
                                          icon: Icon(Icons.call_made),
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            FlatButton(
                              child: const Text(
                                'DELETE',
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {
                                Provider.of<Posts>(context, listen: false)
                                    .deletePosts(_posts[i].id);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
