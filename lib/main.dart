import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vizilog/pages/authenticate/important_details.dart';
import 'package:vizilog/pages/models/user_details.dart';
import 'package:vizilog/service/auth.dart';
import 'package:vizilog/wrapper.dart';

import 'wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserDetails>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
          title: 'ViziLog',
          theme:
              ThemeData(primarySwatch: Colors.blue, fontFamily: 'Montserrat'),
          home: Wrapper()),
    );
  }
}
