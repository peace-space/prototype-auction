import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/model/ProductTypesModel.dart';
import 'package:prototype_your_auction_services/share/ConfigAPI.dart';

class ProductTypesController {
  // void onAddProductType() async {
  //   // String url = ConfigAPI().getAdd;
  //
  // }

  Future<dynamic> fetchProductTypes() async {
    try {
      String url = ConfigAPI().getProductTypesGet();
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      final resJson = jsonDecode(response.body);

      // Future.delayed(Duration(seconds: 3));

      if (response.statusCode == 200) {
        ProductTypesModel().setProductTypes(product_types: resJson['data']);
        // print("++++++++++++++++++++++++++++++++++++++++++ ${resJson['data']}");
        return resJson['data'];
      } else {
        ProductTypesModel().setProductTypes(product_types: null);
        return null;
        print("------------------------------------------");
        Exception("Error StatusCode = ${response.statusCode}");
      }
    } on Exception catch (e) {
      Exception("Error = ${e}");
    }
  }
}