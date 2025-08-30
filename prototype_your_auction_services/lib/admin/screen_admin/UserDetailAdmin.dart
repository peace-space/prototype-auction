import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prototype_your_auction_services/channel/UserDetailChannel.dart';
import 'package:prototype_your_auction_services/controller/UserController.dart';
import 'package:prototype_your_auction_services/model/admin_model/UserListAdminModel.dart';
import 'package:prototype_your_auction_services/share/ConfigAPI.dart';
import 'package:prototype_your_auction_services/share/ShareUserData.dart';

class UserDetailAdmin extends StatefulWidget {
  State<UserDetailAdmin> createState() {
    return UserDetailAdminState();
  }
}

class UserDetailAdminState extends State<UserDetailAdmin> {
  late Map user_detail = UserListAdminModel.getOneUserDetail();
  final _first_name_users_controller = TextEditingController();
  final _last_name_users_controller = TextEditingController();
  final _phone_controller = TextEditingController();
  final _email_controller = TextEditingController();
  final _addtess_controller = TextEditingController();
  final _name_bank_account_controller = TextEditingController();
  final _name_account_controller = TextEditingController();
  final _bank_account_number_controller = TextEditingController();
  final _prompt_pay_controller = TextEditingController();
  bool edit_data = false;
  var _imageData;

  // bool edit_name = false;
  // bool edit_phone = false;
  // bool edit_email = false;
  // bool edit_addtess = false;
  // bool edit_name_bank_account = false;
  // bool edit_name_account = false;
  // bool edit_bank_account_number = false;
  // bool edit_prompt_pay = false;

  // UserController userController = UserController();
  // late Future<Map> user_detail = userController.fetchOneUserDetail(id_users: user_detail['id_users']);

