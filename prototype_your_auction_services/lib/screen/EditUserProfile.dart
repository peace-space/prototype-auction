import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:prototype_your_auction_services/share/ConfigAPI.dart';
import 'package:prototype_your_auction_services/share/ShareUserData.dart';

class EditUserProfile extends StatefulWidget {
  State<EditUserProfile> createState() {
    return EditUserProfileState();
  }
}

class EditUserProfileState extends State<EditUserProfile> {
  var _confirmPassWordController = TextEditingController();
  var _firstNameController = TextEditingController();
  var _lastNameController = TextEditingController();
  var _phoneController = TextEditingController();
  var _emailController = TextEditingController();
  var _address = TextEditingController();

  int id_user = ShareData.userData['id_users'];
  Map<String, dynamic> userData = ShareData.userData;
  String firstName = '';
  String lastName = '';
  String phone = '';
  String email = '';
  String address = '';
  String _confirmPassWord = '';
  var _imageData;

  @override
  void initState() {
    // TODO: implement initState
    id_user = ShareData.userData['id_users'];
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("แก้ไขข้อมูลผู้ใช้งาน ${ShareData.userData['id_users']}"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          showImage(),
          SizedBox(height: 8,),
          buttonSelectImage(),
          buttonDeleteImage(),
          SizedBox(height: 8,),
          firstNameEdit(),
          SizedBox(height: 8),
          lastNameEdit(),
          SizedBox(height: 8),
          phoneEdit(),
          // SizedBox(height: 8),
          // emailEdit(),
          SizedBox(height: 16),
          addressEdit(),
          SizedBox(height: 8),
          submit(context),
          SizedBox(height: 100,),
        ],
      ),
    );
  }

  Widget firstNameEdit() {
    return TextField(
      controller: _firstNameController,
      decoration: InputDecoration(
        labelText: "ชื่อเดิม: " + userData['first_name_users'],
        border: OutlineInputBorder(),
        hintText: 'ชื่อ',
      ),
      onChanged: (value) {
        setState(() {
          firstName = value;
        });
      },
    );
  }

  Widget lastNameEdit() {
    return TextField(
      controller: _lastNameController,
      decoration: InputDecoration(
        labelText: "นามสกุลเดิม: " + userData['last_name_users'],
        border: OutlineInputBorder(),
        hintText: "นามสกุล",
      ),
      onChanged: (value) {
        setState(() {
          lastName = _lastNameController.value.text;
        });
      },
    );
  }

  Widget phoneEdit() {
    return TextField(
      controller: _phoneController,
      decoration: InputDecoration(
        labelText: "เบอร์โทรศัพท์เดิม: " + userData['phone'],
        border: OutlineInputBorder(),
        hintText: 'เบอร์โทรศัพท์',
      ),
      onChanged: (value) {
        setState(() {
          phone = _phoneController.value.text;
        });
      },
    );
  }

  // Widget emailEdit() {
  //   return TextField(
  //     controller: _emailController,
  //     decoration: InputDecoration(
  //       labelText: "อีเมลเดิม: " + userData['email'],
  //       border: OutlineInputBorder(),
  //       hintText: "อีเมล",
  //     ),
  //     onChanged: (value) {
  //       setState(() {
  //         email = _emailController.value.text;
  //       });
  //     },
  //   );
  // }

  Widget addressEdit() {
    return TextField(
      controller: _address,
      decoration: InputDecoration(
        labelText: "ที่อยู่ในการจัดส่งสินค้าเดิม: " + userData['address'],
        border: OutlineInputBorder(),
        hintText: "ที่อยู่ในการจัดส่งสินค้า",
      ),
      onChanged: (value) {
        setState(() {
          address = _address.value.text;
        });
      },
    );
  }

  Widget submit(BuildContext ctx) {
    return ElevatedButton(
      onPressed: () =>
      {
        // onSave(ctx),
        confirmChangeUserData(ctx)
      },
      child: Text("บันทึกการแก้ไข"),
    );
  }

  void onSave(BuildContext ctx) async {
    print("Start");
    Map<String, dynamic> data = {
      'id_users': ShareData.userData['id_users'],
      // 'email': ShareData.userData['email'],
      'password': _confirmPassWord,
      "first_name_users": firstName,
      "last_name_users": lastName,
      "phone": phone,
      "address": address,
      // "confirm_password" : _confirmPassWord,
    };


    // print(":::::::::::::::::::::: ${data.toString()}");
    String url = ConfigAPI().getEditMyUserProfileServerPost();
    final uri = Uri.parse(url);

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
    request.fields['password'] = data['password'].toString();

    request.fields['first_name_users'] = data['first_name_users'].toString();
    request.fields['last_name_users'] = data['last_name_users'].toString();
    request.fields['phone'] = data['phone'].toString();
    request.fields['address'] = data['address'].toString();
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
      Navigator.pop(context);
      Navigator.pop(context);
      // Navigator.pop(context);
    } else {
      print(
          "object::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
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

  void confirmChangeUserData(BuildContext ctx) {
    String confirmFirstName = firstName;
    String confirmLastName = lastName;
    String confirmPhone = phone;
    // String confirmEmail = email;
    String confirmAddress = address;
    String confirmImage = '-';

    if (firstName == '') {
      confirmFirstName = '-';
    }
    if (lastName == '') {
      confirmLastName = '-';
    }
    if (phone == '') {
      confirmPhone = '-';
    }
    // if (email == '') {
    //   confirmEmail = '-';
    // }
    if (address == '') {
      confirmAddress = '-';
    }

    if (_address != null) {
      confirmImage = 'เลือกรูปภาพแล้ว';
    }

    showDialog(
      context: context,
      builder:
          (context) =>
          AlertDialog(
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
                        Text("รูปภาพ: ",
                          style: textStyleSubjectConfirmChangeUserData(),),
                        Text("${confirmImage}",
                          style: textStyleConfirmChangeUserData(),),
                        Text(
                          "ชื่อ: ",
                          style: textStyleSubjectConfirmChangeUserData(),
                        ),
                        Text(
                          "${confirmFirstName}",
                          style: textStyleConfirmChangeUserData(),
                        ),
                        Divider(),
                        Text(
                          "นามสกุล: ",
                          style: textStyleSubjectConfirmChangeUserData(),
                        ),
                        Text(
                          "${confirmLastName}",
                          style: textStyleConfirmChangeUserData(),
                        ),
                        Divider(),
                        Text(
                          "เบอร์โทร: ",
                          style: textStyleSubjectConfirmChangeUserData(),
                        ),
                        Text(
                          "${confirmPhone}",
                          style: textStyleConfirmChangeUserData(),
                        ),
                        Divider(),
                        Text(
                          "อีเมล: ",
                          style: textStyleSubjectConfirmChangeUserData(),
                        ),
                        // Text(
                        //   "${confirmEmail}",
                        //   style: textStyleConfirmChangeUserData(),
                        // ),
                        Divider(),
                        Text(
                          "ที่อยู่ในการจัดส่ง: ",
                          style: textStyleSubjectConfirmChangeUserData(),
                        ),
                        Text(
                          "${confirmAddress}",
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
                onPressed: () =>
                {
                  // confirmPassWord(ctx),
                  onSave(ctx),
                  // Navigator.pop(context)
                },
                child: Text("OK"),
              ),
            ],
          ),
    );
  }

  // void confirmPassWord(BuildContext ctx) {
  //   showDialog(
  //     context: context,
  //     builder: (context) =>
  //         AlertDialog(
  //           title: Text("กรอกรหัสผ่านเพื่อยืนยัน"),
  //           content: TextField(
  //             obscureText: true,
  //             controller: _confirmPassWordController,
  //             decoration: InputDecoration(
  //               border: OutlineInputBorder(),
  //               hintText: "รหัสผ่าน",
  //             ), onChanged: (value) {
  //             setState(() {
  //               _confirmPassWord = value;
  //             });
  //           },
  //           ),
  //           actions: [
  //             TextButton(
  //               onPressed: () => {Navigator.pop(context)},
  //               child: Text("Cencel"),
  //             ),
  //             TextButton(
  //               onPressed: () =>
  //               {
  //                 // Navigator.pop(context),
  //                 // Navigator.pop(context),
  //                 // Navigator.pop(context),
  //                 onSave(ctx),
  //               },
  //               child: Text("OK"),
  //             ),
  //           ],
  //         ),
  //   );
  // }

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

  TextButton buttonSelectImage() {
    return TextButton(onPressed: () =>
    {
      selectImage()
    }, child: Text("เลือกรูปภาพที่ต้องการเปลี่ยน"));
  }

  void selectImage() async {
    ImagePicker selectImage = ImagePicker();

    final imageFile = await selectImage.pickImage(
      source: ImageSource.gallery,
    );

    if (imageFile != null) {
      setState(() {
        _imageData = File(imageFile.path);
      });
    }
  }


  Widget showImage() {
    if (_imageData == null) {
      return Text("");
    }

    if (_imageData != null) {
      return CircleAvatar(
        radius: 150,
        backgroundImage: FileImage(_imageData),
      );
    }

    return Text("");
  }

  TextButton buttonDeleteImage() {
    return TextButton(onPressed: () =>
    {
      onDeleteImage()
    }, child: Text("ลบรูปภาพที่เลือก"));
  }

  void onDeleteImage() {
    _imageData = null;
    setState(() {});
  }
}
