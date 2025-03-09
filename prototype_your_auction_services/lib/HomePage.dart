import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/screen/AppBar.dart';

class HomePage extends StatefulWidget {
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBar(
        title: Text("HomePage"),
      ),drawer: generalAppBar(context),
    );
  }

  
}

