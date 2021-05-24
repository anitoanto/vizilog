import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vizilog/pages/authenticate/authenticate.dart';
import 'package:vizilog/pages/authenticate/sign_in.dart';
import 'package:vizilog/pages/authenticate/sign_up.dart';
import 'package:vizilog/pages/models/user_details.dart';

import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserDetails>(context);
    print(user);
    print("wrapper");

    if (user == null)
      return Authenticate();
    else {
      return Home();
    }
  }
}
