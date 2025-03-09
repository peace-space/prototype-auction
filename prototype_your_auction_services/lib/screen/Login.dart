import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  State<Login> createState(){
    return LoginState();
  }
}

class LoginState extends State<Login>{
  var _phone = TextEditingController();
  var _passWord = TextEditingController();

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        color: Colors.orange,
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("เข้าสู่ระบบ",textScaler: TextScaler.linear(1.5),),
                Text("ประมูลออนไลน์", textScaler: TextScaler.linear(1.0),),
                phone(),
                passWord(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    forgot_password(),
                  ],
                ),
                loginButton(),
                SizedBox(height: 5,),
                registerButton()
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
        hintText: "เบอร์โทรศัพท์",
      ),
    );
  }

  Widget passWord() {
    return TextField(
      controller: _passWord,
      decoration: InputDecoration(
        hintText: "รหัสผ่าน"
      ),
    );
  }

  Widget loginButton() {
    return ElevatedButton(
        onPressed: () => {},
        child: Text("เข้าสู่ระบบ")
    );
  }

  Widget registerButton() {
    return ElevatedButton(
        onPressed: () => {},
        child: Text("ลงทะเบียน")
    );
  }

  Widget forgot_password() {
    return TextButton(
        onPressed: () => {},
        child: Text("ลืมรหัสผ่าน")
    );
  }
}