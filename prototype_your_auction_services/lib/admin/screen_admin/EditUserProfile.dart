import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/admin/screen_admin/adminAppBar.dart';
import 'package:http/http.dart' as http;

class EditUserProfile extends StatefulWidget {
  final int id_user;
  EditUserProfile(
      this.id_user
      );
  State<EditUserProfile> createState() {
    return EditUserProfileState(id_user);
  }
}

class EditUserProfileState extends State<EditUserProfile> {
  final int id_user;
  var _nameController = TextEditingController();

  String name = '';
  String phone = 'aaaaa';
  String email = '';

  EditUserProfileState(
      this.id_user
      );

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("แก้ไขข้อมูล: ${id_user}")
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text("data"),
          nameEdit(),
          submit(context),
          Text(phone)
        ],
      ),drawer: adminAppbar(context),
    );
  }

  Widget nameEdit(){
    return TextField(
      controller: _nameController,
      decoration: InputDecoration(
        hintText: "ชื่อ",
      ),
      onChanged: (value) {
        setState(() {
          phone = _nameController.value.text;
        });
      },
    );
  }

  Widget submit(BuildContext ctx){
    // print(phone);
    return ElevatedButton(
        onPressed: () => {
          save()
        },
        child: Text("บันทึกการแก้ไข")
    );
  }

  Future<void> save() async {
    print("Start");
    // final data = {
    //
    //   "phone" : 'phone',
    //
    // };
    //
    String url = "http://127.0.0.1:8000/api/edit-user-profile/1";
    // final uri = Uri.parse(url);
    // final response = await http.post(
    //     uri, headers: {'Content-Type' : 'application/json'},
    //     body: jsonEncode(data),
    // );

    final response = await http.post(
      Uri.parse(url),
        body: jsonEncode(<String, dynamic>{
          'phone': phone,
          // Add any other data you want to send in the body
        }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }
    );
    print("End");
  }
}