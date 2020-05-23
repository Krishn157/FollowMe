import 'package:flutter/material.dart';
import 'package:followMe/models/User.dart';
import 'package:followMe/providers/CurrentUser.dart';
import 'package:provider/provider.dart';

class FollowingList extends StatefulWidget {
  @override
  _FollowingListState createState() => _FollowingListState();
}

class _FollowingListState extends State<FollowingList> {
  var _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _isLoading = true;
    });
    Provider.of<CurrentUser>(context, listen: false)
        .fetchFollowingList()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<User> _users = Provider.of<CurrentUser>(context).following;
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : _users.isEmpty
            ? Center(
                child: Text("Let down your ego, and start following others ! "))
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
                            "Unfollow",
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
