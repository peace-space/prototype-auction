import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/screen/AppBar.dart';

class ReportAuction extends StatefulWidget {
  State<ReportAuction> createState() {
    return ReportAuctionState();
  }
}

class ReportAuctionState extends State<ReportAuction> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('รายงานการประมูล')),
      body: display(),
      drawer: createDrawer(context),
    );
  }

  Widget display() {
    return StreamBuilder(
      stream: fetchResultReportAuction(),
      builder:
          (context, snapshot) => ListView.builder(
            padding: EdgeInsets.all(8),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> data = snapshot.data![index];
                return Card(
                    child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data['id_users'].toString())
                          ],
                        )
                    )
                );
              }
          ),
    );
  }

  Stream<dynamic> fetchResultReportAuction() async* {
    String url = 'http://192.168.1.248/001.Work/003.Project-2567/Prototype-Your-Auction-Services/api-prototype-your-auction-service/public/api/v1/result-report-auction';
    final uri = Uri.parse(url);
    final responce = await http.get(uri);

    if (responce.statusCode == 200) {
      final body = jsonDecode(responce.body);
      print(body['data'].toString());
      yield body['data'];

      // setState(() {});
    }
  }
}
