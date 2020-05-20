import 'package:flutter/material.dart';
import 'package:followMe/Screens/AuthScreen.dart';
import 'package:followMe/Screens/HomePage.dart';
import 'package:followMe/providers/AuthService.dart';
import 'package:followMe/providers/CurrentUser.dart';
import 'package:followMe/providers/Posts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthService()),
        ChangeNotifierProxyProvider<AuthService, Posts>(
          create: null,
          update: (ctx, auth, prevPosts) => Posts(auth.token, auth.userId,
              prevPosts == null ? [] : prevPosts.posts),
        ),
        // ChangeNotifierProxyProvider<AuthService, CurrentUser>(
        //   create: null,
        //   update: (ctx, auth, prev) => CurrentUser(auth.token),
        // ),
      ],
      child: Consumer<AuthService>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            accentColor: Colors.amber,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: auth.isAuth
              ? MyHomePage()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? Container(width: 0.0, height: 0.0)
                          : AuthScreen(),
                ),
        ),
      ),
    );
  }
}
