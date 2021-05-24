import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../pages/models/user_details.dart';
import '../pages/models/shop_entries.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');
  final CollectionReference shopEntries =
      FirebaseFirestore.instance.collection('shopEntries');

  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }

  Stream<List<ShopEntries>> get entries {
    print('get entries');
    return shopEntries.snapshots().map(_shopEntriesFromSnapshot);
  }

  List<ShopEntries> _shopEntriesFromSnapshot(QuerySnapshot snapshot) {
    print('Shopentrysnapshot');
    print(snapshot.docs.length);
    return snapshot.docs.map((doc) {
      return ShopEntries(
        customerId: doc.data()['customerId'] ?? '0',
        customerName: doc.data()['customerName'] ?? '',
        merchantId: doc.data()['merchantId'] ?? '0',
        merchantName: doc.data()['merchantName'] ?? '',
        timestamp: doc.data()['timestamp'] ?? null,
      );
    }).toList();
  }

  final user = FirebaseAuth.instance.currentUser;
  Future updateShopEntries(
      {String customerId,
      String customerName,
      String merchantId,
      String merchantName}) async {
    return await shopEntries.doc(uid).set({
      'customerId': customerId,
      'customerName': customerName,
      'merchantId': merchantId,
      'merchantName': merchantName,
      "timestamp": DateTime.now(),
    });
  }

  Future updateUserData(
      {String email,
      String name,
      String address,
      String pincode,
      bool vaccinationStatus,
      List<String> shop}) async {
    return await userCollection.doc(uid).set({
      'uid': uid,
      'email': email,
      'name': name,
      'address': address,
      'pincode': pincode,
      'vaccinationStatus': vaccinationStatus,
      'shop': shop,
    });
  }
}
