import 'package:flutter/material.dart';
import 'package:followMe/widgets/DiscoverUsers.dart';
import '../widgets/CustomAppBar.dart';

class DiscoverScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomAppBar("Discover"),
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
              child: DiscoverUsers(),
            ),
          ),
        ),
      ],
    );
  }
}
