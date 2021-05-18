import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:vizilog/service/auth_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 90,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Welcome to ViziLog',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 33),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/welcome.jpeg',
                        width: 350,
                      )
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SignInButton(
                          Buttons.Google,
                          text: 'SIGN IN VIA GOOGLE',
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.deepPurple.shade900),
                          ),
                          onPressed: () {
                            signInWithGoogle();
                          },
                          padding: EdgeInsets.all(6),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 18),
                          child: Expanded(
                            child: GestureDetector(
                              child: Text(
                                'Not a member?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyHomePage()));
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
