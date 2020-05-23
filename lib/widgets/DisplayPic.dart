import 'dart:io';

import 'package:flutter/material.dart';
import 'package:followMe/models/Post.dart';
import 'package:followMe/models/User.dart';
import 'package:followMe/providers/CurrentUser.dart';
import 'package:followMe/providers/Posts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class DisplayPic extends StatefulWidget {
  @override
  _DisplayPicState createState() => _DisplayPicState();
}

class _DisplayPicState extends State<DisplayPic> {
  File _pickedImage;
  var _isLoading = false;
  User current;
  @override
  void initState() {
    // TODO: implement initState
    current = Provider.of<CurrentUser>(context, listen: false).currentUser;
    super.initState();
  }

  void _pickImage() async {
    final pickedImageFile =
        await ImagePicker.pickImage(source: ImageSource.gallery);

    print('uploading');
    setState(() {
      _isLoading = true;
    });
    await Provider.of<CurrentUser>(context, listen: false)
        .updateDp(pickedImageFile, current.name, current.dbId);
    setState(() {
      _isLoading = false;
      _pickedImage = pickedImageFile;
    });
    Provider.of<Posts>(context, listen: false).fetchAndSetPosts(true).then((_) {
      List<Post> _posts = Provider.of<Posts>(context, listen: false).posts;
      _posts.forEach((element) async {
        await Provider.of<Posts>(context, listen: false)
            .updatePostPic(element.id, current.dpUrl);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          // backgroundImage: AssetImage('assets/images/kisu.jpg'),
          // backgroundColor: Colors.brown.shade800,
          // child: Text('AH'),
          // backgroundImage: _pickedImage != null
          //     ? FileImage(_pickedImage)
          //     : NetworkImage(current.dpUrl),
          backgroundImage: NetworkImage(current.dpUrl),
          backgroundColor: Colors.grey,
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : current.dpUrl.isEmpty
                  ? Text(
                      current.name.substring(0, 1),
                      style: TextStyle(fontSize: 100),
                    )
                  : null,
          radius: 80,
        ),
        FlatButton.icon(
          textColor: Theme.of(context).accentColor,
          onPressed: _pickImage,
          icon: Icon(Icons.camera_front),
          label: Text("Change DP"),
        ),
      ],
    );
  }
}