  @override
  void initState() {

    super.initState();
  }

  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("UserID: ${user_detail['id_users']}"),
    //   ),
    //   body: ListView(
    //     padding: EdgeInsets.all(20),
    //     children: [
    //       Text("รหัสผู้ใช้งาน: ${user_detail['id_users']}",
    //         textScaler: TextScaler.linear(1.5),),
    //       Text("ชื่อ: ${user_detail['first_name_users']}",
    //           textScaler: TextScaler.linear(1.5)),
    //       Text("เบอร์โทร: ${user_detail['phone']}", textScaler: TextScaler.linear(1.5)),
    //       Text("อีเมล: ${user_detail['email']}", textScaler: TextScaler.linear(1.5)),
    //       Text("ที่อยู่: ${user_detail['address']}", textScaler: TextScaler.linear(1.5)),
    //       buttonEditUserProfile(context, user_detail['id_users']),
    //       deleteUserButton(context)
    //     ],
    //   ),
    // );
    // UserController().fetchOneUserDetail(id_users: 1);
    return Scaffold(
      appBar: AppBar(
        title: Text("ข้อมูลผู้ใช้งาน"),
      ),
      body: StreamBuilder(
        // stream: user_detail.asStream(),
        stream: UserDetailChannel
            .connent(user_detail['id_users'])
            .stream,
        builder: (context, snapshot) {
          // print("${snapshot.data}");

          if (snapshot.hasError) {
            return Center(
              child: Text("Error."),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData) {
            return Center(
                child: Text("ไม่มีข้อมูล...")
            );
          }

          // if (snapshot.hasData) {
          //   var a = jsonDecode(snapshot.data);
          //
          //   var b = jsonDecode(a['data']);
          //   return Text("ssss: ${b['data']['user_data']}");
          // }

          if (snapshot.hasData) {
            // Map<String, dynamic> user_data = snapshot.data['user_data'];
            // Map<String, dynamic> bank_account_user = snapshot
            //     .data['bank_account'];
            var user_data;
            var bank_account_user;
            var userData;
            var dataJson = jsonDecode(snapshot.data);
            // print("dataJson: ${dataJson}");

            if (dataJson['event'] == "App\\Events\\UserDetailEvent") {
              // print("${userData['data']}");
              userData = jsonDecode(dataJson['data']);
              userData = userData['data'];
              user_data = userData['user_data'];
              bank_account_user = userData['bank_account'];
            } else if (dataJson['event'] == "pusher:ping") {
              Map<String, dynamic> subscription = {
                "event": "pusher:ping", "data": {"channel": "user"}};
              // channel.sink.add(jsonEncode(subscription));
              print("::: Ping :::");
            } else if (dataJson['event'] == "pusher:pong") {
              Map<String, dynamic> subscription = {
                "event": "pusher:pong", "data": {"channel": "user"}};
              // channel.sink.add(jsonEncode(subscription));
              // UserController userController = UserController();
              // userController.fetchUserListData();
              print("::: Pong :::");
            }

            // return Text("${user_data}");
            if (user_data == null || bank_account_user == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (user_data != null && bank_account_user != null) {
              // print(user_data['image_profile']);
              // String image_profile = user_data['image_profile'];
              // String image_profile = '/storage/images/user-profile-image/profile-default-image.png';
              return ListView(
            padding: EdgeInsets.all(20),
            children: [
              CircleAvatar(
                radius: 150,
                backgroundImage: NetworkImage(
                    "${ConfigAPI().getImageProfileApiServerGet(
                        image_profile_path: user_data['image_profile'])}"
                ),
              ),
              buttonSelectImage(),
              // Text("${user_data}"),
              Text("ID User: ${user_data['id_users']}"),
              name("${user_data['first_name_users']}",
                  " ${user_data['last_name_users']}"),
              phone("${user_data['phone']}"),
              email("${user_data['email']}"),
              address("${user_data['address']}"),


              Text("สร้างบัญชีเมื่อ: ${user_data['created_at']}"),
              Text("อัพเดทล่าสุด: ${user_data['created_at']}"),
              Divider(),
              Text("บัญชีธนาคาร"),

              nameBankAccount("${bank_account_user['name_bank_account']}"),
              nameAccount("${bank_account_user['name_account']}"),
              bankAccountNumber("${bank_account_user['bank_account_number']}"),
              promptPay("${bank_account_user['prompt_pay']}"),
              // Text(
              //     "ชื่อเจ้าของบัญชี: ${bank_account_user['name_bank_account']}"),
              // Text("ชื่อบัญชีธนาคาร: ${bank_account_user['name_account']}"),
              // Text(
              //     "เลขบัญชีธนาคาร: ${bank_account_user['bank_account_number']}"),
              // Text("พร้อมเพย์: ${bank_account_user['prompt_pay']}"),
              Text("สร้างบัญชีเมื่อ: ${bank_account_user['created_at']}"),
              Text("อัพเดทล่าสุด: ${bank_account_user['created_at']}"),
              Divider(),
              editDataButton(),
              // ElevatedButton(onPressed: () {
              //   editData();
              // }, child: Text("แก้ไขข้อมูล")),
              deleteButton(user_data),
              SizedBox(
                height: 50,
              )
            ],
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },),
    );
  }

  Widget name(String first_name_users, String last_name_users) {
    if (edit_data) {
      return Row(
        children: [
          Expanded(child: TextFormField(
            controller: _first_name_users_controller,
            decoration: InputDecoration(
                label: Text("ชื่อ"),
                border: OutlineInputBorder(),
                hintText: "${first_name_users}"
            ),
          )),
          Expanded(child: TextFormField(
            controller: _last_name_users_controller,
            decoration: InputDecoration(
                label: Text("นามสกุล"),
                border: OutlineInputBorder(),
                hintText: "${last_name_users}"
            ),
          )),
          // Expanded(
          //   child: TextButton(onPressed: (){
          //     editNameToggle();
          //   }, child: Text("ตกลง")),
          // )
        ],
      );
    } else {
      // return Text("data");
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child: Text("ชื่อ: ${first_name_users} ${last_name_users}")),
          // Expanded(
          //   child: TextButton(onPressed: () {
          //     editNameToggle();
          //   }, child: Text("แก้ไข")),
          // )
        ],
      );
    }
  }


  Widget phone(String phone) {
    if (edit_data) {
      return Row(
        children: [
          Expanded(child: TextFormField(
            controller: _phone_controller,
            decoration: InputDecoration(
                label: Text("เบอร์โทร"),
                border: OutlineInputBorder(), hintText: "${phone}"
            ),
          )),
          // Expanded(
          //   child: TextButton(onPressed: (){
          //     editPhoneToggle();
          //   }, child: Text("ตกลง")),
          // )
        ],
      );
    } else {
      // return Text("data");
      return Row(
        children: [
          Expanded(child: Text("เบอร์โทร: ${phone}")),
          // Expanded(
          //   child: TextButton(onPressed: () {
          //     editPhoneToggle();
          //   }, child: Text("แก้ไข")),
          // )
        ],
      );
    }
  }

  Widget email(String email) {
    if (edit_data) {
      return Row(
        children: [
          Expanded(child: TextFormField(
            controller: _email_controller,
            decoration: InputDecoration(
                label: Text("อีเมล"),
                border: OutlineInputBorder(), hintText: "${email}"
            ),
          )),
          // Expanded(
          //   child: TextButton(onPressed: (){
          //     editEmailToggle();
          //   }, child: Text("ตกลง")),
          // )
        ],
      );
    } else {
      // return Text("data");
      return Row(
        children: [
          Expanded(child: Text("อีเมล: ${email}")),
          // Expanded(
          //   child: TextButton(onPressed: () {
          //     editEmailToggle();
          //   }, child: Text("แก้ไข")),
          // )
        ],
      );
    }
  }

  Widget address(String address) {
    if (edit_data) {
      return Row(
        children: [
          Expanded(child: TextFormField(
            controller: _addtess_controller,
            decoration: InputDecoration(
                label: Text("ที่อยู่"),
                border: OutlineInputBorder(), hintText: "${address}"
            ),
          )),
          // Expanded(
          //   child: TextButton(onPressed: (){
          //     editAddressToggle();
          //   }, child: Text("ตกลง")),
          // )
        ],
      );
    } else {
      // return Text("data");
      return Row(
        children: [
          Expanded(child: Text("ที่อยู่: ${address}")),
          // Expanded(
          //   child: TextButton(onPressed: () {
          //     editAddressToggle();
          //   }, child: Text("แก้ไข")),
          // )
        ],
      );
    }
  }

  Widget nameBankAccount(String name_bank_account) {
    // if (edit_data) {
    //   return Row(
    //     children: [
    //       Expanded(child: TextFormField(
    //         decoration: InputDecoration(
    //           label: Text("ชื่อเจ้าของบัญชี"),
    //                         border: OutlineInputBorder(),  hintText: "${name_bank_account}"
    //         ),
    //       )),
    //       // Expanded(
    //       //   child: TextButton(onPressed: (){
    //       //     editNameBankAccountToggle();
    //       //   }, child: Text("ตกลง")),
    //       // )
    //     ],
    //   );
    // } else {
    // return Text("data");
    return Row(
      children: [
        Expanded(child: Text("ชื่อเจ้าของบัญชี: ${name_bank_account}")),
        // Expanded(
        //   child: TextButton(onPressed: () {
        //     editNameBankAccountToggle();
        //   }, child: Text("แก้ไข")),
        // )
      ],
    );
    // }
  }

  Widget nameAccount(String name_account) {
    if (edit_data) {
      return Row(
        children: [
          Expanded(child: TextFormField(
            controller: _name_account_controller,
            decoration: InputDecoration(
                label: Text("ชื่อบัญชีธนาคาร"),
                border: OutlineInputBorder(), hintText: "${name_account}"
            ),
          )),
          // Expanded(
          //   child: TextButton(onPressed: (){
          //     editNameAccountToggle();
          //   }, child: Text("ตกลง")),
          // )
        ],
      );
    } else {
      // return Text("data");
      return Row(
        children: [
          Expanded(child: Text("เลขบัญชีธนาคาร: ${name_account}")),
          // Expanded(
          //   child: TextButton(onPressed: () {
          //     editNameAccountToggle();
          //   }, child: Text("แก้ไข")),
          // )
        ],
      );
    }
  }

  Widget bankAccountNumber(String bank_account_nuber) {
    if (edit_data) {
      return Row(
        children: [
          Expanded(child: TextFormField(
            controller: _bank_account_number_controller,
            decoration: InputDecoration(
                label: Text("เลขบัญชีธนาคาร"),
                border: OutlineInputBorder(), hintText: "${bank_account_nuber}"
            ),
          )),
          // Expanded(
          //   child: TextButton(onPressed: (){
          //     editBankAccountNumber();
          //   }, child: Text("ตกลง")),
          // )
        ],
      );
    } else {
      // return Text("data");
      return Row(
        children: [
          Expanded(child: Text("เลขบัญชีธนาคาร: ${bank_account_nuber}")),
          // Expanded(
          //   child: TextButton(onPressed: () {
          //     editBankAccountNumber();
          //   }, child: Text("แก้ไข")),
          // )
        ],
      );
    }
  }

  Widget promptPay(String prompt_pay) {
    if (edit_data) {
      return Row(
        children: [
          Expanded(child: TextFormField(
            controller: _prompt_pay_controller,
            decoration: InputDecoration(
                label: Text("พร้อมเพย์"),
                border: OutlineInputBorder(), hintText: "${prompt_pay}"
            ),
          )),
          // Expanded(
          //   child: TextButton(onPressed: (){
          //     editBankAccountNumber();
          //   }, child: Text("ตกลง")),
          // )
        ],
      );
    } else {
      // return Text("data");
      return Row(
        children: [
          Expanded(child: Text("พร้อมเพย์: ${prompt_pay}")),
          // Expanded(
          //   child: TextButton(onPressed: () {
          //     editBankAccountNumber();
          //   }, child: Text("แก้ไข")),
          // )
        ],
      );
    }
  }

  Widget editDataButton() {
    if (edit_data) {
      return Column(
        children: [
          ElevatedButton(onPressed: () {
            editData();
          }, child: Text("ยกเลิก")),
          ElevatedButton(onPressed: () {
            UserController().editUserProfile(context, null, onEdit());
            editData();
          }, child: Text("บันทึกการแก้ไข")),
        ],
      );
    } else {
      return ElevatedButton(onPressed: () {
        editData();
      }, child: Text("แก้ไขข้อมูล"));
    }
  }

  Widget deleteButton(Map user_data) {
    ShareData.userData['id_users'];
    if (ShareData.userData['id_users'] == user_data['id_users']) {
      return Text("");
    } else {
      return ElevatedButton(onPressed: () {
        // print(user_data['id_users'].toString() + " <----SSSSSSSSSSSSSSSSSSSS");
        UserController().deleteUserAdmin(context, user_data['id_users']);
      }, child: Text("ลบผู้ใช้งาน"));
    }
  }


  bool editToggle(bool toggle) {
    if (toggle) {
      toggle = false;
      setState(() {});
      return toggle;
    } else {
      toggle = true;
      setState(() {});
      return toggle;
    }
  }

  void editData() {
    if (edit_data) {
      edit_data = false;
      setState(() {});
    } else {
      edit_data = true;
      setState(() {});
    }
  }

  Map<String, dynamic> onEdit() {
    Map<String, dynamic> data = {
    };
    if (_first_name_users_controller.text != null &&
        _first_name_users_controller.text != "") {
      data['first_name_users'] = _first_name_users_controller.text;
    }
    if (_last_name_users_controller.text != null &&
        _last_name_users_controller.text != "") {
      data['last_name_users'] = _last_name_users_controller.text;
    }
    if (_phone_controller.text != null && _phone_controller.text != "") {
      data['phone'] = _phone_controller.text;
    }
    if (_email_controller.text != null && _email_controller.text != "") {
      data['email'] = _email_controller.text;
    }
    if (_addtess_controller.text != null && _addtess_controller.text != "") {
      data['address'] = _addtess_controller.text;
    }
    if (_name_bank_account_controller.text != null &&
        _name_bank_account_controller.text != "") {
      data['name_bank_account'] = _name_bank_account_controller.text;
    }
    if (_name_account_controller.text != null &&
        _name_account_controller.text != "") {
      data['name_account'] = _name_account_controller.text;
    }
    if (_bank_account_number_controller.text != null &&
        _bank_account_number_controller.text != "") {
      data['bank_account_number'] = _bank_account_number_controller.text;
    }
    if (_prompt_pay_controller.text != null &&
        _prompt_pay_controller.text != "") {
      data['prompt_pay'] = _prompt_pay_controller.text;
    }
    print("${_phone_controller.text}lllllllllllllllllllllllllllllllllll");
    return data;
  }

  // Widget showImageProfile() {
  //   if (_imageData == null) {
  //     return Text("");
  //   }
  //
  //   if (_imageData != null) {
  //     return CircleAvatar(
  //       radius: 150,
  //       backgroundImage: FileImage(_imageData),
  //     );
  //   }
  //
  //   return Text("");
  // }

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
      showEditImageProfile();
      Navigator.of(context).pop();
    }
  }

  void showEditImageProfile() {
    if (_imageData != null) {
      showDialog(
          context: context, builder: (context) =>
          Expanded(
            child: Center(
              child: Container(
                child: Column(
                  children: [
                    Expanded(child: Image.file(_imageData)),
                    ElevatedButton(onPressed: () {
                      UserController().editUserProfile(
                          context, _imageData, null);
                    }, child: Text("เปลี่ยนรูป")),
                    ElevatedButton(onPressed: () {
                      Navigator.of(context).pop();
                      _imageData = null;
                      setState(() {});
                    }, child: Text("ยกเลิก"))
                  ],
                ),
              ),
            ),
          ));
    }
  }


