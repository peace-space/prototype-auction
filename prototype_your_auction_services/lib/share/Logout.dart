import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:prototype_your_auction_services/share/ApiPathLocal.dart';
import 'package:prototype_your_auction_services/share/ApiPathServer.dart';

class Logout {
  final String logout_api_local_get = ApiPathLocal().getLogoutApiLocalGet();
  final String logout_api_server_get = ApiPathServer().getLogoutServer();

  // final BuildContext context;
  //
  // Logout({required this.context});

  void onLogout() async {
    try {
      print("\n\n\n\n\n Start onLogout");
      final uri = Uri.parse(logout_api_local_get);

      FlutterSecureStorage storage = FlutterSecureStorage();

      String? user_token = await storage.read(key: 'user_token');
      String? user_token_type = await storage.read(key: 'user_token_type');
      final response = await get(
        uri,
        headers: {
          "Authorisation": user_token_type.toString() + user_token.toString(),
        },
      );

      if (response.statusCode == 200) {
        await storage.deleteAll();
        // Navigator.pushReplacement(this.context, MaterialPageRoute(builder: (context) => AuctionHome(),));
      } else {
        // showDialog(context: context, builder: (context) => AlertDialog(
        //   title: Text("แจ้งเตือน"),
        //   content: Text("เกิดข้อผิดพลาดในการออกจากระบบ"),
        //   actions: [
        //     TextButton(onPressed: () => {
        //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AuctionHome(),))
        //     }, child: Text("ตกลง"))
        //   ],
        // ),);
      }
    } on Exception catch (e) {}

    print("End onLogout\n\n\n\n\n");
  }
}
