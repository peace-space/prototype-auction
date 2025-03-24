import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/share_data/ShareUserData.dart';

class EditUserProfile extends StatefulWidget {
  State<EditUserProfile> createState() {
    return EditUserProfileState();
  }
}

class EditUserProfileState extends State<EditUserProfile> {
  var _nameController = TextEditingController();
  var _phoneController = TextEditingController();
  var _emailController = TextEditingController();
  var _address = TextEditingController();

  int id_user = ShareData.userData['id_users'];
  String name = '';
  String phone = '';
  String email = '';
  String address = '';

  @override
  void initState() {
    // TODO: implement initState
    id_user = ShareData.userData['id_users'];
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EditUserProfile ${ShareData.userData['id_users']}"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          nameEdit(),
          phoneEdit(),
          emailEdit(),
          addressEdit(),
          SizedBox(height: 8),
          submit(context),
        ],
      ),
    );
  }

  Widget nameEdit() {
    return TextField(
      controller: _nameController,
      decoration: InputDecoration(hintText: "ชื่อ"),
      onChanged: (value) {
        setState(() {
          name = _nameController.value.text;
        });
      },
    );
  }

  Widget phoneEdit() {
    return TextField(
      controller: _phoneController,
      decoration: InputDecoration(hintText: "เบอร์โทรศัพท์"),
      onChanged: (value) {
        setState(() {
          phone = _phoneController.value.text;
        });
      },
    );
  }

  Widget emailEdit() {
    return TextField(
      controller: _emailController,
      decoration: InputDecoration(hintText: "อีเมล"),
      onChanged: (value) {
        setState(() {
          email = _emailController.value.text;
        });
      },
    );
  }

  Widget addressEdit() {
    return TextField(
      controller: _address,
      decoration: InputDecoration(hintText: "ที่อยู่ในกาจัดส่ง"),
      onChanged: (value) {
        setState(() {
          address = _address.value.text;
        });
      },
    );
  }

  Widget submit(BuildContext ctx) {
    return ElevatedButton(
      onPressed: () => {save(ctx)},
      child: Text("บันทึกการแก้ไข"),
    );
  }

  void save(BuildContext ctx) async {
    print("Start");
    final data = {
      "name": name,
      "phone": phone,
      "email": email,
      "address": address,
    };

    String url =
        'https://your-auction-services.com/prototype-auction/api-pa/api/edit-user-profile/${id_user}';
    final uri = Uri.parse(url);

    final response = await http.post(
      uri,
      headers: {"content-type": "application/json"},
      body: jsonEncode(data),
    );

    final resData = jsonDecode(response.body);
    Map<String, dynamic> newUserData = resData['data'];
    print(resData['data']);

    ShareData.userData = resData['data'] as Map<String, dynamic>;
    print(ShareData.userData);
    if (response.statusCode == 200) {
      print("Successfully.");
      Navigator.pop(ctx);
    } else {
      throw Exception("err");
    }
    print("End.");
  }
}
