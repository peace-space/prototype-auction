import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/screen/AppBar.dart';
import 'package:prototype_your_auction_services/share_data/ShareUserData.dart';

class HistoryAuctions extends StatefulWidget {
  State<HistoryAuctions> createState() {
    return HistoryAuctionsState();
  }
}

class HistoryAuctionsState extends State<HistoryAuctions> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ประวัติการประมูล")),
      body: display(),
      drawer: createDrawer(context),
    );
  }

  Widget display() {
    return StreamBuilder(
      stream: fetchHistoryAuctions(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error.'),
          );
        }

        if (snapshot.connectionState == ConnectionState.active) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasData) {
          return Padding(
            padding: EdgeInsets.all(8),
            child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) =>
                  Card(
                      child: Text(snapshot.data['name_product'])
                  ),
            ),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );

      },
    );
  }


  Stream<dynamic> fetchHistoryAuctions() async* {
    print('Start.');
    String url = 'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/history-product/${ShareData
        .userData['id_users']}';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // print(data['data']);
      yield data['data'];
      // setState(() {});
    }
    print("End.");
  }
}
