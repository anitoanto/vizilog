import 'package:flutter/material.dart';
import 'package:vizilog/service/auth.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Text("Hello this is home page"),
              ElevatedButton(
                  onPressed: () async {
                    await _authService.signOut();
                    
                  },
                  child: Text("SignOut"))
            ],
          ),
        ),
      ),
    );
  }
}
