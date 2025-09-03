import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/controller/UserController.dart';

class EditPassWord extends StatefulWidget {
 @override
  State<StatefulWidget> createState() {
   return EditPassWordState();
  }

}

class EditPassWordState extends State {
  var change_password_ctl = TextEditingController();
  var old_password_ctl = TextEditingController();
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
            decoration: InputDecoration(
              label: Text("รหัสผ่านเก่า"),
              hintText: "รหัสผ่านเก่า"
            ),
          ),
          TextField(
            controller: change_password_ctl,
            decoration: InputDecoration(
                label: Text("รหัสผ่านใหม่"),
              hintText: "รหัสผ่านใหม่"
            ),
          ),
          ElevatedButton(onPressed: () {
            onChangePassWord();
          }, child: Text("เปลี่ยนรหัสผ่าน"))
        ],
      ),
    );
  }
  
  
  AlertDialog onChangePassWord() {
    return AlertDialog(
      title: Text("เปลี่ยนรหัสผ่านหรือไม่"),
      content: Text("ยืนยันการเปลี่ยนรหัาผ่าน"),
      actions: [
        TextButton(onPressed: () {
          Navigator.of(context).pop();
        }, child: Text("ยกเลิก")),
        TextButton(onPressed: () {
          UserController().onChangePassWordUser(new_password: change_password_ctl.text, old_password: old_password_ctl.text);
          Navigator.of(context).pop();
        } , child: Text("ตกลง"))
      ],
    );
  }

}
