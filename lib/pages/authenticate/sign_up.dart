import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vizilog/pages/authenticate/important_details.dart';
import 'package:vizilog/pages/authenticate/sign_in.dart';
import 'package:vizilog/pages/widgets/input_text_field.dart';
import 'package:vizilog/service/auth.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Color buttonColor = Color(0xff233975);
  String error = '';
  final _formKey = GlobalKey<FormState>();
  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.all(36),
        child: Form(
          key: _formKey,
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Register With VizLog",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
              SizedBox(
                height: height / 8,
              ),
              InputTextField(
                controller: _emailController,
                labelText: "Email",
              ),
              SizedBox(
                height: height / 20,
              ),
              InputTextField(
                controller: _passwordController,
                labelText: "Password",
              ),
              SizedBox(
                height: height / 14,
              ),
              Center(
                  child: Column(
                children: [
                  Container(
                      width: width,
                      height: height / 16,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: buttonColor),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ImportantDetails(
                                          emailController: _emailController,
                                          passwordController:
                                              _passwordController,
                                        )));
                          }
                        },
                        child: Text("SIGN UP",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                        // child: ListTile(
                        //   leading: Image.asset(
                        //     "assets/images/signin_logo.png",
                        //     height: height / 24,
                        //     width: height / 24,
                        //   ),
                        //   title: Text(
                        //     "SIGN IN VIA GOOGLE",
                        //     style: TextStyle(
                        //         color: Colors.white,
                        //         fontWeight: FontWeight.bold,
                        //         fontSize: 16),
                        //   ),
                        // ),
                      )),
                  SizedBox(
                    height: height / 30,
                  ),
                  TextButton(
                    child: Text("Not a member? SignUp"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignIn()),
                      );
                    },
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    ));
  }
}
