import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/share/ShareUserData.dart';
import 'package:prototype_your_auction_services/share/createDrawerShareWidget.dart';

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
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                if (snapshot.hasError) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.connectionState == ConnectionState.active) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasData) {
                Map<String, dynamic> data = snapshot.data![index];
                return Card(
                  child: ListTile(
                    leading: Image.network(
                      'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/public' +
                          '${data['image_path_1']}',
                      cacheHeight: 1000,
                      cacheWidth: 900,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data['name_product'].toString()),
                        // Text('${paymentStatus(data['payment_status']).toString()}'),
                        Text('${data['payment_status'].toString()}'),
                      ],
                    ),
                    trailing: Text("ประมูลสำเร็จ"),
                  ),
                );
                }

                return Center(child: CircularProgressIndicator());
              }
          ),
    );
  }

  Stream<dynamic> fetchResultReportAuction() async* {
    String url = 'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/result-report-auction/${ShareData
        .userData['id_users']}';
    final uri = Uri.parse(url);
    final responce = await http.get(uri);
    if (responce.statusCode == 200) {
      final body = jsonDecode(responce.body);
      print(body['data'].toString());
      // ShareProductData.productData = body['data'];
      // print(ShareProductData.productData);
      yield body['data'];
      // setState(() {});
    }
  }

  String paymentStatus(bool payment_status) {
    if (payment_status == 1) {
      return "ชำระเงินแล้ว";
    } else {
      return "ยังไม่ชำระเงิน";
    }
  }
}
