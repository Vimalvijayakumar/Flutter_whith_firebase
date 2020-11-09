import 'package:firebase_flutter/models/brew.dart';
import 'package:firebase_flutter/screens/home/brew_tile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_flutter/models/brew.dart';
import 'package:provider/provider.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context) ?? [];
    // userdata.forEach((brews) {
    //   print(brews.name);
    //   print(brews.sugars);
    //   print(brews.strength);
    // });

    return ListView.builder(
        itemCount: brews.length,
        itemBuilder: (context, index) {
          return BrewTile(brew: brews[index]);
        });
  }
}
