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

  // String selectProductType(String product_type) {
  //   List check_index_product_types = ProductTypesModel().getProductTypes();
  //   print("${check_index_product_types}");
  //   for (int index = 0; index <= check_index_product_types.length - 1; index++) {
  //     if (product_type == check_index_product_types[index]['product_type_text']) {
  //       return "${index + 1}";
  //     }
  //   }
  //   return "0";
  // }

  dynamic selectProductType(dynamic product_type) {
    dynamic check_index_product_types = ProductTypesModel().getProductTypes();
    print("${product_type}");
    // List check_index_product_types = product_type;
    if (check_index_product_types != null) {
      for (int index = 0; index <=
          check_index_product_types.length - 1; index++) {
        if (product_type ==
            check_index_product_types[index]['product_type_text']) {
          return "${index + 1}";
        }
      }
    }
    return 0;
  }
}