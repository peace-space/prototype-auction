import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/share/ConfigAPI.dart';
import 'package:prototype_your_auction_services/share/config/ConfigDelayBroadcast.dart';

class PrivateAuctionController {
  void fetchPrivateAuctionAdmin() async {
    try {
      await Future.delayed(Duration(seconds: ConfigDelayBroadcast.delay()));

      // ConfigDelayBroadcast.onDelay();

      String url = ConfigAPI().getPrivateAuctionAdmin();
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        // print("Successfully. StatusCode = ${response.statusCode}");
      } else {
        throw Exception("Error StatusCode = ${response.statusCode}");
      }
    } on Exception catch (e) {
      throw Exception("Error = ${e}");
    }
  }
}
