import 'package:flutter/material.dart';
import 'package:followMe/Screens/HomePage.dart';
import 'package:followMe/models/User.dart';
import 'package:followMe/models/http_exception.dart';
import 'package:followMe/providers/AuthService.dart';
import 'package:followMe/providers/CurrentUser.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isNew = false;
  String _name;
  String _email;
  String _password;
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  var _isLoading = false;

  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('An Error Occurred !'),
              content: Text(msg),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Okay"))
              ],
            ));
  }

  Future<void> _saveForm() async {
    if (!_form.currentState.validate()) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_isNew) {
        // Register
        await Provider.of<AuthService>(context, listen: false)
            .signup(_email, _password, _name);
        // String _id = Provider.of<AuthService>(context, listen: false).userId;
        // await Provider.of<CurrentUser>(context, listen: false)
        //     .addUser(User(id: _id, name: _name));
      } else {
        //login
        await Provider.of<AuthService>(context, listen: false)
            .login(_email, _password);
      }
    } on HttpException catch (error) {
      var errorMsg = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMsg = 'Email already in use !';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMsg = 'This is not a valid email address';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMsg = 'Could not find a user with that email';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMsg = 'Invalid Password';
      }
      _showErrorDialog(errorMsg);
    } catch (error) {
      const errorMsg = 'Could not authenticate. Please try again later.';
      _showErrorDialog(errorMsg);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _isNewToggle() {
    print(_isNew);
    setState(() {
      _isNew = !_isNew;
    });
    print(_isNew);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: Text('Follow',
                      style: TextStyle(
                          fontSize: 80.0, fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16.0, 185.0, 0.0, 0.0),
                  child: Text('Me',
                      style: TextStyle(
                          fontSize: 80.0, fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(130.0, 185.0, 0.0, 0.0),
                  child: Text('.',
                      style: TextStyle(
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor)),
                )
              ],
            ),
          ),
          Form(
            key: _form,
            child: Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    if (_isNew)
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'FULL NAME',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_emailFocusNode);
                        },
                        validator: (value) =>
                            value.isEmpty ? 'Name cannot be null' : null,
                        onSaved: (value) => _name = value.trim(),
                      ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'EMAIL',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      focusNode: _emailFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      },
                      maxLines: 1,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Invalid email';
                        }
                      },
                      onSaved: (value) => _email = value.trim(),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'PASSWORD',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      focusNode: _passwordFocusNode,
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty || value.length < 5) {
                          return 'Password is too short';
                        }
                      },
                      onSaved: (value) => _password = value.trim(),
                    ),
                    SizedBox(height: 40.0),
                    _isLoading
                        ? CircularProgressIndicator()
                        : Container(
                            height: 40.0,
                            child: GestureDetector(
                              onTap: () {
                                _saveForm();
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute<void>(
                                //     builder: (BuildContext context) {
                                //       return MyHomePage();
                                //     },
                                //   ),
                                // );
                              },
                              child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                shadowColor: Colors.indigoAccent,
                                color: Theme.of(context).primaryColor,
                                elevation: 7.0,
                                child: Center(
                                  child: Text(
                                    _isNew ? 'REGISTER' : 'LOGIN',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                    SizedBox(height: 20.0),
                  ],
                )),
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                _isNew ? 'Already Registered ?' : 'New Here ?',
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
              SizedBox(width: 10.0),
              InkWell(
                onTap: _isNewToggle,
                child: Text(
                  _isNew ? 'Login' : 'Register',
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}
