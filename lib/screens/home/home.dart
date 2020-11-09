import 'package:firebase_flutter/models/brew.dart';
import 'package:firebase_flutter/screens/home/settings_form.dart';
import 'package:firebase_flutter/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_flutter/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    void _showSettingPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                child: SettingsForm());
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().usersDoc,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Home'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async {
                await _auth.signout();
              },
            ),
            FlatButton.icon(
                onPressed: () => _showSettingPanel(),
                icon: Icon(Icons.settings),
                label: Text('settings'))
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/coffee_bg.png'),
                    fit: BoxFit.cover)),
            child: UserList()),
      ),
    );
  }
}
