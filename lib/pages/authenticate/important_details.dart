import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:vizilog/pages/models/user_details.dart';
import 'package:vizilog/pages/widgets/input_text_field.dart';
import 'package:vizilog/pages/widgets/loading.dart';
import 'package:vizilog/service/auth.dart';

import '../home/home.dart';

class ImportantDetails extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const ImportantDetails(
      {Key key, this.emailController, this.passwordController})
      : super(key: key);
  @override
  _ImportantDetailsState createState() => _ImportantDetailsState();
}

class _ImportantDetailsState extends State<ImportantDetails> {
  bool vaccinationStatus = false;
  Color buttonColor = Color(0xff233975);
  UserDetails user = UserDetails();
  String error = '';
  bool loading = false;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _pincodeController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
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
                  "Important Details",
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
                  controller: _nameController,
                  labelText: "Name",
                ),
                SizedBox(
                  height: height / 20,
                ),

                InputTextField(
                  controller: _addressController,
                  labelText: "Address",
                ),
                SizedBox(
                  height: height / 20,
                ),
                InputTextField(
                  controller: _pincodeController,
                  labelText: "Pincode",
                ),
                SizedBox(
                  height: height / 18,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Vaccination Status',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    Expanded(
                      child: Container(
                        child: FlutterSwitch(
                          height: 30,
                          width: 68,
                          activeText: "Yes",
                          inactiveText: "No",
                          // toggleSize: 10,
                          activeTextFontWeight: FontWeight.w500,
                          inactiveTextFontWeight: FontWeight.w500,
                          activeColor: buttonColor,

                          value: vaccinationStatus,
                          showOnOff: true,
                          onToggle: (val) {
                            setState(() {
                              vaccinationStatus = val;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
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
                                  await _auth.registerEmailAndPassword(
                                email: widget.emailController.text,
                                password: widget.passwordController.text,
                                vaccinationStatus: vaccinationStatus,
                                address: _addressController.text,
                                pincode: _pincodeController.text,
                                name: _nameController.text,
                              );
                              print(widget.emailController.text);
                              print(widget.passwordController.text);

                              if (result == null) {
                                setState(() {
                                  loading = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(_auth.errorSignUp)));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()));
                              }
                            }
                          },
                          child: loading == false
                              ? Text("TAKE ME IN!",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16))
                              : Loading(),
                        )),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                    SizedBox(
                      height: height / 30,
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
