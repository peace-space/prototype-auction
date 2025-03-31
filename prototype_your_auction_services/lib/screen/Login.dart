import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/screen/AuctionHome.dart';
import 'package:prototype_your_auction_services/screen/ForgotPassWord.dart';
import 'package:prototype_your_auction_services/screen/Register.dart';
import 'package:prototype_your_auction_services/share_data/ShareUserData.dart';

class Login extends StatefulWidget {
  State<Login> createState(){
    return LoginState();
  }
}

class LoginState extends State<Login>{
  var _phone = TextEditingController();
  var _passWord = TextEditingController();
  String message = "";

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
                SizedBox(height: 3,),
                Text("${message}", textScaler: TextScaler.linear(1.3), style: TextStyle(color: Colors.red),),
                phone(),
                passWord(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    forgot_password(context),
                  ],
                ),
                loginButton(context),
                SizedBox(height: 5,),
                registerButton(context)
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
      obscureText: true,
      decoration: InputDecoration(
        hintText: "รหัสผ่าน"
      ),
    );
  }

  Widget loginButton(BuildContext ctx) {
    return ElevatedButton(
        onPressed: () => {
          onLogin(ctx)
        },
        child: Text("เข้าสู่ระบบ")
    );
  }

  Widget registerButton(BuildContext ctx) {
    return ElevatedButton(
        onPressed: () =>
        {
          Navigator.pushReplacement(
              ctx, MaterialPageRoute(
            builder: (context) => Register(),
          ))
        },
        child: Text("ลงทะเบียน")
    );
  }

  Widget forgot_password(BuildContext ctx) {
    return TextButton(
        onPressed: () => goToForgotPasswordPage(ctx),
        child: Text("ลืมรหัสผ่าน")
    );
  }

  void goToForgotPasswordPage(BuildContext ctx) {
    final route = MaterialPageRoute(
      builder: (ctx) => ForgotPassWord(),
    );
    Navigator.push(ctx, route);
  }

  void goToAuctionHome(BuildContext ctx) {
    final route = MaterialPageRoute(
      builder: (ctx) => AuctionHome(),
    );
    Navigator.push(ctx, route);
  }

  void onLogin(BuildContext ctx) async {
    print("Start");

    if (_phone.text != "" && _passWord.text != "") {
      Map<String, dynamic> data = {
        'phone' : _phone.text,
        'password' : _passWord.text
      };
      
      String url = "https://prototype.your-auction-services.com/git/api-prototype-auction-servece/api/login";
      final uri = Uri.parse(url);
      final response = await http.post(
        uri,
        headers: {"Content-Type" : "application/json"},
        body: jsonEncode(data)
      );
      
      final resData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print(resData['message']);
        setState(() {
          message = resData['message'].toString();
        });

        Map<String, dynamic> data = resData['data'];

        if (data['admin'] == 1) {
          ShareData.admin = true;
        } else {
          ShareData.admin = false;
        }
        print(ShareData.admin);

        ShareData.logedIn = true;

        ShareData.userData = data;

        goToAuctionHome(ctx);

      } else {
        setState(() {
          message = resData['message'].toString();
        });
      }
    } else {
      if (_phone.text == "") {
        setState(() {
          message = "กรุณากรอกเบอร์โทรศัพท์";
        });
      } else if(_passWord.text == "") {
        setState(() {
          message = "กรุณากรอกรหัสผ่าน";
        });
      }
    }
    print("End.");
  }
}