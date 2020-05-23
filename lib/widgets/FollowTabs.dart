import 'package:flutter/material.dart';
import 'package:followMe/Screens/FollowersScreen.dart';
import 'package:followMe/Screens/FollowingScreen.dart';
import 'package:followMe/models/User.dart';
import 'package:followMe/providers/CurrentUser.dart';
import 'package:provider/provider.dart';

class FollowTabs extends StatefulWidget {
  @override
  _FollowTabsState createState() => _FollowTabsState();
}

class _FollowTabsState extends State<FollowTabs> {
  // var _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    // setState(() {
    //   _isLoading = true;
    // });
    // Provider.of<CurrentUser>(context, listen: false)
    //     .fetchFollowingList()
    //     .then((value) {
    //   setState(() {
    //     _isLoading = false;
    //   });
    // });
    Provider.of<CurrentUser>(context, listen: false).fetchFollowingList();
    Provider.of<CurrentUser>(context, listen: false).fetchFollowersList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<User> _users = Provider.of<CurrentUser>(context).following;
    final no_of_following = _users.length;
    List<User> _user2 = Provider.of<CurrentUser>(context).followers;
    final no_of_followers = _user2.length;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        // _isLoading
        //     ? Center(child: CircularProgressIndicator())
        //     :
        Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
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
                'Following : ' +
                    (no_of_following != 0 ? no_of_following.toString() : '_'),
                style: (TextStyle(
                    fontSize: 20, color: Theme.of(context).accentColor)),
              ),
            ),
          ),
        ),
        Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
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
                'Followers : ' +
                    (no_of_followers != 0 ? no_of_followers.toString() : '_'),
                style: (TextStyle(
                    fontSize: 20, color: Theme.of(context).accentColor)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
