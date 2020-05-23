import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:followMe/Screens/FollowersScreen.dart';
import 'package:followMe/Screens/FollowingScreen.dart';
import 'package:followMe/Screens/MyPostsScreen.dart';
import 'package:followMe/models/User.dart';
import 'package:followMe/providers/CurrentUser.dart';
import 'package:followMe/widgets/CustomAppBar.dart';
import 'package:followMe/widgets/DisplayPic.dart';
import 'package:followMe/widgets/FollowTabs.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User current = Provider.of<CurrentUser>(context, listen: false).currentUser;

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
                    padding: const EdgeInsets.only(top: 200),
                    child: Column(
                      children: <Widget>[
                        Text(
                          current.name,
                          style: TextStyle(
                              fontSize: 30,
                              color: Theme.of(context).primaryColor),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 30),
                        FollowTabs(),
                        SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 35.0,
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
                                      fontSize: 16,
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
          child: DisplayPic(),
        ),
      ],
    );
  }
}
