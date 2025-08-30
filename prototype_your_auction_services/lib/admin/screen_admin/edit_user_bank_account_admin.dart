import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/controller/BankAccountController.dart';
import 'package:prototype_your_auction_services/model/admin_model/UserListAdminModel.dart';

class EditUserBankAccountAdmin extends StatefulWidget {
  State<EditUserBankAccountAdmin> createState() {
    return EditUserBankAccountAdminState();
  }
}

class EditUserBankAccountAdminState extends State<EditUserBankAccountAdmin> {
  final _name_bank_account_controller = TextEditingController();
  final _name_account_controller = TextEditingController();
  final _bank_account_number_controller = TextEditingController();
  final _prompt_pay_controller = TextEditingController();
  Map user_data = UserListAdminModel.getOneUserDetail();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("เพิ่มบัญชีธนาคาร ${user_data['id_users']}")),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          TextField(
            controller: _name_bank_account_controller,
            decoration: InputDecoration(
              label: Text("ชื่อธนาคาร"),
              border: OutlineInputBorder(),
              hintText: "ชื่อธนาคาร",
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: _name_account_controller,
            decoration: InputDecoration(
              label: Text("ชื่อบัญชีธนาคาร"),
              border: OutlineInputBorder(),
              hintText: "ชื่อบัญชีธนาคาร",
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: _bank_account_number_controller,
            decoration: InputDecoration(
              label: Text("เลขบัญชีธนาคาร"),
              border: OutlineInputBorder(),
              hintText: "เลขบัญชีธนาคาร",
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: _prompt_pay_controller,
            decoration: InputDecoration(
              label: Text("พร้อมเพย์"),
              border: OutlineInputBorder(),
              hintText: "พร้อมเพย์",
            ),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              BankAccountController().createBankAccountAdmin(
                context,
                user_data['id_users'],
                editBankAccount(),
              );
            },
            child: Text("เพิ่มบัญชีธนาคาร"),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> editBankAccount() {
    Map<String, dynamic> bank_account_data = {};
    if (_name_bank_account_controller.text != null) {
      bank_account_data['name_bank_account'] =
          _name_bank_account_controller.text;
    }
    if (_name_account_controller.text != null) {
      bank_account_data['name_account'] = _name_account_controller.text;
    }
    if (_bank_account_number_controller.text != null) {
      bank_account_data['bank_account_number'] =
          _bank_account_number_controller.text;
    }
    if (_prompt_pay_controller.text != null) {
      bank_account_data['prompt_pay'] = _prompt_pay_controller.text;
    }
    return bank_account_data;
  }
}
