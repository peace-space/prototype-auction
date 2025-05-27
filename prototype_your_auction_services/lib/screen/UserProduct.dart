// import 'dart:nativewrappers/_internal/vm/lib/convert_patch.dart';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/share_data/ShareUserData.dart';

class UserProduct extends StatefulWidget {
  State<UserProduct> createState() {
    return UserProductState();
  }
}

class UserProductState extends State<UserProduct> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("รายการสินค้า")),
      body: displayUserProduct(),
    );
  }

  Widget displayUserProduct() {
    return StreamBuilder(
      stream: null,
      builder: (context, snapshot) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [DataColumn(label: Center(child: Text("ลำดับ")))],
              rows: [
                DataRow(cells: [DataCell(Text("test"))]),
              ],
            ),
          ),
        );
      },
    );
  }

  Stream<dynamic> fetchUserProduct() async* {
    String url =
        'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/user-product/${ShareData.userData['id_user']}';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    Map<String, dynamic> resData = jsonDecode(response.body);

    print(resData);

    yield resData;
  }
}
