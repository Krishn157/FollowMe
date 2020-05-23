import 'package:flutter/material.dart';
import 'package:followMe/widgets/CustomAppBar2.dart';
import 'package:followMe/widgets/FollowersList.dart';

class FollowersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: <Widget>[
          CustomAppBar2("Followers"),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(75.0),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(75.0),
                ),
                child: FollowersList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
