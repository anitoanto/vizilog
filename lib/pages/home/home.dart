import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vizilog/pages/home/qr_scanner.dart';
import 'package:vizilog/pages/models/user_details.dart';
import 'package:vizilog/pages/widgets/custom_button.dart';
import 'package:vizilog/service/auth.dart';
import 'package:vizilog/service/database.dart';
import 'package:vizilog/sidebar/update_details.dart';
import '../prefs.dart';
import './recent_activities_list.dart';
import '../models/shop_entries.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void initState() {
    fetchUserDetails();

    super.initState();
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
        });
        print(result['address']);
      });
    });
  }

  AuthService _authService = AuthService();
  List<String> activities;
  String name;
  List<Map> entries;
  User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return StreamProvider<List<ShopEntries>>.value(
        initialData: null,
        value: DatabaseService().entries,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Vizilog"),
              backgroundColor: Color(0xff233975),
              elevation: 0,
            ),
            drawer: Drawer(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    color: Color(0xff233975),
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            margin: EdgeInsets.only(
                              top: 40,
                              bottom: 10,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(user.photoURL != null
                                    ? user.photoURL
                                    : 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.Nuy39yqcMREaqhbbevS-YgHaHa%26pid%3DApi&f=1'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Text(
                            '$name',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.update),
                    title: Text(
                      'Update Details',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateDetails()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text(
                      'Log out',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    onTap: () async {
                      await _authService.signOut();
                    },
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Container(
                  padding: EdgeInsets.all(36),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   "Welcome, $name",
                      //   style: TextStyle(fontSize: 36),
                      // ),
                      CustomButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ScanQR()),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.qr_code),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Scan QR Code',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: height / 15,
                      ),

                      // ElevatedButton(
                      //     onPressed: () async {
                      //       await _authService.signOut();
                      //     },
                      //     child: Text("SignOut")),
                      Text(
                        "Recent Activities",
                        style: TextStyle(fontSize: 26),
                      ),
                      RecentActivitiesList(),

                      // Text("${Prefs().getMerchantId()}"),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
