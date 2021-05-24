import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vizilog/pages/models/user_details.dart';
import 'package:vizilog/service/database.dart';
import './scan_success.dart';
import '../prefs.dart';

class ScanQR extends StatefulWidget {
  @override
  _ScanQRState createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  String qrCodeResult = "Not Yet Scanned";
  List<String> merchant;
  String userId = '';
  String userName = '';
  @override
  void initState() {
    buildScanner();
    FirebaseFirestore.instance.collection("user").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print("Userdetails");
        print(result.data());
        setState(() {
          // userId = result.data()["uid"] ?? '';
          userId = FirebaseAuth.instance.currentUser.uid;
          // userName = result.data()["name"] ?? '';
          userName = FirebaseAuth.instance.currentUser.displayName;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final user = Provider.of<UserDetails>(context);
    print(user.name);
    print(user.uid);
    print(user.email);
    return Scaffold(
        appBar: AppBar(
          leading: TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              label: Text('')),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            "Scan QR Code",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: ScanSuccess(
          customerId: userId,
          customerName: userName,
          merchantID: merchant[0],
          merchantName: merchant[1],
        ));
  }

  buildScanner() async {
    String codeSanner = await BarcodeScanner.scan(); //barcode scnner
    setState(() {
      qrCodeResult = codeSanner;
      merchant = qrCodeResult.split(",");
    });

    // print(Prefs().getMerchant());

    print(merchant[0]);
    print(merchant[1]);
    print(qrCodeResult);
    // await DatabaseService().updateShopEntries(
    //   merchantId: merchant[0],
    //   merchantName: merchant[1],
    // );
  }
}
