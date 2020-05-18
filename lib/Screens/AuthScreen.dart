import 'package:flutter/material.dart';
import 'package:followMe/Screens/HomePage.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isNew = false;
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _saveForm() {
    _form.currentState.save();
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
                      textInputAction: TextInputAction.next,
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
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                    ),
                    SizedBox(height: 40.0),
                    Container(
                      height: 40.0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) {
                                return MyHomePage();
                              },
                            ),
                          );
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
          SizedBox(height: 15.0),
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
