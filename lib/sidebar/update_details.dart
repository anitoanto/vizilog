import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vizilog/pages/home/home.dart';
import 'package:vizilog/pages/models/user_details.dart';
import 'package:vizilog/pages/widgets/input_text_field.dart';
import 'package:vizilog/service/auth.dart';
import 'package:vizilog/service/database.dart';

class UpdateDetails extends StatefulWidget {
  @override
  _UpdateDetailsState createState() => _UpdateDetailsState();
}

class _UpdateDetailsState extends State<UpdateDetails> {
  User user = FirebaseAuth.instance.currentUser;
  AuthService _auth = AuthService();
  updateUserDetails(String name, String address, String pincode) {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection("user").doc(firebaseUser.uid).update(
        {"name": name, "address": address, "pincode": pincode}).then((_) {
      print("success!");
    });
  }

  fetchUserDetails() {
    FirebaseFirestore.instance
        .collection("user")
        .where("uid", isEqualTo: user.uid)
        .snapshots()
        .listen((value) {
      // setState(() {
      //   entries = value.docs;
      // });
      print(value.docs.length);
      value.docs.forEach((result) {
        print("USER");
        setState(() {
          name = result['name'];
          address = result['address'];
          pincode = result['pincode'];
        });
        print(result['address']);
      });
    });
  }

  @override
  void initState() {
    fetchUserDetails();
    super.initState();
  }

  DatabaseService _databaseService = DatabaseService();
  String name;
  String address;
  String pincode;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _pincodeController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    final user = Provider.of<UserDetails>(context);
    // print("Address");
    // print(user.imageURL);
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Details'),
        backgroundColor: Color(0xff233975),
        elevation: 1,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
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
                          image: NetworkImage(user.imageURL != null
                              ? user.imageURL
                              : 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.Nuy39yqcMREaqhbbevS-YgHaHa%26pid%3DApi&f=1'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: height / 15,
                    ),
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'Enter a name' : null,
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                        labelText: 'Full Name',
                        hintText: '$name',
                      ),
                    ),
                    SizedBox(
                      height: height / 20,
                    ),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? 'Enter an address' : null,
                      controller: _addressController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                        labelText: 'Address',
                        hintText: '$address',
                      ),
                    ),
                    SizedBox(
                      height: height / 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.numberWithOptions(),
                      validator: (val) =>
                          val.isEmpty ? 'Enter an pincode' : null,
                      controller: _pincodeController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                        labelText: 'Pincode',
                        hintText: '$pincode',
                      ),
                    ),
                    SizedBox(
                      height: height / 18,
                    ),
                  ],
                ),
              ),
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        primary: Color(0xff233975),
                        padding: EdgeInsets.symmetric(horizontal: 50)),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        updateUserDetails(_nameController.text,
                            _addressController.text, _pincodeController.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Updated Succesfully")));

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      }
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
}
