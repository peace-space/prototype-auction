import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/share/ConfigAPI.dart';
import 'package:prototype_your_auction_services/share/ShareUserData.dart';

class CreateBankAccountUser extends StatefulWidget {
  State<CreateBankAccountUser> createState() {
    return CreateBankAccountUserState();
  }
}

class CreateBankAccountUserState extends State<CreateBankAccountUser> {
  var _confirmPassWordController = TextEditingController();
  var _nameBankAccountController = TextEditingController();
  var _nameAccountController = TextEditingController();
  var _bankAccountNumberController = TextEditingController();
  var _promptPayController = TextEditingController();

  int id_user = ShareData.userData['id_users'];
  Map<String, dynamic> userData = ShareData.userData;
  Map<String, dynamic> bankAccountUser = ShareData.bankAccountUser;
  String name_bank_account = '';
  String name_account = '';
  String bank_account_number = '';
  String prompt_pay = '';
  String _confirmPassWord = '';

  @override
  void initState() {
    // TODO: implement initState
    id_user = ShareData.userData['id_users'];
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("เพิ่มบัญชีธนาคาร ${ShareData.userData['id_users']}"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          SizedBox(height: 8),
          nameBankAccount(),
          SizedBox(height: 8),
          nameAccount(),
          SizedBox(height: 8),
          bankAccountNumber(),
          SizedBox(height: 8),
          promptPay(),
          SizedBox(height: 8),
          submit(context),
          SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget nameBankAccount() {
    return TextField(
      controller: _nameBankAccountController,
      decoration: InputDecoration(
        labelText: "ชื่อธนาคาร",
        border: OutlineInputBorder(),
        hintText: 'ชื่อธนาคาร',
      ),
      onChanged: (value) {
        setState(() {
          name_bank_account = value;
        });
      },
    );
  }

  Widget nameAccount() {
    return TextField(
      controller: _nameAccountController,
      decoration: InputDecoration(
        labelText: "ชื่อบัญชี",
        border: OutlineInputBorder(),
        hintText: "ชื่อบัญชี",
      ),
      onChanged: (value) {
        setState(() {
          name_account = _nameAccountController.value.text;
        });
      },
    );
  }

  Widget bankAccountNumber() {
    return TextField(
      controller: _bankAccountNumberController,
      decoration: InputDecoration(
        labelText: "เลขบัญชีธนาคาร",
        border: OutlineInputBorder(),
        hintText: 'เลขบัญชีธนาคาร',
      ),
      onChanged: (value) {
        setState(() {
          bank_account_number = _bankAccountNumberController.value.text;
        });
      },
    );
  }

  Widget promptPay() {
    return TextField(
      controller: _promptPayController,
      decoration: InputDecoration(
        labelText: "พร้อมเพย์",
        border: OutlineInputBorder(),
        hintText: "อีเมล",
      ),
      onChanged: (value) {
        setState(() {
          prompt_pay = _promptPayController.value.text;
        });
      },
    );
  }

  Widget submit(BuildContext ctx) {
    return ElevatedButton(
      onPressed:
          () => {
            // onSave(ctx),
            confirmChangeUserData(ctx),
          },
      child: Text("บันทึกการแก้ไข"),
    );
  }

  void onSave(BuildContext ctx) async {
    print("Start");
    Map<String, dynamic> data = {
      'id_users': ShareData.userData['id_users'],
      'email': ShareData.userData['email'],
      'password': _confirmPassWord,
      'name_bank_account': name_bank_account,
      'name_account': name_account,
      "bank_account_number": bank_account_number,
      "prompt_pay": prompt_pay,
    };

    print('AAAAAAAAAAAAAAAAAAAAAAAAAAAA: ${data.toString()}');

    // print(":::::::::::::::::::::: ${data.toString()}");
    String url = ConfigAPI().getCreateBankAccountServerPost();
    final uri = Uri.parse(url);

    // final response = await http.post(
    //   uri,
    //   headers: {"Content-Type": "application/json"},
    //   body: jsonEncode(data),
    // );

    final request = http.MultipartRequest('POST', uri);

    request.headers['Content-Type'] = 'application/json';

    request.fields['id_users'] = data['id_users'].toString();
    request.fields['email'] = data['email'].toString();
    request.fields['password'] = data['password'].toString();
    request.fields['name_bank_account'] = data['name_bank_account'].toString();
    request.fields['name_account'] = data['name_account'];
    request.fields['bank_account_number'] =
        data['bank_account_number'].toString();
    request.fields['prompt_pay'] = data['prompt_pay'].toString();

    final response = await request.send();
    if (response.statusCode == 201) {
      print("Successfully.");
      // Navigator.pop(ctx);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      print(
        "object::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::",
      );
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text("ล้มเหลว"),
              content: Text("รหัสผ่านไม่ถูกต้อง/ข้อมูลไม่ครบ"),
              actions: [
                TextButton(
                  onPressed: () => {Navigator.of(context).pop()},
                  child: Text("ตกลง"),
                ),
              ],
            ),
      );
      throw Exception("err");
    }
    print("End.");
  }

  void confirmChangeUserData(BuildContext ctx) {
    String confirm_name_bank_account = name_bank_account;
    String confirm_name_account = name_account;
    String confirm_bank_account_number = bank_account_number;
    String confirm_prompt_pay = prompt_pay;

    if (name_bank_account == '') {
      confirm_name_bank_account = '-';
    }
    if (name_account == '') {
      confirm_name_account = '-';
    }
    if (bank_account_number == '') {
      confirm_bank_account_number = '-';
    }

    if (prompt_pay == '') {
      confirm_prompt_pay = '-';
    }

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("แจ้งเตือน"),
            content: Container(
              height: 500,
              width: 300,
              child: Expanded(
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "ยืนยันการเปลี่ยนแปลงข้อมูล",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          "ชื่อธนาคาร: ",
                          style: textStyleSubjectConfirmChangeUserData(),
                        ),
                        Text(
                          "${confirm_name_bank_account}",
                          style: textStyleConfirmChangeUserData(),
                        ),
                        Divider(),
                        Text(
                          "ชื่อบัญชี: ",
                          style: textStyleSubjectConfirmChangeUserData(),
                        ),
                        Text(
                          "${confirm_name_account}",
                          style: textStyleConfirmChangeUserData(),
                        ),
                        Divider(),
                        Text(
                          "เลขบัญชี: ",
                          style: textStyleSubjectConfirmChangeUserData(),
                        ),
                        Text(
                          "${confirm_bank_account_number}",
                          style: textStyleConfirmChangeUserData(),
                        ),
                        Divider(),
                        Text(
                          "พร้อมเพย์: ",
                          style: textStyleSubjectConfirmChangeUserData(),
                        ),
                        Text(
                          "${confirm_prompt_pay}",
                          style: textStyleConfirmChangeUserData(),
                        ),
                        Divider(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => {Navigator.pop(context)},
                child: Text("Cencel"),
              ),
              TextButton(
                onPressed:
                    () => {
                      confirmPassWord(ctx),
                      // Navigator.pop(context)
                    },
                child: Text("OK"),
              ),
            ],
          ),
    );
  }

  void confirmPassWord(BuildContext ctx) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("กรอกรหัสผ่านเพื่อยืนยัน"),
            content: TextField(
              obscureText: true,
              controller: _confirmPassWordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "รหัสผ่าน",
              ),
              onChanged: (value) {
                setState(() {
                  _confirmPassWord = value;
                });
              },
            ),
            actions: [
              TextButton(
                onPressed: () => {Navigator.pop(context)},
                child: Text("Cencel"),
              ),
              TextButton(
                onPressed:
                    () => {
                      // Navigator.pop(context),
                      // Navigator.pop(context),
                      // Navigator.pop(context),
                      onSave(ctx),
                    },
                child: Text("OK"),
              ),
            ],
          ),
    );
  }

  TextStyle textStyleSubjectConfirmChangeUserData() {
    return TextStyle(fontSize: 16);
  }

  TextStyle textStyleConfirmChangeUserData() {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.blue,
    );
  }
}
