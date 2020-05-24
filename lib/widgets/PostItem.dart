import 'package:flutter/material.dart';
import 'package:followMe/models/Post.dart';
import 'package:followMe/providers/AuthService.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostItem extends StatelessWidget {
  final String user;
  final String userdp;
  final String post1;
  final DateTime postDate;

  PostItem({this.post1, this.user, this.userdp, this.postDate});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen: false);
    final post = Provider.of<Post>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Card(
        elevation: 5,
        shadowColor: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(userdp),
                    backgroundColor: Colors.grey,
                    child: userdp.isEmpty
                        ? Text(
                            user.substring(0, 1),
                            style: TextStyle(fontSize: 25),
                          )
                        : null,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    user,
                    style: TextStyle(fontSize: 22),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Text(
                  post1,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Center(
                child: IconButton(
                    icon: Icon(
                      post.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.indigo,
                    ),
                    onPressed: () {
                      post.toggleFavorite(auth.token, auth.userId);
                    }),
              ),
              // SizedBox(
              //   height: 2,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    DateFormat.yMMMd().format(postDate),
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
