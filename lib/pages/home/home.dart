import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vizilog/pages/home/qr_scanner.dart';
import 'package:vizilog/pages/models/user_details.dart';
import 'package:vizilog/pages/widgets/custom_button.dart';
import 'package:vizilog/service/auth.dart';
import 'package:vizilog/service/database.dart';
import '../prefs.dart';
import './recent_activities_list.dart';
import '../models/shop_entries.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService _authService = AuthService();
  List<String> activities;
  String name = "";
  List<Map> entries;

  @override
  void initState() {
    User user = FirebaseAuth.instance.currentUser;
    print(user.uid);
    print(user.displayName);
    // sortingQuery(user.uid);

    // FirebaseFirestore.instance
    //     .collection("shopEntry")
    //     .snapshots()
    //     .listen((result) {
    //   result.docs.forEach((result) {
    //     if (result.data()['uid'] == user.uid) {
    //       setState(() {
    //         name = result.data()['name'];
    //       });
    //     }
    //     print(result.data());
    //   });
    // });
    FirebaseFirestore.instance
        .collection("user")
        .doc(user.uid)
        .get()
        .then((value) {
      print(value.data());
      setState(() {
        name = value.data()['name'];
      });
    });
    super.initState();
  }

  sortingQuery(String uid) async {
    // var result = await FirebaseFirestore.instance
    //     .collection("shopEntries")
    //     .where("uid", isEqualTo: uid)
    //     .orderBy("timestamp", descending: true)
    //     .get();
    FirebaseFirestore.instance
        .collection("shopEntries")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        for (int i = 0; i < result.data().length; i++) {
          setState(() {
            entries[i] = result.data();
          });
        }
      });
    });

    entries.forEach((element) {
      print("Entries Printing");
      print(element['merchantID']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<ShopEntries>>.value(
        initialData: null,
        value: DatabaseService().entries,
        builder: (context, snapshot) {
          return Scaffold(
            body: SingleChildScrollView(
              child: SafeArea(
                child: Container(
                  padding: EdgeInsets.all(36),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome, $name",
                        style: TextStyle(fontSize: 36),
                      ),
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
                      ElevatedButton(
                          onPressed: () async {
                            await _authService.signOut();
                          },
                          child: Text("SignOut")),
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
