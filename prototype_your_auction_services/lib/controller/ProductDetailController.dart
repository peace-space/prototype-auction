import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/controller/AuctionController.dart';
import 'package:prototype_your_auction_services/share/ConfigAPI.dart';

import '../share/config/ConfigDelayBroadcast.dart';

class ProductDetailController {
  void fetchProductDetail({required var id_auctions}) async {

    await Future.delayed(Duration(seconds: ConfigDelayBroadcast.delay()));

    // ConfigDelayBroadcast.onDelay();

    String url = ConfigAPI().getProductDetailApiServerGet(
      id_auctions: id_auctions,
    );
    Uri uri = Uri.parse(url);
    final response = await http.get(uri);
    // Map resJson = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("Successfully");
      // return resJson;
    } else {
      // return {"":""};
      throw Exception("Error Status Code = ${response.statusCode}");
    }
  }

  void onDeleteProductAdmin({required var id_products}) async {
    String url = ConfigAPI().getAdminProductDelete(id_products: id_products);
    Uri uri = Uri.parse(url);
    final response = await http.delete(uri);
    final resJson = jsonDecode(response.body);
    // print("object");
    if (response.statusCode == 200) {
      AuctionController().fetchAuctionListAdmin();
      print("Successfully.");
    } else {
      throw Exception("Error StatusCode = ${response.statusCode}");
    }
  }
}
