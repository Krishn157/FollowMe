import 'package:flutter/material.dart';
import 'package:followMe/widgets/AllPosts.dart';
import 'package:followMe/widgets/CustomAppBar.dart';
import 'package:followMe/widgets/CustomAppBar2.dart';
import 'package:followMe/widgets/MyPosts.dart';

class MyPostsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomAppBar2("My Posts"),
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
              child: MyPosts(),
            ),
          ),
        ),
      ],
    );
  }
}
