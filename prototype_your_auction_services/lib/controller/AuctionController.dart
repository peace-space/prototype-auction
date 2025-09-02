import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/share/ConfigAPI.dart';

class AuctionController {
  void fetchAuctionListAdmin() async {
    String url = ConfigAPI().getAuctionListAdmin();
    Uri uri = Uri.parse(url);
    final response = await http.get(uri);
    // final resJson = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("Successfully");
    } else {
      throw Exception("Error: StatusCode = ${response.statusCode}");
    }
  }
}
