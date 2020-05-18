import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: _pages[_selectedPageIndex],
      floatingActionButton: _selectedPageIndex == 1
          ? FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Add Post"),
                      content: TextFormField(
                        decoration:
                            InputDecoration(labelText: "What's on your mind"),
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                      ),
                      actions: <Widget>[
                        FlatButton.icon(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.cancel),
                            label: Text("Cancel")),
                        FlatButton.icon(
                          onPressed: () {},
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
