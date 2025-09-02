import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/controller/UserController.dart';

import '../share/ConfigAPI.dart';

class BankAccountController {
  void createBankAccountAdmin(
    BuildContext context,
    id_users,
    bank_account,
  ) async {
    print("Start");
    Map<String, dynamic> data = {
      'id_users': id_users,
      // 'email': userData['email'],
      // 'password': _confirmPassWord,
      'name_bank_account': bank_account['name_bank_account'],
      'name_account': bank_account['name_account'],
      "bank_account_number": bank_account['bank_account_number'],
      "prompt_pay": bank_account['prompt_pay'],
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
    // request.fields['email'] = data['email'].toString();
    // request.fields['password'] = data['password'].toString();
    request.fields['name_bank_account'] = data['name_bank_account'].toString();
    request.fields['name_account'] = data['name_account'].toString();
    request.fields['bank_account_number'] = data['bank_account_number']
        .toString();
    request.fields['prompt_pay'] = data['prompt_pay'].toString();

    final response = await request.send();
    if (response.statusCode == 201) {
      print("Successfully.");
      UserController().fetchOneUserDetail(id_users: data['id_users']);
      Navigator.pop(context);
    } else {
      print(
        "object::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::",
      );
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("ล้มเหลว"),
          content: Text("ข้อมููลไม่ถูกต้อง/มีบัญชีผู้ใช้อยู่แล้ว"),
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

  void editBankAccountAdmin(
    BuildContext context,
    id_users,
    bank_account,
  ) async {
    Map<String, dynamic> data = {
      'id_users': id_users,
      // 'email': userData['email'],
      // 'password': _confirmPassWord,
      'name_bank_account': bank_account['name_bank_account'],
      'name_account': bank_account['name_account'],
      "bank_account_number": bank_account['bank_account_number'],
      "prompt_pay": bank_account['prompt_pay'],
    };
    print(bank_account);
    String url = ConfigAPI().getEditBankAccountAdmin();
    final uri = Uri.parse(url);

    final request = http.MultipartRequest('POST', uri);

    print("${data}jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj");

    request.headers['Content-Type'] = 'application/json';

    request.fields['id_users'] = data['id_users'].toString();
    request.fields['name_bank_account'] = data['name_bank_account'].toString();
    request.fields['name_account'] = data['name_account'].toString();
    request.fields['bank_account_number'] = data['bank_account_number']
        .toString();
    request.fields['prompt_pay'] = data['prompt_pay'].toString();

    final response = await request.send();
    if (response.statusCode == 201) {
      print("Successfully.");
      UserController().fetchOneUserDetail(id_users: data['id_users']);
      // Navigator.pop(context);
    } else {
      print(
        "object::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::",
      );
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("ล้มเหลว"),
          content: Text("ข้อมููลไม่ถูกต้อง"),
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
}
