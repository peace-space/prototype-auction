import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:prototype_your_auction_services/screen/Login.dart';
import 'package:prototype_your_auction_services/share/ApiPathServer.dart';
import 'package:prototype_your_auction_services/share/ShareUserData.dart';

class Register extends StatefulWidget {
  State<Register> createState() {
    return RegisterState();
  }
}

class RegisterState extends State<Register> {
  var _firstName = TextEditingController();
  var _lastName = TextEditingController();
  var _phone = TextEditingController();
  var _email = TextEditingController();
  var _address = TextEditingController();
  var _passWord = TextEditingController();
  var _verifyPassWord = TextEditingController();
  var _imageData;

  String message = "";

  bool _hiddenPassWord = true;
  bool _hiddenPassWordVerifyPassWord = true;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ลงทะเบียน")),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          showImage(),
          selectImageTextButton(),
          deleteImageTextButton(),
          alertText(),
          SizedBox(height: 8),
          firstName(),
          SizedBox(height: 8),
          lastName(),
          SizedBox(height: 8),
          phone(),
          SizedBox(height: 8),
          email(),
          SizedBox(height: 8),
          address(),
          SizedBox(height: 8),
          passWord(),
          SizedBox(height: 8),
          verifyPassWord(),
          SizedBox(height: 8),
          SizedBox(height: 8),
          registerButton(context),
          SizedBox(
            height: 200,
          ),
        ],
      ),
    );
  }

  Widget alertText() {
    return Text(
      message,
      textScaler: TextScaler.linear(1.5),
      style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.red),
    );
  }

  Widget firstName() {
    return TextField(
      controller: _firstName,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          label: Text("ชื่อ"),
          hintText: "ชื่อจริง"),
    );
  }

  Widget lastName() {
    return TextField(
      controller: _lastName,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          label: Text('นามสกุล'),
          hintText: "นามสกุล"),
    );
  }

  Widget phone() {
    return TextField(
      controller: _phone,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          label: Text("เบอร์โทร"),
          hintText: "เบอร์โทร"),
    );
  }

  Widget email() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      autofillHints: [
        AutofillHints.email
      ],
      controller: _email,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          label: Text("อีเมล"),
          hintText: "อีเมล"),
    );
  }

  Widget address() {
    return TextField(
      controller: _address,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          label: Text("ที่อยู่ในการรับสินค้า"),
          hintText: "ที่อยู่ในการรับสินค้า"),
    );
  }

  Widget passWord() {
    return TextField(
      controller: _passWord,
      obscureText: _hiddenPassWord,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: Text("รหัสผ่าน"),
        hintText: "รหัสผ่าน",
        suffixIcon: IconButton(
          onPressed:
              () => {
                setState(() {
                  if (_hiddenPassWord) {
                    _hiddenPassWord = false;
                  } else {
                    _hiddenPassWord = true;
                  }
                }),
              },
          icon: Icon(_hiddenPassWord ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }

  Widget verifyPassWord() {
    return TextField(
      controller: _verifyPassWord,
      obscureText: _hiddenPassWordVerifyPassWord,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: Text("ยืนยันรหัสผ่าน"),
        hintText: "ยืนยันรหัสผ่าน",
        suffixIcon: IconButton(
          onPressed:
              () => {
                setState(() {
                  if (_hiddenPassWordVerifyPassWord) {
                    _hiddenPassWordVerifyPassWord = false;
                  } else {
                    _hiddenPassWordVerifyPassWord = true;
                  }
                }),
              },
          icon: Icon(
            _hiddenPassWordVerifyPassWord
                ? Icons.visibility
                : Icons.visibility_off,
          ),
        ),
      ),
    );
  }

  Widget showImage() {
    if (_imageData != null) {
      if (kIsWeb) {
        return CircleAvatar(
            radius: 200,
            backgroundImage: NetworkImage(_imageData.path));
      } else if (Platform.isAndroid) {
        return CircleAvatar(
            radius: 150,
            backgroundImage: FileImage(_imageData)
        );
      } else {
        return CircleAvatar(
          radius: 150,
          backgroundImage: NetworkImage(
            ApiPathServer().getImageProfileApiServerGet(image_profile_path:
                ShareData.userData['image_profile'])
            ,
          ),
        );
      }
    } else {
      return Center(
        child: Image.network(
          'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/get-image-profile/storage/images/user-profile-image/profile-default-image.png',
        ),
      );
    }
  }

  Widget selectImageTextButton() {
    return TextButton(
      onPressed: () => {selectImage()},
      child: Text('เพิ่มรูปภาพ'),
    );
  }

  Widget deleteImageTextButton() {
    return TextButton(
        onPressed: () =>
        {
          setState(() {
            _imageData = null;
          })
        }, child: Text('ลบรูปภาพที่เลือก'));
  }

  void selectImage() async {
    if (kIsWeb) {
      FilePickerResult? selectImage = await FilePicker.platform.pickFiles();
      if (selectImage != null) {
        PlatformFile? imageFile = selectImage.files.first;
        setState(() {
          _imageData = imageFile;
        });
      }
    } else if (Platform.isAndroid) {
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
  }

  Widget registerButton(BuildContext ctx) {
    return ElevatedButton(
      onPressed: () => {onRegister(ctx)},
      child: Text("ลงทะเบียน"),
    );
  }

  bool hasData() {
    if (_firstName.text != "" &&
        _phone.text != "" &&
        _address.text != "" &&
        _passWord.text != "" &&
        _verifyPassWord.text != "" &&
        EmailValidator.validate(_email.text)) {
      return true;
    } else {
      return false;
    }
  }

  void goToLogin(BuildContext ctx) {
    var route = MaterialPageRoute(builder: (ctx) => Login());

    Navigator.pushReplacement(ctx, route);
  }

  void onRegister(BuildContext ctx) async {

    if (hasData()) {
      if (_passWord.text == _verifyPassWord.text) {
        String email = _email.text;
        if (_email.text == "") {
          email = "";
        } else {
          email = _email.text;
        }

        Map<String, dynamic> data = {
          'first_name_users': _firstName.text,
          'last_name_users': _lastName.text,
          'phone': _phone.text,
          'email': email,
          'address': _address.text,
          'password': _passWord.text,
          // 'image_profile':
        };


        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) =>
                Container(
                  width: 200,
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("กำลังบันทึกข้อมูล...", style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none
                      ),),
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(onPressed: () =>
                      {
                        Navigator.of(context).pop()
                      }, child: Text('ยกเลิก', style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                          color: Colors.white
                      ),)),
                    ],
                  ),
                )
        );
        // SafeArea(
        //     child: Center(
        //       child: CircularProgressIndicator(),
        //     )
        // );

        String url = 'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/register';
        // String url = 'http://192.168.1.248/001.Work/003.Project-2567/Prototype-Your-Auction-Services/api-prototype-your-auction-service/public/api/v1/register';
        final uri = Uri.parse(url);
        // final response = await http.post(
        //   uri,
        //   headers: {"Content-Type": "application/json"},
        //   body: jsonEncode(data),
        // );

        final request = http.MultipartRequest('POST', uri);

        request.headers['Content-Type'] = 'application/json';

        if (_imageData != null) {
          if (kIsWeb) {
            PlatformFile? _imageDataPlatformFile = _imageData as PlatformFile;
            var stream = _imageDataPlatformFile.bytes!;

            var multipart = http.MultipartFile.fromBytes(
                'image_profile', stream,
                filename: _imageDataPlatformFile.path.toString());

            request.files.add(multipart);
            request.fields['image_profile'] = request.files.toString();
          } else if (Platform.isAndroid) {
            File? _imageDataFile = _imageData as File;
            var stream = File(_imageDataFile!.path.toString())
                .readAsBytesSync();
            var multiport = http.MultipartFile.fromBytes(
                'image_profile', stream, filename: _imageDataFile!.path);
            request.files.add(multiport);
            request.fields['image_profile'] = request.files.toString();
          }
        }

        request.fields['first_name_users'] = data['first_name_users'];
        request.fields['last_name_users'] = data['last_name_users'];
        request.fields['phone'] = data['phone'];
        request.fields['email'] = data['email'];
        request.fields['password'] = data['password'];
        request.fields['address'] = data['address'];


        final response = await request.send();



        if (response.statusCode == 201) {
          setState(() {
            message = "Successfully.";
            goToLogin(ctx);
          });
        } else {
          setState(() {
            message =
            "ข้อมูลไม่ถูกต้อง/มีบัญชีผู้ใช้งานอยู่แล้ว\nหรืออาจมีอีเมล/เบอร์โทรที่ถูกใช้งานแล้ว";
          });
        }

        // if (response.statusCode == 201) {
        //   setState(() {
        //     message = "Successfully.";
        //     goToLogin(ctx);
        //   });
        // } else {
        //   setState(() {
        //     message = "ข้อมูลไม่ถูกต้อง/มีบัญชีผู้ใช้งานอยู่แล้ว";
        //   });
        // }
      } else {
        setState(() {
          message = "รหัสผ่านไม่ตรงกัน";
        });
      }
    } else {
      String msg = "";
      if (_firstName.text == "") {
        msg = "กรุณากรอกชื่อ";
      } else if (_phone.text == "") {
        msg = "กรุณากรอกเบอร์โทรที่ต้องการใช้เข้าสู่ระบบ";
      } else if (_email.text == "") {
        msg = "กรุณากรอกเมล";
      } else if (!EmailValidator.validate(_email.text)) {
        msg = "รูปแบบอีเมลไม่ถูกต้อง";
      } else if (_address.text == "") {
        msg = "กรุณากรอกที่อยู่ในการรับสินค้า";
      } else if (_passWord.text == "") {
        msg = "กรุณากรอกรหัสผ่าน";
      } else if (_verifyPassWord.text == "") {
        msg = "กรุณากรอกรหัสผ่านเพื่อยืนยัน";
      } else {
        msg = "เกิดข้อผิดผลาดในการกรอกข้อมูล";
      }
      setState(() {
        message = msg;
      });
    }
    print("End.");
  }
}
