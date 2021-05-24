import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vizilog/pages/widgets/loading.dart';
import '../models/shop_entries.dart';

class RecentActivitiesList extends StatefulWidget {
  @override
  _RecentActivitiesListState createState() => _RecentActivitiesListState();
}

class _RecentActivitiesListState extends State<RecentActivitiesList> {
  String formatTime(TimeOfDay timeOfDay) {
    String hour = "${timeOfDay.hour}";
    String minute = "${timeOfDay.minute}";
    String hourOfPeriod = "AM";
    if (timeOfDay.hour > 12) {
      hourOfPeriod = "PM";
      hour = "${timeOfDay.hour - 12}";
    }

    if (timeOfDay.minute <= 9) minute = "0${timeOfDay.minute}";
    return "$hour:$minute $hourOfPeriod";
  }

  convertDateTimeToTimeOfDay(DateTime dateTime) {
    TimeOfDay time = TimeOfDay.fromDateTime(dateTime);
    return time;
  }

  formatDate(DateTime dateTime) {
    DateFormat.yMMMd().format(dateTime);
  }

  getSortEntries(List<ShopEntries> entries) {
    List<ShopEntries> userEntriers;
    for (int i = 0; i < entries.length; i++) {
      // user.reload();
      if (user.uid != entries[i].customerId) {
        print("user uid");
        print(user.uid);
        print("the other one");
        print(entries[i].customerId);
        setState(() {
          entries.removeAt(i);
        });
      }
    }
    for (int i = 0; i < entries.length; i++) {
      if (user.uid != entries[i].customerId)
        setState(() {
          entries.removeAt(i);
        });
    }
    print("user $entries");

    entries != null
        ? entries.sort(
            (a, b) => a.timestamp.toDate().compareTo(b.timestamp.toDate()))
        : null;

    setState(() {
      sortedEntries = entries.reversed.toList();
    });
    for (int i = 0; i < entries.length ?? 0; i++) {
      print(sortedEntries[i].timestamp.toDate());
    }
  }

  List<ShopEntries> sortedEntries;
  User user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final entries = Provider.of<List<ShopEntries>>(context);
    print(entries);
    getSortEntries(entries);

    // entries.forEach((element) {
    //   print(element.customerId);
    //   print(element.customerName);
    //   print(element.merchantId);
    //   print(element.merchantName);
    //   print(element.timestamp.toDate());
    // });
    return entries == null
        ? Loading()
        : Container(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: sortedEntries.length ?? 0,
                itemBuilder: (context, index) {
                  return Container(
                      margin: EdgeInsets.symmetric(vertical: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color(0xff233975),
                            width: 2,
                          )),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color(0xff233975),
                          child: Text(
                            sortedEntries[index].merchantName[0].toUpperCase(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(sortedEntries[index].merchantName),
                        subtitle: Text(
                            "${DateFormat.MMMMd().format(sortedEntries[index].timestamp.toDate())},${formatTime(
                          convertDateTimeToTimeOfDay(
                            sortedEntries[index].timestamp.toDate(),
                          ),
                        )}"),
                      ));
                }));
  }
}
