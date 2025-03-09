import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPassWord extends StatefulWidget {
  State<ForgotPassWord> createState() {
    return ForgotPassWordState();
  }
}

class ForgotPassWordState extends State<ForgotPassWord> {
  var _phone = TextEditingController();
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
              Text("กรอกเบอร์โทรศัพท์เพื่อเปลี่ยนรหัสผ่านใหม่", textScaler: TextScaler.linear(1.0),),
              SizedBox(height: 20,),
              phone(),
              SizedBox(height: 5,),
              changePassWord()
            ],
          ),
        ),
      ),
    );
  }

  Widget phone() {
    return TextField(
      controller: _phone,
      decoration: InputDecoration(
        hintText: "เบอร์โทรศัพท์"
      ),
    );
  }

  Widget changePassWord() {
    return ElevatedButton(
        onPressed: () => {},
        child: Text("ขอเปลี่ยนรหัสผ่าน")
    );
  }
}