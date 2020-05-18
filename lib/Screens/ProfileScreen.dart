import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:followMe/Screens/DiscoverScreen.dart';
import 'package:followMe/Screens/FollowersScreen.dart';
import 'package:followMe/Screens/FollowingScreen.dart';
import 'package:followMe/Screens/MyPostsScreen.dart';
import 'package:followMe/widgets/CustomAppBar.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CustomAppBar("Profile"),
        Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 125),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45.0),
                      topRight: Radius.circular(45.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Krishn Kumar",
                          style: TextStyle(
                              fontSize: 30,
                              color: Theme.of(context).primaryColor),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "⊂(◉‿◉)つ",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                              child: InkWell(
                                onTap: () {
                                  // print('Card tapped.');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) {
                                        return FollowingScreen();
                                      },
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    'Following : 5',
                                    style: (TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context).accentColor)),
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                              child: InkWell(
                                // splashColor: Theme.of(context).primaryColor,
                                onTap: () {
                                  // print('Card tapped.');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) {
                                        return FollowersScreen();
                                      },
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    'Followers : 50',
                                    style: (TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context).accentColor)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(Icons.date_range),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "15th July, 1999",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Icon(Icons.school),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "VIT University",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Icon(Icons.perm_identity),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Student",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 40.0,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) {
                                    return Scaffold(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      body: MyPostsScreen(),
                                    );
                                  },
                                ),
                              );
                            },
                            child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              shadowColor: Colors.indigoAccent,
                              color: Theme.of(context).primaryColor,
                              elevation: 7.0,
                              child: Center(
                                child: Text(
                                  "View Your Posts",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      fontFamily: 'Montserrat'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 100,
          left: (MediaQuery.of(context).size.width / 2) - 80.0,
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/kisu.jpg'),
            // backgroundColor: Colors.brown.shade800,
            // child: Text('AH'),
            radius: 80,
          ),
        )
      ],
    );
  }
}
