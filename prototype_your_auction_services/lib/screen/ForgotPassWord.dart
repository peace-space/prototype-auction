import 'package:flutter/material.dart';

class ForgotPassWord extends StatefulWidget {
  State<ForgotPassWord> createState() {
    return ForgotPassWordState();
  }
}

class ForgotPassWordState extends State<ForgotPassWord> {
  var _email = TextEditingController();
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
              Text("อีเมลเพื่อเปลี่ยนรหัสผ่านใหม่",
                textScaler: TextScaler.linear(1.0),),
              SizedBox(height: 20,),
              email(),
              SizedBox(height: 5,),
              changePassWord()
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

  Widget changePassWord() {
    return ElevatedButton(
        onPressed: () =>
        {
        },
        child: Text("ขอเปลี่ยนรหัสผ่าน")
    );
  }

}