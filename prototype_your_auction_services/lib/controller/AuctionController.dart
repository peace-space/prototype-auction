import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/model/AuctionModel.dart';
import 'package:prototype_your_auction_services/share/ConfigAPI.dart';
import 'package:prototype_your_auction_services/share/config/ConfigDelayBroadcast.dart';

import '../model/ProductTypesModel.dart';

class AuctionController {
  void fetchAuctionListAdmin() async {

    await Future.delayed(Duration(seconds: ConfigDelayBroadcast.delay()));

    // ConfigDelayBroadcast.onDelay();

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


  Future<void> fetchAuctionSelectTypes({required var id_products, required String key_word}) async {
    try {
      if (id_products == null || id_products == '') {
        id_products = 0;
      }

      // id_products = 0;

      // print('${id_products}');

      await Future.delayed(Duration(seconds: ConfigDelayBroadcast.delay()));
      // await Future.delayed(Duration(seconds: 3));

      String url;

      if (key_word.isNotEmpty) {
        url = ConfigAPI().getAuctionSelectTypesGet(id_products: id_products, key_word: key_word);
        // print("${key_word}");
        // print("Keyword +++++++++++++++++++++++++++++++++++++++++++");
      } else {
        url = ConfigAPI().getAuctionSelectTypesGet(id_products: id_products, key_word: '');
      }

      // print("${url}");
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      final resJson = jsonDecode(response.body);
      // print("${response.statusCode}");
      if (response.statusCode == 200) {
        AuctionModel().setAuctionSelectTypesData(auction_select_types_data: resJson['data']);
        // print("object: ${resJson}");
      } else {
        Exception("ERROR StatusCode = ${response.statusCode}");
      }
    } on Exception catch (e) {
      Exception("ERROR = ${e}");
    }
  }

  Future<void> myAuctionSelectTypes({required var id_users, required var id_products, required String key_word}) async {
    try {
      if (id_products == null || id_products == '') {
        id_products = 0;
      }

      // id_products = 0;

      // print('${id_products}');

      await Future.delayed(Duration(seconds: ConfigDelayBroadcast.delay()));
      // await Future.delayed(Duration(seconds: 3));

      String url;

      if (key_word.isNotEmpty) {
        url = ConfigAPI().getMyAuctionsServerGet(id_users: id_users, id_products: id_products, key_word: key_word);
        // print("${key_word}");
        // print("Keyword +++++++++++++++++++++++++++++++++++++++++++");
      } else {
        url = ConfigAPI().getMyAuctionsServerGet(id_users: id_users, id_products: id_products, key_word: '');
      }

      print("${url}");
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      final resJson = jsonDecode(response.body);
      // print("${response.statusCode}");
      if (response.statusCode == 200) {
        AuctionModel().setAuctionSelectTypesData(auction_select_types_data: resJson['data']);
        // print("object: ${resJson}");
      } else {
        Exception("ERROR StatusCode = ${response.statusCode}");
      }
    } on Exception catch (e) {
      Exception("ERROR = ${e}");
    }
  }

}
