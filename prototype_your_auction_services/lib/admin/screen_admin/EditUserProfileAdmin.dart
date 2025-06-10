import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/admin/screen_admin/UserDetailAdmin.dart';

class EditUserProfile extends StatefulWidget {
  final Map user_data;
  final int id_user;
  EditUserProfile(
      this.id_user, this.user_data
      );
  State<EditUserProfile> createState() {
    return EditUserProfileState(id_user);
  }
}

class EditUserProfileState extends State<EditUserProfile> {
  final int id_user;
  var _nameController = TextEditingController();
  var _phoneController = TextEditingController();
  var _emailController = TextEditingController();
  var _address = TextEditingController();
  Map user_data = {};

  String name = '';
  String phone = '';
  String email = '';
  String address = '';

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
          phoneEdit(),
          emailEdit(),
          addressEdit(),
          submit(context),
          Text(phone)
        ],
      ),
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
          name = _nameController.value.text;
        });
      },
    );
  }

  Widget phoneEdit(){
    return TextField(
      controller: _phoneController,
      decoration: InputDecoration(
        hintText: "เบอร์โทรศัพท์",
      ),
      onChanged: (value) {
        setState(() {
          phone = _phoneController.value.text;
        });
      },
    );
  }

  Widget emailEdit(){
    return TextField(
      controller: _emailController,
      decoration: InputDecoration(
        hintText: "อีเมล",
      ),
      onChanged: (value) {
        setState(() {
          email = _emailController.value.text;
        });
      },
    );
  }

  Widget addressEdit(){
    return TextField(
      controller: _address,
      decoration: InputDecoration(
        hintText: "ที่อยู่ในกาจัดส่ง",
      ),
      onChanged: (value) {
        setState(() {
          address = _address.value.text;
        });
      },
    );
  }

  Widget submit(BuildContext ctx){
    // print(phone);
    return ElevatedButton(
        onPressed: () => {
        save(),Navigator.pushReplacement(ctx,
          MaterialPageRoute(builder: (ctx) => UserManage(id_user: id_user),))
        },
        child: Text("บันทึกการแก้ไข")
    );
  }

  void save() async {

      print("Start");
      final data = {
        "name" : name,
        "phone" : phone,
        "email" : email,
        "address" : address
      };
      //
      String url = 'https://www.your-auction-services.com/prototype-auction/api-pa/api/edit-user-profile/${id_user}';
      final uri = Uri.parse(url);
      // final response = await http.post(
      //     uri, headers: {'Content-Type' : 'application/json'},
      //     body: jsonEncode(data),
      // );

      final response = await http.post(
        uri,
        headers: {"content-type": "application/json"},
        body: jsonEncode(data),
      );

      response;
      print("End");

      if (response.statusCode == 200) {
        print("Successfully.");
      } else {
        throw Exception("err");
      }

  }

// void userData() async {
//   print("Start");
//   String url = "https://your-auction-services.com/prototype-auction/api-pa/api/user/${id_user}";
//   final uri = Uri.parse(url);
//   final response = await http.get(uri);
//   final resData = jsonDecode(response.body);
//   print(resData['data'].toString());
//
//   setState(() {
//     this.user_data = resData['data'];
//   });
//
//   print("End");
// }
}