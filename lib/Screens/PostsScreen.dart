import 'package:flutter/material.dart';
import '../widgets/CustomAppBar.dart';
import '../widgets/AllPosts.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomAppBar("Feed"),
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
              child: AllPosts(),
            ),
          ),
        ),
      ],
    );
  }
}
