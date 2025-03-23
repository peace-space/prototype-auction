import 'package:flutter/material.dart';

class NewPassWord extends StatefulWidget {
  State<NewPassWord> createState() {
    return NewPassWordState();
  }
}

class NewPassWordState extends State<NewPassWord> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Password'),
      ),
      body: Text("Test"),
    );
  }
}