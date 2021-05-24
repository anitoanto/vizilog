import 'package:flutter/material.dart';
import 'package:vizilog/pages/authenticate/sign_up.dart';
import 'package:vizilog/pages/models/user_details.dart';
import 'package:vizilog/pages/widgets/input_text_field.dart';
import 'package:vizilog/pages/widgets/loading.dart';
import 'package:vizilog/service/auth.dart';
import 'package:vizilog/service/error_handling/auth_exception_handler.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool loading = false;

  Color buttonColor = Color(0xff233975);
  UserDetails user = UserDetails();
  String error = '';
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          // height: height / 1.25,
          padding: EdgeInsets.all(36),
          child: Form(
            key: _formKey,
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome to VizLog",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
                // Spacer(),
                // Image.asset(
                //   "assets/images/signin.png",
                //   height: height / 4,
                //   width: width,
                // ),
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
                              setState(() {
                                loading = true;
                              });
                              dynamic result =
                                  await _auth.signInWithEmailAndPassword(
                                      _emailController.text,
                                      _passwordController.text);
                              if (result !=null)
                                print("SignIn");
                              else {
                                setState(() {
                                  loading = false;
                                });
                                print("error SignIn");
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(AuthExceptionHandler.generateExceptionMessage(result))));
                              }
                              print(result.uid);
                            }
                          },
                          child: loading==false?Text("SIGN IN",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)):Loading(),
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
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                    SizedBox(
                      height: height / 30,
                    ),
                    TextButton(
                      child: Text("Not a member? SignUp"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      },
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
