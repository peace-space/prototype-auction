import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/screen/PassWordReset.dart';
import 'package:prototype_your_auction_services/share/ApiPathServer.dart';

class ForgotPassWord extends StatefulWidget {
  State<ForgotPassWord> createState() {
    return ForgotPassWordState();
  }
}

class ForgotPassWordState extends State<ForgotPassWord> {
  var _email = TextEditingController();
  String message = '';
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ลืมรหัสผ่าน"),),
      body: Container(
        margin: EdgeInsets.all(20),
        color: Colors.orange,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("ลืมรหัสผ่าน",textScaler: TextScaler.linear(1.5),),
              SizedBox(height: 5,),
              Text("กรอกอีเมลเพื่อเปลี่ยนรหัสผ่านใหม่",
                textScaler: TextScaler.linear(1.0),),
              SizedBox(height: 8,),
              Text("${message}", style: TextStyle(
                  color: Colors.red
              ),),
              SizedBox(height: 20,),
              email(),
              SizedBox(height: 5,),
              passwordReset()
            ],
          ),
        ),
      ),
    );
  }

  Widget email() {
    return TextField(
      controller: _email,
      decoration: InputDecoration(
          hintText: "อีเมล"
      ),
    );
  }

  Widget passwordReset() {
    return ElevatedButton(
        onPressed: () =>
        {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => PassWordReset(email: _email.text,),))
          submit()
        },
        child: Text("ขอเปลี่ยนรหัสผ่าน")
    );
  }

  bool checkEmail() {
    if (EmailValidator.validate(_email.text!)) {
      return true;
    }
    return false;
  }

  void submit() async {
    if (checkEmail()) {
      Map<String, dynamic> data = {
        'email': _email.text,
      };
      String api = ApiPathServer().getForgotPasswordServerPost();
      Uri uri = Uri.parse(api);
      final response = await http.post(
          uri,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data));

      final resData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => PassWordReset(email: _email.text,),));
      } else {
        showDialog(context: context, builder: (context) =>
            AlertDialog(
              title: Text("ล้มเหลว"),
              content: Text("ไม่มีข้อมูลผู้ใช้งาน"),
              actions: [
                TextButton(onPressed: () =>
                {
                  Navigator.of(context).pop()
                }, child: Text("ตกลง"))
              ],
            ),);
      }
    } else {
      message = 'กรุณาตรวจสอบอีเมลใหม่อีกครั้ง';
      setState(() {});
    }
  }

}