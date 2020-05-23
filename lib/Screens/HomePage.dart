import 'package:flutter/material.dart';
import 'package:followMe/models/Post.dart';
import 'package:followMe/models/User.dart';
import 'package:followMe/providers/CurrentUser.dart';
import 'package:followMe/providers/Posts.dart';
import 'package:followMe/widgets/CustomAppBar.dart';
import 'package:followMe/widgets/LoadingSpinner.dart';
import 'package:provider/provider.dart';
import './DiscoverScreen.dart';
import './PostsScreen.dart';
import './ProfileScreen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> _pages = [
    DiscoverScreen(),
    PostsScreen(),
    ProfileScreen(),
  ];
  int _selectedPageIndex = 1;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  User _user;
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<CurrentUser>(context, listen: false).getCurrentUser().then((_) {
      _user = Provider.of<CurrentUser>(context, listen: false).currentUser;
    });

    super.initState();
  }

  var _isLoading = false;

  final myController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: _isLoading ? LoadingSpinner() : _pages[_selectedPageIndex],
      floatingActionButton: _selectedPageIndex == 1
          ? FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Add Post"),
                      content: TextField(
                        decoration:
                            InputDecoration(labelText: "What's on your mind"),
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
                          onPressed: () {
                            setState(() {
                              _isLoading = true;
                            });
                            Provider.of<Posts>(context, listen: false)
                                .addPost(
                              Post(
                                  post: myController.text,
                                  user: _user.name,
                                  userdp: _user.dpUrl,
                                  postDate: DateTime.now()),
                            )
                                .then((value) {
                              setState(() {
                                _isLoading = false;
                              });
                            });
                            myController.text = "";
                            Navigator.of(context).pop();
                          },
                          label: Text("Post"),
                          icon: Icon(Icons.call_made),
                        )
                      ],
                    );
                  },
                );
              },
              child: Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: CurvedNavigationBar(
        // key: _bottomNavigationKey,
        color: Theme.of(context).primaryColor,
        height: 50,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Theme.of(context).accentColor,
        index: 1,
        items: <Widget>[
          Icon(Icons.group_add, size: 30),
          Icon(Icons.home, size: 30),
          Icon(Icons.account_circle, size: 30),
        ],
        animationDuration: Duration(milliseconds: 200),
        animationCurve: Curves.bounceInOut,
        onTap: _selectPage,
      ),
    );
  }
}
