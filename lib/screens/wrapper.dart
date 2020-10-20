import 'package:firebase_flutter/models/user.dart';
import 'package:flutter/material.dart';
import 'home/home.dart';
import 'authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:firebase_flutter/services/auth.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Userdata>(context);
    print(user);
    //return home or authentication widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
