import 'package:flutter/material.dart';
import 'package:followMe/widgets/CustomAppBar2.dart';

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
                child: ListView(
                    padding:
                        EdgeInsets.only(left: 25.0, right: 20.0, top: 45.0),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Card(
                          margin: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 5,
                          ),
                          elevation: 8,
                          child: ListTile(
                            leading: Icon(Icons.account_circle),
                            title: Text("Krishn"),
                            trailing: FlatButton(
                              onPressed: () {},
                              child: Text(
                                "Follow",
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Card(
                          margin: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 5,
                          ),
                          elevation: 8,
                          child: ListTile(
                            leading: Icon(Icons.account_circle),
                            title: Text("Krishn"),
                            trailing: FlatButton(
                              onPressed: () {},
                              child: Text(
                                "Follow",
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Card(
                          margin: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 5,
                          ),
                          elevation: 8,
                          child: ListTile(
                            leading: Icon(Icons.account_circle),
                            title: Text("Krishn"),
                            trailing: FlatButton(
                              onPressed: () {},
                              child: Text(
                                "Follow",
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Card(
                          margin: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 5,
                          ),
                          elevation: 8,
                          child: ListTile(
                            leading: Icon(Icons.account_circle),
                            title: Text("Krishn"),
                            trailing: FlatButton(
                              onPressed: () {},
                              child: Text(
                                "Follow",
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Card(
                          margin: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 5,
                          ),
                          elevation: 8,
                          child: ListTile(
                            leading: Icon(Icons.account_circle),
                            title: Text("Krishn"),
                            trailing: FlatButton(
                              onPressed: () {},
                              child: Text(
                                "Follow",
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Card(
                          margin: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 5,
                          ),
                          elevation: 8,
                          child: ListTile(
                            leading: Icon(Icons.account_circle),
                            title: Text("Krishn"),
                            trailing: FlatButton(
                              onPressed: () {},
                              child: Text(
                                "Follow",
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Card(
                          margin: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 5,
                          ),
                          elevation: 8,
                          child: ListTile(
                            leading: Icon(Icons.account_circle),
                            title: Text("Krishn"),
                            trailing: FlatButton(
                              onPressed: () {},
                              child: Text(
                                "Follow",
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Card(
                          margin: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 5,
                          ),
                          elevation: 8,
                          child: ListTile(
                            leading: Icon(Icons.account_circle),
                            title: Text("Krishn"),
                            trailing: FlatButton(
                              onPressed: () {},
                              child: Text(
                                "Follow",
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Card(
                          margin: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 5,
                          ),
                          elevation: 8,
                          child: ListTile(
                            leading: Icon(Icons.account_circle),
                            title: Text("Krishn"),
                            trailing: FlatButton(
                              onPressed: () {},
                              child: Text(
                                "Follow",
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
