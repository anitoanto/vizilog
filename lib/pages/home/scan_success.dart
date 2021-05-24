import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vizilog/service/database.dart';
import '../prefs.dart';

class ScanSuccess extends StatefulWidget {
  final String merchantID;
  final String merchantName;
  final String customerId;
  final String customerName;

  const ScanSuccess(
      {this.merchantID, this.merchantName, this.customerId, this.customerName});
  @override
  _ScanSuccessState createState() => _ScanSuccessState();
}

class _ScanSuccessState extends State<ScanSuccess> {
  @override
  void initState() {
    setShopEntries();
    super.initState();
  }

  String merchant;
  setShopEntries() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // print(prefs.getString('Id'));
    // merchant = prefs.getString('Id');
    print(widget.customerName);
    print(widget.customerId);

    await DatabaseService().updateShopEntries(
        customerId: widget.customerId,
        customerName: widget.customerName,
        merchantId: widget.merchantID,
        merchantName: widget.merchantName);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return FutureBuilder<Object>(
        // future: Prefs().getMerchant(),
        builder: (context, snapshot) {
      return Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Message displayed over here
              Text(
                "Result",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: height / 15,
              ),
              Image.asset(
                "assets/images/scanned.png",
                height: width / 2,
                width: width / 2,
              ),
              SizedBox(
                height: height / 8,
              ),
              Text(
                "Successfully Scanned!",
                style: TextStyle(
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "You can enter the store now please",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),

              // TextButton(
              //     onPressed: buildScanner(),
              //     child: Center(child: Text("Rescan ")))

              //Button to scan QR code
            ],
          ),
        ),
      );
    });
  }
}
