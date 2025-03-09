import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ลงทะเบียน")
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                firstName(),
                lastName(),
                phone(),
                email(),
                address(),
                passWord(),
                verifyPassWord(),
                registerButton(),
              ],
            ),
        )
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
      decoration: InputDecoration(
        hintText: "รหัสผ่าน"
      )
    );
  }

  Widget verifyPassWord() {
    return TextField(
      controller: _verifyPassWord,
      decoration: InputDecoration(
        hintText: "ยืนยันรหัสผ่าน"
      )
    );
  }

  Widget registerButton() {
    return ElevatedButton(
        onPressed: () => {},
        child: Text("ลงทะเบียน")
    );
  }

  Widget insertImageButton() {
    return ElevatedButton(
        onPressed: () => {},
        child: Text("เพิ่มรูปโปรไฟล์")
    );
  }
}