import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/controller/UserController.dart';
import 'package:prototype_your_auction_services/screen/UserProfile.dart';

class EditPassWord extends StatefulWidget {
 @override
  State<StatefulWidget> createState() {
   return EditPassWordState();
  }

}

class EditPassWordState extends State {
  var change_password_ctl = TextEditingController();
  var old_password_ctl = TextEditingController();
  var change_password_verify_ctl = TextEditingController();
  bool _hiddenPassWord = true;
  bool _hiddenNewPassWord = true;
  bool _hiddenNewPassWordVerify = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("เปลี่ยนรหัสผ่าน"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: old_password_ctl,
            obscureText: _hiddenPassWord,
            decoration: InputDecoration(
              label: Text("รหัสผ่านเก่า"),
              hintText: "รหัสผ่านเก่า",
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
          ),
          TextField(
            controller: change_password_ctl,
            obscureText: _hiddenNewPassWord,
            decoration: InputDecoration(
                label: Text("รหัสผ่านใหม่"),
              hintText: "รหัสผ่านใหม่",
                suffixIcon: IconButton(
                    onPressed: () =>
                    {
                      setState(() {
                        if (_hiddenNewPassWord) {
                          _hiddenNewPassWord = false;
                        } else {
                          _hiddenNewPassWord = true;
                        }
                      })
                    },
                    icon: Icon(
                        _hiddenNewPassWord ? Icons.visibility_off : Icons.visibility)
                )
            ),
          ),
          TextField(
            controller: change_password_verify_ctl,
            obscureText: _hiddenNewPassWordVerify,
            decoration: InputDecoration(
                label: Text("ยืนยันรหัสผ่านใหม่อีกครั้ง"),
                hintText: "ยืนยันรหัสผ่านใหม่อีกครั้ง",
                suffixIcon: IconButton(
                    onPressed: () =>
                    {
                      setState(() {
                        if (_hiddenNewPassWordVerify) {
                          _hiddenNewPassWordVerify = false;
                        } else {
                          _hiddenNewPassWordVerify = true;
                        }
                      })
                    },
                    icon: Icon(
                        _hiddenNewPassWordVerify ? Icons.visibility_off : Icons.visibility)
                )
            ),
          ),
          ElevatedButton(onPressed: () {
            onChangePassWord();
          }, child: Text("เปลี่ยนรหัสผ่าน"))
        ],
      ),
    );
  }
  
  
  void onChangePassWord() {
    if (change_password_ctl.text == change_password_verify_ctl.text) {
      showDialog(context: context, builder: (context) => AlertDialog(
        title: Text("เปลี่ยนรหัสผ่านหรือไม่"),
        content: Text("ยืนยันการเปลี่ยนรหัาผ่าน"),
        actions: [
          TextButton(onPressed: () {
            Navigator.of(context).pop();
          }, child: Text("ยกเลิก")),
          TextButton(onPressed: () {
            UserController().onChangePassWordUser(context, new_password: change_password_ctl.text, old_password: old_password_ctl.text);
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserProfile(),));
            // showDialog(context: context, builder: (context) => AlertDialog(
            //   title: Text("เปลี่ยนรหัสผ่านสำเร็จ"),
            //   content: Text("เปลี่ยนรหัสผ่านสำเร็จแล้ว"),
            //   actions: [
            //     TextButton(onPressed: () {
            //       Navigator.of(context).pop();
            //     }, child: Text("ตกลง"))
            //   ],
            // ));
          } , child: Text("ตกลง"))
        ],
      ));
    } else {
      showDialog(context: context, builder: (context) => AlertDialog(
        title: Text("แจ้งเตือน"),
        content: Text("รหัสผ่านไม่ตรงกัน"),
        actions: [
          TextButton(onPressed: () {
            Navigator.of(context).pop();
          }, child: Text("ตกลง")),
        ],
      ));
    }
  }

}
