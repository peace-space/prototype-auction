import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/screen/AuctionHome.dart';
import 'package:prototype_your_auction_services/screen/ForgotPassWord.dart';
import 'package:prototype_your_auction_services/screen/Register.dart';
import 'package:prototype_your_auction_services/share/ConfigAPI.dart';
import 'package:prototype_your_auction_services/share/ShareUserData.dart';

class Login extends StatefulWidget {
  State<Login> createState(){
    return LoginState();
  }
}

class LoginState extends State<Login>{
  var _email = TextEditingController();
  var _passWord = TextEditingController();
  String message = "";
  bool _hiddenPassWord = true;

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        color: Colors.orange,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("เข้าสู่ระบบ", style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),),
                  Text("ประมูลออนไลน์", style: TextStyle(
                      fontSize: 35
                  ),),
                  SizedBox(height: 3,),
                  Text("${message}", textScaler: TextScaler.linear(1.3),
                    style: TextStyle(color: Colors.red),),
                  email(),
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
          ],
        ),
      ),
    );
  }

  Widget email() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      controller: _email,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email_outlined),
        hintText: "อีเมล",
      ),
    );
  }

  Widget passWord() {
    return TextField(
      controller: _passWord,
      obscureText: _hiddenPassWord,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.key),
          hintText: "รหัสผ่าน",
          suffixIcon: IconButton(
              onPressed: () =>
              {
                setState(() {
                  if (_hiddenPassWord) {
                    _hiddenPassWord = false;
                  } else {
                    _hiddenPassWord = true;
                  }
                })
              },
              icon: Icon(
                  _hiddenPassWord ? Icons.visibility_off : Icons.visibility)
          )
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
    Navigator.pushReplacement(ctx, route);
  }

  void onLogin(BuildContext ctx) async {
    print("Start");

    if (_email.text != "" && _passWord.text != "") {
      Map<String, dynamic> data = {
        'email': _email.text,
        'password' : _passWord.text
      };

      // String url = "https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/login";
      // String url = ApiPathLocal().getLoginApiLocalPost();
      String url = ConfigAPI().getLoginApiServerPost();

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

        FlutterSecureStorage storage = FlutterSecureStorage();
        await storage.deleteAll();
        await storage.write(
            key: 'user_token', value: resData['authorisation']['token']);
        await storage.write(
            key: 'user_token_type', value: resData['authorisation']['type']);

        Map<String, dynamic> data = resData['data'];
        print(data.toString());
        // print("\n\n\n\n+++++++++++++++++++++++++++++++++++++++++++++++++\n" +
        //     data['user_data']['admin_status'].runtimeType.toString() +
        //     "\n\n\n\n");
        if (data['user_data']['admin_status'] == '1') {
          ShareData.admin = true;
        } else {
          ShareData.admin = false;
        }
        // print("Admin Status: " + ShareData.admin.toString());

        ShareData.logedIn = true;
        // print("\n\n\n\n+++++++++++++++++++++++++++++++++++${data.toString()}\n\n\n\n\n");
        ShareData.userData = data['user_data'];
        if (data['bank_account'] != null) {
          ShareData.bankAccountUser = data['bank_account'];
        }
        ShareData.image_user_profile =
            data['user_data']['image_profile'].toString();
        // print(ShareData.userData['user_data']['image_profile'].toString());
        // print("SSSSSSSSSSSSSSSS: " + ShareData.userData.toString() + "SSSSSSSSSSSSSSSSSSSSSS");

        goToAuctionHome(ctx);

      } else {
        setState(() {
          message = resData['message'].toString();
        });
      }
    } else {
      if (_email.text == "") {
        setState(() {
          message = "กรุณากรอกอีเมล";
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