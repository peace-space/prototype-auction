import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/model/AuctionModel.dart';
import 'package:prototype_your_auction_services/share/ConfigAPI.dart';

import '../model/ProductTypesModel.dart';

class AuctionController {
  void fetchAuctionListAdmin() async {

    await Future.delayed(Duration(seconds: 3));

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


  void fetchAuctionSelectTypes({required var id_products}) async {
    try {
      String url = ConfigAPI().getAuctionSelectTypesGet(id_products: id_products);
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      final resJson = jsonDecode(response.body);

      if (response.statusCode == 200) {
        AuctionModel().setAuctionSelectTypesData(auction_select_types_data: resJson['data']);
      } else {
        Exception("ERROR StatusCode = ${response.statusCode}");
      }
    } on Exception catch (e) {
      Exception("ERROR = ${e}");
    }
  }

  String selectProductType(String product_type) {
    List check_index_product_types = ProductTypesModel().getProductTypes();

    for (int index = 0; index <= check_index_product_types.length - 1; index++) {
      if (product_type == check_index_product_types[index]['product_type_text']) {
        return "${index + 1}";
      }
    }
    return "1";
  }
}
