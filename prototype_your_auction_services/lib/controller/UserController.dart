import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/admin/screen_admin/UserListAdmin.dart';
import 'package:prototype_your_auction_services/model/admin_model/UserListAdminModel.dart';
import 'package:prototype_your_auction_services/share/ConfigAPI.dart';

class UserController {
  Future<Map<String, dynamic>> fetchUserListData() async {
    String url = ConfigAPI().getUserListAdmin();
    Uri uri = Uri.parse(url);
    final response = await http.get(uri);
    Map<String, dynamic> resData = jsonDecode(response.body);
    print("CONTROLLER:: ${resData}");
    return resData;
  }

  Future<Map> fetchOneUserDetail({required var id_users}) async {
    // print("aaaa");
    String url = ConfigAPI().getOneUserApi(id_users: id_users);
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final resData = jsonDecode(response.body);
    // print(resData['data'].toString());
    final data = resData['data'];
    // print("SSSSSS" + data.toString());
    return data;
    print("bbbb");
  }

  void deleteUserAdmin(BuildContext context, var id_users) async {
    String url = ConfigAPI().getDeleteUserAdminApi(id_users: id_users);

    Uri uri = Uri.parse(url);
    final response = await http.delete(uri);

    if (response.statusCode == 200) {
      print("Successfully.");

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => UserListAdmin(),));
    } else {
      throw Exception('Failed Status Code: ${response.statusCode}');
    }
  }

  void editUserProfile(BuildContext context, _imageData, user_data) async {
    print("Start");
    final userData = UserListAdminModel.getOneUserDetail();
    Map<String, dynamic> data = {
      'id_users': userData['id_users'],
      // 'email': userData['email'],
      // 'password': _confirmPassWord,
      "first_name_users": user_data['first_name_users'],
      "last_name_users": user_data['last_name_users'],
      "phone": user_data['phone'],
      "address": user_data['address'],
      // "confirm_password" : _confirmPassWord,
    };


    // print(":::::::::::::::::::::: ${data.toString()}");
    String url = ConfigAPI().getEditMyUserProfileServerPost();
    final uri = Uri.parse(url);
    print("${data}aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
    // final response = await http.post(
    //   uri,
    //   headers: {"Content-Type": "application/json"},
    //   body: jsonEncode(data),
    // );

    final request = http.MultipartRequest('POST', uri);

    request.headers['Content-Type'] = 'application/json';

    if (_imageData != null) {
      File? _imageDataFile = _imageData as File;
      var stream = File(_imageDataFile!.path.toString())
          .readAsBytesSync();
      var multiport = http.MultipartFile.fromBytes(
          'image_profile', stream, filename: _imageDataFile!.path);
      request.files.add(multiport);
      request.fields['image_profile'] = request.files.toString();
    }
    request.fields['id_users'] = data['id_users'].toString();
    // request.fields['email'] = data['email'].toString();
    // request.fields['password'] = data['password'].toString();

    request.fields['first_name_users'] = data!['first_name_users'].toString();
    request.fields['last_name_users'] = data!['last_name_users'].toString();
    request.fields['phone'] = data!['phone'].toString();
    request.fields['address'] = data!['address'].toString();
    // final resData = jsonDecode(response.body);
    // Map<String, dynamic> newUserData = resData['data'];
    // print(resData['data']);

    // ShareData.userData = resData['data'] as Map<String, dynamic>;
    // print(ShareData.userData);
    // print("object::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
    final response = await request.send();
    if (response.statusCode == 200) {
      print("Successfully.");
      // Navigator.pop(ctx);
      // Navigator.pop(context);
      UserController().fetchOneUserDetail(id_users: userData['id_users']);
      UserController().fetchUserListData();
      // Navigator.pop(context);
      // Navigator.pop(context);
    } else {
      print(
          "${response
              .statusCode}object::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
      showDialog(context: context,
        builder: (context) =>
            AlertDialog(
              title: Text("ล้มเหลว"),
              content: Text("รหัสผ่านไม่ถูกต้อง"),
              actions: [
                TextButton(onPressed: () =>
                {
                  Navigator.of(context).pop()
                }, child: Text("ตกลง"))
              ],
            ),
      );
      throw Exception("err");
    }
    print("End.");
  }


}
