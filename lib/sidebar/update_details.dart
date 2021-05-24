import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vizilog/pages/home/home.dart';
import 'package:vizilog/pages/models/user_details.dart';

class UpdateDetails extends StatefulWidget {
  @override
  _UpdateDetailsState createState() => _UpdateDetailsState();
}

class _UpdateDetailsState extends State<UpdateDetails> {
  String _name;
  String _address;
  String _pincode;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserDetails>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.pop(
                  context, MaterialPageRoute(builder: (context) => Home()));
            }),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ListView(
            children: [
              Text(
                "Update Details",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(0, 10),
                          )
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.Nuy39yqcMREaqhbbevS-YgHaHa%26pid%3DApi&f=1'),
                        ),
                      ),
                    ),
                    /* Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          color: Colors.blue,
                        ),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),*/
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Form(
                child: Column(
                  children: [
                    _fullName(user.name),
                    SizedBox(
                      height: 20,
                    ),
                    _address(user.address),
                    SizedBox(
                      height: 20,
                    ),
                    _pincode(user.pincode),
                  ],
                ),
              ),
              //buildTextField("full name", "${user.name}"),
              //buildTextField("Address", "${user.address}"),
              //buildTextField("Pincode", "${user.pincode}"),
              //buildTextField("Phone Number", "+9100000000088"),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlineButton(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () {
                      Navigator.pop(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    },
                    child: Text(
                      "CANCEL",
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2.2,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () {
                      formkey.currentState.save();
                      print(_name);
                    },
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2.2,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 6),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: labelText,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _fullName(String hinttext) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Full Name',
        hintText: '${hinttext}',
        hintStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      onSubmitted: (String value) {
        _name = value;
      },
    );
  }

  Widget _address(String hinttext) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Address',
        hintText: '${hinttext}',
        hintStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      onSubmitted: (String value) {
        _name = value;
      },
    );
  }

  Widget _pincode(String hinttext) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Pincode',
        hintText: '${hinttext}',
        hintStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      onSubmitted: (String value) {
        _name = value;
      },
    );
  }
}
