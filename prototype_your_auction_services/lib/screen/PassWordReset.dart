import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/screen/Login.dart';
import 'package:prototype_your_auction_services/share/ConfigAPI.dart';

class PassWordReset extends StatefulWidget {
  String email = '';

  PassWordReset({required this.email});

  State<PassWordReset> createState() {
    return PassWordResetState(email: email);
  }
}

class PassWordResetState extends State<PassWordReset> {
  var _email = TextEditingController();
  var _token_for_password_reset = TextEditingController();
  var _new_password = TextEditingController();
  var _confirm_password = TextEditingController();
  var _comfirm_password = TextEditingController();
  bool _hiddenPassWord = true;
  bool _hiddenPassWordVerifyPassWord = true;

  String message = '';
  String email = '';

  PassWordResetState({required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("เปลี่ยนรหัสผ่าน")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Center(child: textMessage()),
            // SizedBox(height: 8,),
            // inputEmail(),
            SizedBox(height: 16),
            inputTokenForPassWordReset(),
            SizedBox(height: 8),
            inputNewPassWord(),
            SizedBox(height: 8),
            inputConfirmPassWord(),
            SizedBox(height: 8),
            buttonSubmit(),
          ],
        ),
      ),
    );
  }

  Widget textMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "ระบบได้ส่ง OTP เพื่อยืนยันตัวตนไปยังอีเมลของคุณ",
          style: textStyleForMessage(),
        ),
        SizedBox(height: 16),
        Text("สามารถตรวจสอบได้ที่อีเมล", style: textStyleForMessage()),
        SizedBox(height: 8),
        Text("${email}", style: TextStyle(
          fontSize: 18,
          color: Colors.red
        )),
        SizedBox(height: 16),
        // Text("${message}", style: TextStyle(color: Colors.red)),
      ],
    );
  }

  TextStyle textStyleForMessage() {
    return TextStyle(fontSize: 18);
  }

  // Widget inputEmail() {
  //   return TextFormField(
  //    controller: _email,
  //     decoration: InputDecoration(
  //         border: OutlineInputBorder(),
  //       label: Text("อีเมล"),
  //       hintText: "อีเมล"
  //     ),
  //   );
  // }

  Widget inputTokenForPassWordReset() {
    return TextFormField(
      controller: _token_for_password_reset,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: Text("OTP"),
        hintText: "OTP ของคุณ",
      ),
    );
  }

  Widget inputNewPassWord() {
    return TextField(
      controller: _new_password,
      obscureText: _hiddenPassWord,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: Text("รหัสผ่านใหม่"),
        hintText: "รหัสผ่านใหม่",
        suffixIcon: IconButton(
          onPressed:
              () => {
                setState(() {
                  if (_hiddenPassWord) {
                    _hiddenPassWord = false;
                  } else {
                    _hiddenPassWord = true;
                  }
                }),
              },
          icon: Icon(_hiddenPassWord ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }

  Widget inputConfirmPassWord() {
    return TextField(
      controller: _comfirm_password,
      obscureText: _hiddenPassWordVerifyPassWord,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: Text("ยืนยันรหัสผ่านใหม่อีกครั้ง"),
        hintText: "ยืนยันรหัสผ่านใหม่อีกครั้ง",
        suffixIcon: IconButton(
          onPressed:
              () => {
                setState(() {
                  if (_hiddenPassWordVerifyPassWord) {
                    _hiddenPassWordVerifyPassWord = false;
                  } else {
                    _hiddenPassWordVerifyPassWord = true;
                  }
                }),
              },
          icon: Icon(
            _hiddenPassWordVerifyPassWord
                ? Icons.visibility
                : Icons.visibility_off,
          ),
        ),
      ),
    );
  }

  ElevatedButton buttonSubmit() {
    return ElevatedButton(
      onPressed: () => {onPassWordReset()},
      child: Text("ขอเปลี่ยนรหัสผ่าน"),
    );
  }

  void onPassWordReset() async {
    showDialog(
        barrierDismissible: false,
        context: context, builder: (context) => Center(
      child: CircularProgressIndicator(),
    ));
    if (_new_password.text == _comfirm_password.text) {
      Map<String, dynamic> data = {
        'email': email,
        'token_for_password_reset': _token_for_password_reset.text,
        'password': _new_password.text,
      };
      print("${data.toString()}");
      String api = ConfigAPI().getPasswordResetServerPost();
      Uri uri = Uri.parse(api);
      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } else {
        message = 'กรุณาตรวจสอบรหัสจากอีเมลอีกครั้ง';
        setState(() {});
      }
    } else {
      message = 'รหัสผ่านไม่ตรงกัน';
      setState(() {});
    }
  }
}
