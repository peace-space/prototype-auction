import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/screen/Login.dart';

class Register extends StatefulWidget {
  State<Register> createState() {
    return RegisterState();
  }
}

class RegisterState extends State<Register> {
  var _firstName = TextEditingController();
  var _lastName = TextEditingController();
  var _phone = TextEditingController();
  var _email = TextEditingController();
  var _address = TextEditingController();
  var _passWord = TextEditingController();
  var _verifyPassWord = TextEditingController();

  String message = "";

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ลงทะเบียน")
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text(message, textScaler: TextScaler.linear(1.5), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
          firstName(),
          lastName(),
          phone(),
          email(),
          address(),
          passWord(),
          verifyPassWord(),
          registerButton(context),
        ],
      )
    );
  }

  Widget firstName() {
    return TextField(
      controller: _firstName,
      decoration: InputDecoration(
       hintText: "ชื่อจริง"
     ),
    );
  }

  Widget lastName() {
    return TextField(
      controller: _lastName,
      decoration: InputDecoration(
        hintText: "นามสกุล"
      ),
    );
  }

  Widget phone() {
    return TextField(
      controller: _phone,
      decoration: InputDecoration(
        hintText: "เบอร์ที่ต้องการใช้เพื่อเข้าสู่ระบบ"
      ),
    );
  }

  Widget email() {
    return TextField(
      controller: _email,
      decoration: InputDecoration(
        hintText: "อีเมล"
      )
    );
  }

  Widget address() {
    return TextField(
      controller: _address,
      decoration: InputDecoration(
        hintText: "ที่อยู่ในการรับสินค้า"
      )
    );
  }

  Widget passWord() {
    return TextField(
      controller: _passWord,
        obscureText: true,
      decoration: InputDecoration(
        hintText: "รหัสผ่าน"
      )
    );
  }

  Widget verifyPassWord() {
    return TextField(
      controller: _verifyPassWord,
        obscureText: true,
      decoration: InputDecoration(
        hintText: "ยืนยันรหัสผ่าน"
      )
    );
  }

  Widget registerButton(BuildContext ctx) {
    return ElevatedButton(
        onPressed: () => {
          onRegister(ctx)
        },
        child: Text("ลงทะเบียน")
    );
  }

  Widget insertImageButton() {
    return ElevatedButton(
        onPressed: () => {},
        child: Text("เพิ่มรูปโปรไฟล์")
    );
  }

  bool hasData() {
    if (
    _firstName.text != "" &&
        _phone.text != "" &&
        _address.text != "" &&
        _passWord.text != "" &&
        _verifyPassWord.text != ""
    ) {
      return true;
    } else {
      return false;
    }
  }

  void goToLogin(BuildContext ctx) {
    var route = MaterialPageRoute(
      builder: (ctx) => Login(),
    );

    Navigator.pushReplacement(ctx, route);
  }

  void onRegister(BuildContext ctx) async {
    String name = "${_firstName.text} ${_lastName.text}";
    print(name);

    if (hasData()) {
      if (_passWord.text == _verifyPassWord.text) {
        String email = _email.text;
        if (_email.text == "") {
          email = "";
        } else {
          email = _email.text;
        }
        Map<String, dynamic> data = {
          'name': name,
          'phone': _phone.text,
          'email': email,
          'address': _address.text,
          'password': _passWord.text,
        };
        String url = 'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/register';
        final uri = Uri.parse(url);
        final response = await http.post(
            uri,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(data)
        );

        if (response.statusCode == 201) {
          setState(() {
            message = "Successfully.";
            goToLogin(ctx);
          });
        } else {
          setState(() {
            message = "ข้อมูลไม่ถูกต้อง/มีบัญชีผู้ใช้งานอยู่แล้ว";
          });
        }
      } else {
        setState(() {
          message = "รหัสผ่านไม่ตรงกัน";
        });
      }
    } else {
      String msg = "";
      if (_firstName.text == "") {
        msg = "กรุณากรอกชื่อ";
      } else if (_phone.text == "") {
        msg = "กรุณากรอกเบอร์โทรที่ต้องการใช้เข้าสู่ระบบ";
      } else if (_address.text == "") {
        msg = "กรุณากรอกที่อยู่ในการรับสินค้า";
      } else if (_passWord.text == "") {
        msg = "กรุณากรอกรหัสผ่าน";
      } else if (_verifyPassWord.text == "") {
        msg = "กรุณากรอกรหัสผ่านเพื่อยืนยัน";
      } else {
        msg = "เกิดข้อผิดผลาดในการกรอกข้อมูล";
      }
      setState(() {
        message = msg;
      });
    }
    print("End.");
  }

}