import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/model/AuctionTypesModel.dart';
import 'package:prototype_your_auction_services/model/ProductTypesModel.dart';
import 'package:prototype_your_auction_services/share/ConfigAPI.dart';

class AuctionTypesController {
  // void onAddProductType() async {
  //   // String url = ConfigAPI().getAdd;
  //
  // }

  Future<void> fetchAuctionTypes() async {
    try {
      String url = ConfigAPI().getAuctionTypesGet();
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      final resJson = jsonDecode(response.body);

      // print("..............................");
      if (response.statusCode == 200) {
        // print("..............................${resJson['data']}");
        AuctionTypesModel().setAuctionTypes(auction_types: resJson['data']);
      } else {
        Exception("Error StatusCode = ${response.statusCode}");
      }
    } on Exception catch (e) {
      Exception("Error = ${e}");
    }
  }
}