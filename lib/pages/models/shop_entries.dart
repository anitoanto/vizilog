import 'package:cloud_firestore/cloud_firestore.dart';

class ShopEntries {
  final String merchantId;
  final String merchantName;
  final String customerId;
  final String customerName;
  final Timestamp timestamp;
  ShopEntries(
      {this.customerId,
      this.customerName,
      this.merchantId,
      this.merchantName,
      this.timestamp,
      
      });
}
