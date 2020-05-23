import 'package:flutter/material.dart';
import 'package:followMe/models/User.dart';
import 'package:followMe/providers/CurrentUser.dart';
import 'package:provider/provider.dart';

class DiscoverUsers extends StatefulWidget {
  @override
  _DiscoverUsersState createState() => _DiscoverUsersState();
}

class _DiscoverUsersState extends State<DiscoverUsers> {
  var _isLoading = false;
  // var _isfollow = false;

  // void _followToggle() {
  //   setState(() {
  //     _isfollow = !_isfollow;
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _isLoading = true;
    });
    Provider.of<CurrentUser>(context, listen: false)
        .fetchFollowingList()
        .then((_) {
      // print("here");
      Provider.of<CurrentUser>(context, listen: false)
          .fetchAllUsers()
          .then((_) {
        setState(() {
          _isLoading = false;
        });
        // print("now here");
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<User> _users = Provider.of<CurrentUser>(context).discoverUser;
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : _users.isEmpty
            ? Center(child: Text("You are alone here :( "))
            : ListView.builder(
                padding: EdgeInsets.only(left: 25.0, right: 20.0, top: 45.0),
                itemCount: _users.length,
                itemBuilder: (ctx, i) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Card(
                      margin: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 5,
                      ),
                      elevation: 8,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(_users[i].dpUrl),
                          backgroundColor: Colors.grey,
                          child: _users[i].dpUrl.isEmpty
                              ? Text(_users[i].name.substring(0, 1))
                              : null,
                        ),
                        title: Text(_users[i].name),
                        trailing: FlatButton(
                          onPressed: () {
                            Provider.of<CurrentUser>(context, listen: false)
                                .addFollower(_users[i].id, _users[i].name,
                                    _users[i].dpUrl);
                          },
                          child: Text(
                            "Follow",
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
  }
}
