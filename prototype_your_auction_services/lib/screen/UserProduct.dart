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
      stream: fetchUserProduct(),
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> data = snapshot.data[index];
            return Card(child: Text(data['name_product'].toString()));
          },
        );
      },
    );
  }

  Stream<dynamic> fetchUserProduct() async* {
    print("Start");
    // print(ShareData.userData['id_users']);
    String url =
        'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/user-product/${ShareData.userData['id_users']}';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    Map<String, dynamic> resData = jsonDecode(response.body);

    List<dynamic> data = resData['data'];

    print(data.toString());

    yield data;
    print("End.");
  }
}
