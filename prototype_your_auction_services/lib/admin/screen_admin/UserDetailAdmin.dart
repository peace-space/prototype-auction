import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/model/admin_model/UserListAdminModel.dart';
import 'package:prototype_your_auction_services/share/ConfigAPI.dart';

class UserDetailAdmin extends StatefulWidget {
  State<UserDetailAdmin> createState() {
    return UserDetailAdminState();
  }
}

class UserDetailAdminState extends State<UserDetailAdmin> {
  UserListAdminModel userListAdminModel = UserListAdminModel();
  late Future user_detail = userListAdminModel.getOneUserDetail();

  // UserController userController = UserController();
  // late Future<Map> user_detail = userController.fetchOneUserDetail(id_users: user_detail['id_users']);

  @override
  void initState() {

    super.initState();
  }

  Widget build(BuildContext context){
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
    return Scaffold(
      appBar: AppBar(
        title: Text("ข้อมูลผู้ใช้งาน"),
      ),
      body: FutureBuilder(
        future: user_detail, builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Error."),
          );
        }

        if (snapshot.connectionState == ConnectionState.active) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData) {
          return Center(
              child: Text("ไม่มีข้อมูล")
          );
        }

        if (snapshot.hasData) {
          Map<String, dynamic> user_data = snapshot.data['user_data'];
          Map<String, dynamic> bank_account_user = snapshot
              .data['bank_account']['data'];
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
              // Text("${user_data}"),
              Text(
                  "ชื่อ: ${user_data['first_name_users']} ${user_data['last_name_users']}"),
              Text(
                  "เบอร์โทร: ${user_data['first_name_users']} ${user_data['last_name_users']}"),
              Text("อีเมล: ${user_data['email']}"),
              Text("ที่อยู่: ${user_data['address']}"),
              Text("สร้างบัญชีเมื่อ: ${user_data['created_at']}"),
              Text("อัพเดทล่าสุด: ${user_data['created_at']}"),
              Divider(),
              Text("บัญชีธนาคาร"),
              Text(
                  "ชื่อเจ้าของบัญชี: ${bank_account_user['name_bank_account']}"),
              Text("ชื่อบัญชีธนาคาร: ${bank_account_user['name_account']}"),
              Text(
                  "เลขบัญชีธนาคาร: ${bank_account_user['bank_account_number']}"),
              Text("พร้อมเพย์: ${bank_account_user['prompt_pay']}"),
              Text("สร้างบัญชีเมื่อ: ${bank_account_user['created_at']}"),
              Text("อัพเดทล่าสุด: ${bank_account_user['created_at']}"),
            ],
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },),
    );
  }

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