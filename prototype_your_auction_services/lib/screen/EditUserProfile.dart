import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/share/ShareUserData.dart';

class EditUserProfile extends StatefulWidget {
  State<EditUserProfile> createState() {
    return EditUserProfileState();
  }
}

class EditUserProfileState extends State<EditUserProfile> {
  var _confirmPassWordController = TextEditingController();
  var _firstNameController = TextEditingController();
  var _lastNameController = TextEditingController();
  var _phoneController = TextEditingController();
  var _emailController = TextEditingController();
  var _address = TextEditingController();

  int id_user = ShareData.userData['id_users'];
  String firstName = '';
  String lastName = '';
  String phone = '';
  String email = '';
  String address = '';
  String _confirmPassWord = '';

  @override
  void initState() {
    // TODO: implement initState
    id_user = ShareData.userData['id_users'];
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("แก้ไขข้อมูลผู้ใช้งาน ${ShareData.userData['id_users']}"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          firstNameEdit(),
          SizedBox(height: 8),
          lastNameEdit(),
          SizedBox(height: 8),
          phoneEdit(),
          SizedBox(height: 8),
          emailEdit(),
          SizedBox(height: 8),
          addressEdit(),
          SizedBox(height: 8),
          submit(context),
        ],
      ),
    );
  }

  Widget firstNameEdit() {
    return TextField(
      controller: _firstNameController,
      decoration: InputDecoration(
        labelText: "ชื่อ",
        border: OutlineInputBorder(),
        hintText: ShareData.userData['name'],
      ),
      onChanged: (value) {
        setState(() {
          firstName = value;
        });
      },
    );
  }

  Widget lastNameEdit() {
    return TextField(
      controller: _lastNameController,
      decoration: InputDecoration(
        labelText: "นามสกุล",
        border: OutlineInputBorder(),
        hintText: ShareData.userData['name'],
      ),
      onChanged: (value) {
        setState(() {
          lastName = _lastNameController.value.text;
        });
      },
    );
  }

  Widget phoneEdit() {
    return TextField(
      controller: _phoneController,
      decoration: InputDecoration(
        labelText: "เบอร์โทรศัพท์",
        border: OutlineInputBorder(),
        hintText: ShareData.userData['phone'],
      ),
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
      decoration: InputDecoration(
        labelText: "อีเมล",
        border: OutlineInputBorder(),
        hintText: ShareData.userData['email'],
      ),
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
      decoration: InputDecoration(
        labelText: "ที่อยู่ในการจัดส่งสินค้า",
        border: OutlineInputBorder(),
        hintText: ShareData.userData['address'],
      ),
      onChanged: (value) {
        setState(() {
          address = _address.value.text;
        });
      },
    );
  }

  Widget submit(BuildContext ctx) {
    return ElevatedButton(
      onPressed: () => {confirmChangeUserData(ctx)},
      child: Text("บันทึกการแก้ไข"),
    );
  }

  void onSave(BuildContext ctx) async {
    print("Start");
    final data = {
      "first_name": firstName,
      "last_name": lastName,
      "phone": phone,
      "email": email,
      "address": address,
      // "confirm_password" : _confirmPassWord,
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

  void confirmChangeUserData(BuildContext ctx) {
    String confirmFirstName = firstName;
    String confirmLastName = lastName;
    String confirmPhone = phone;
    String confirmEmail = email;
    String confirmAddress = address;

    if (firstName == '') {
      confirmFirstName = '-';
    }
    if (lastName == '') {
      confirmLastName = '-';
    }
    if (phone == '') {
      confirmPhone = '-';
    }
    if (email == '') {
      confirmEmail = '-';
    }
    if (address == '') {
      confirmAddress = '-';
    }

    showDialog(
      context: context,
      builder:
          (context) =>
          AlertDialog(
            title: Text("แจ้งเตือน"),
            content: Container(
              height: 500,
              width: 300,
              child: Expanded(
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "ยืนยันการเปลี่ยนแปลงข้อมูล",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          "ชื่อ: ",
                          style: textStyleSubjectConfirmChangeUserData(),
                        ),
                        Text(
                          "${confirmFirstName}",
                          style: textStyleConfirmChangeUserData(),
                        ),
                        Divider(),
                        Text(
                          "นามสกุล: ",
                          style: textStyleSubjectConfirmChangeUserData(),
                        ),
                        Text(
                          "${confirmLastName}",
                          style: textStyleConfirmChangeUserData(),
                        ),
                        Divider(),
                        Text(
                          "เบอร์โทร: ",
                          style: textStyleSubjectConfirmChangeUserData(),
                        ),
                        Text(
                          "${confirmPhone}",
                          style: textStyleConfirmChangeUserData(),
                        ),
                        Divider(),
                        Text(
                          "อีเมล: ",
                          style: textStyleSubjectConfirmChangeUserData(),
                        ),
                        Text(
                          "${confirmEmail}",
                          style: textStyleConfirmChangeUserData(),
                        ),
                        Divider(),
                        Text(
                          "ที่อยู่ในการจัดส่ง: ",
                          style: textStyleSubjectConfirmChangeUserData(),
                        ),
                        Text(
                          "${confirmAddress}",
                          style: textStyleConfirmChangeUserData(),
                        ),
                        Divider(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => {Navigator.pop(context)},
                child: Text("Cencel"),
              ),
              TextButton(
                onPressed: () =>
                {
                  confirmPassWord(ctx),
                  // Navigator.pop(context)
                },
                child: Text("OK"),
              ),
            ],
          ),
    );
  }

  void confirmPassWord(BuildContext ctx) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text("กรอกรหัสผ่านเพื่อยืนยัน"),
            content: TextField(
              obscureText: true,
              controller: _confirmPassWordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "รหัสผ่าน",
              ), onChanged: (value) {
              setState(() {
                _confirmPassWord = value;
              });
            },
            ),
            actions: [
              TextButton(
                onPressed: () => {Navigator.pop(context)},
                child: Text("Cencel"),
              ),
              TextButton(
                onPressed: () =>
                {
                  onSave(ctx),
                  Navigator.pop(context),
                  Navigator.pop(context)},
                child: Text("OK"),
              ),
            ],
          ),
    );
  }

  TextStyle textStyleSubjectConfirmChangeUserData() {
    return TextStyle(fontSize: 16);
  }

  TextStyle textStyleConfirmChangeUserData() {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.blue,
    );
  }
}