// void editNameToggle() {
//   if (edit_name) {
//     edit_name = false;
//     setState(() {

//   });
// } else {
//   edit_name = true;
//   setState(() {

//     });
//   }
// }
// void editPhoneToggle() {
//   if (edit_phone) {
//     edit_phone = false;
//     setState(() {

//   });
// } else {
//   edit_phone = true;
//   setState(() {

//     });
//   }
// }
// void editEmailToggle() {
//   if (edit_email) {
//     edit_email = false;
//     setState(() {

//   });
// } else {
//   edit_email = true;
//   setState(() {

//     });
//   }
// }
// void editAddressToggle() {
//   if (edit_name) {
//     edit_addtess = false;
//     setState(() {});
//   } else {
//     edit_addtess = true;
//     setState(() {});
//   }
// }

// void editNameBankAccountToggle() {
//   if (edit_name_bank_account) {
//     edit_name_bank_account = false;
//     setState(() {});
//   } else {
//     edit_addtess = true;
//     setState(() {});
//   }
// }

// void editNameAccountToggle() {
//   if (edit_name_account) {
//     edit_name_account = false;
//     setState(() {});
//   } else {
//     edit_name_account = true;
//     setState(() {});
//   }
// }

// void editBankAccountNumber() {
//   if (edit_bank_account_number) {
//     edit_bank_account_number = false;
//     setState(() {});
//   } else {
//     edit_bank_account_number = true;
//     setState(() {});
//   }
// }

