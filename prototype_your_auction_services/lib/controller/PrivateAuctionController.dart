import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/share/ConfigAPI.dart';

class PrivateAuctionController {
  void fetchPrivateAuctionAdmin() async {
    try {
      String url = ConfigAPI().url;
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        print("Successfully. StatusCode = ${response.statusCode}");
      } else {
        throw Exception("Error StatusCode = ${response.statusCode}");
      }
    } on Exception catch (e) {
      throw Exception("Error = ${e}");
    }
  }
}
