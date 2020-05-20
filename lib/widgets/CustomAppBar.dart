import 'package:flutter/material.dart';
import 'package:followMe/providers/AuthService.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  CustomAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(40, 50, 20, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(title,
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0)),
          SizedBox(width: 10.0),
          IconButton(
              tooltip: 'Log Out',
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Provider.of<AuthService>(context, listen: false).logout();
              }),
        ],
      ),
    );
  }
}