// void editPromptPay() {
//   if (edit_prompt_pay) {
//     edit_prompt_pay = false;
//     setState(() {});
//   } else {
//     edit_prompt_pay = true;
//     setState(() {});
//   }
// }

// Widget build(BuildContext context){
//   // return Scaffold(
//   //   appBar: AppBar(
//   //     title: Text("UserID: ${user_detail['id_users']}"),
//   //   ),
//   //   body: ListView(
//   //     padding: EdgeInsets.all(20),
//   //     children: [
//   //       Text("รหัสผู้ใช้งาน: ${user_detail['id_users']}",
//   //         textScaler: TextScaler.linear(1.5),),
//   //       Text("ชื่อ: ${user_detail['first_name_users']}",
//   //           textScaler: TextScaler.linear(1.5)),
//   //       Text("เบอร์โทร: ${user_detail['phone']}", textScaler: TextScaler.linear(1.5)),
//   //       Text("อีเมล: ${user_detail['email']}", textScaler: TextScaler.linear(1.5)),
//   //       Text("ที่อยู่: ${user_detail['address']}", textScaler: TextScaler.linear(1.5)),
//   //       buttonEditUserProfile(context, user_detail['id_users']),
//   //       deleteUserButton(context)
//   //     ],
//   //   ),
//   // );
//   return Scaffold(
//     appBar: AppBar(
//       title: Text("ข้อมูลผู้ใช้งาน"),
//     ),
//     body: FutureBuilder(
//       future: user_detail, builder: (context, snapshot) {
//       if (snapshot.hasError) {
//         return Center(
//           child: Text("Error."),
//         );
//       }
//
//       if (snapshot.connectionState == ConnectionState.active) {
//         return Center(
//           child: CircularProgressIndicator(),
//         );
//       }
//
//       if (!snapshot.hasData) {
//         return Center(
//             child: Text("ไม่มีข้อมูล")
//         );
//       }
//
//       if (snapshot.hasData) {
//         Map<String, dynamic> user_data = snapshot.data['user_data'];
//         Map<String, dynamic> bank_account_user = snapshot
//             .data['bank_account'];
//         return ListView(
//           padding: EdgeInsets.all(20),
//           children: [
//             CircleAvatar(
//               radius: 150,
//               backgroundImage: NetworkImage(
//                   "${ConfigAPI().getImageProfileApiServerGet(
//                       image_profile_path: user_data['image_profile'])}"
//               ),
//             ),
//             // Text("${user_data}"),
//             Text(
//                 "ชื่อ: ${user_data['first_name_users']} ${user_data['last_name_users']}"),
//             Text(
//                 "เบอร์โทร: ${user_data['first_name_users']} ${user_data['last_name_users']}"),
//             Text("อีเมล: ${user_data['email']}"),
//             Text("ที่อยู่: ${user_data['address']}"),
//             Text("สร้างบัญชีเมื่อ: ${user_data['created_at']}"),
//             Text("อัพเดทล่าสุด: ${user_data['created_at']}"),
//             Divider(),
//             Text("บัญชีธนาคาร"),
//             Text(
//                 "ชื่อเจ้าของบัญชี: ${bank_account_user['name_bank_account']}"),
//             Text("ชื่อบัญชีธนาคาร: ${bank_account_user['name_account']}"),
//             Text(
//                 "เลขบัญชีธนาคาร: ${bank_account_user['bank_account_number']}"),
//             Text("พร้อมเพย์: ${bank_account_user['prompt_pay']}"),
//             Text("สร้างบัญชีเมื่อ: ${bank_account_user['created_at']}"),
//             Text("อัพเดทล่าสุด: ${bank_account_user['created_at']}"),
//           ],
//         );
//       }
//       return Center(
//         child: CircularProgressIndicator(),
//       );
//     },),
//   );
// }

// Widget buttonEditUserProfile(BuildContext ctx, int id){
//   return ElevatedButton(
//           onPressed:  () {
//             Navigator.push(
//                 ctx, MaterialPageRoute(
//                 builder: (ctx) => EditUserProfile(id, user_detail)
//               )
//             );
//           },
//           child: Text("แก้ไขข้อมูลผู้ใช้งาน")
//       );
// }
// Widget userList() {
//     // userData();
//     return ListView.builder(
//       padding: EdgeInsets.all(20),
//       itemCount: user_detail.length,
//       itemBuilder: (context, index) {
//         final Map data = user_detail[index];
//         final id = !data['id_users'];
//         final name = data['first_name_users'];
//         final phone = data['phone'];
//         return Card(
//           child: ListTile(
//             title: Text(name.toString()),
//             subtitle: Text(phone.toString()),
//           )
//         );
//       },
//     );
//   }


// Widget deleteUser() {
//   return ElevatedButton(
//       onPressed: () => {
//
//       },
//       child: Text("ลบผู้ใช้งาน")
//   );
// }
//
// Widget deleteUserButton(BuildContext ctx) {
//   return ElevatedButton(
//       onPressed: () =>
//       {
//         onDeleteUser(ctx)
//       },
//       child: Text("ลบผู้ใช้งาน")
//   );
// }
//
// void onGotoUserList(BuildContext ctx) {
//   var route = MaterialPageRoute(
//     builder: (ctx) => UserListAdmin(),
//   );
//
//   Navigator.pushReplacement(ctx, route);
// }

// void onDeleteUser(BuildContext ctx) async {
//   String url = "https://your-auction-services.com/prototype-auction/api-pa/api/delete-user/${user_detail['id_users']}";
//   final uri = Uri.parse(url);
//   final response = await http.delete(uri);
//   if (response.statusCode == 200) {
//     print("Successfully.");
//     onGotoUserList(ctx);
//   } else {
//     throw Exception('Failed');
//   }
// }


}