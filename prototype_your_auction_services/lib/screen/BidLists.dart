import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/share/ShareProductData.dart';

class BidLists extends StatefulWidget {
  State<BidLists> createState() {
    return BidListsState();
  }
}

class BidListsState extends State<BidLists> {
  final List<Map<String, dynamic>> _test = List.generate(
    10,
        (index) =>
    {
      'id': index,
      'title': "item $index",
      'price': Random().nextInt(1000),
    },
  );

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BidList")),
      body: displayBidList(),
    );
  }

  Widget displayBidList() {
    return StreamBuilder(
      stream: fetchUserBidList(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error."));
        }

        if (snapshot.data == '') {
          print("SSSSS: " + snapshot.hasData.toString());
          return Center(
              child: Text("ไม่มีข้อมูล")
          );
        }

        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   print("SSSSS: " + snapshot.hasData.toString());
        //   print("SSSSS: " + snapshot.data.toString());
        //   return Center(child: CircularProgressIndicator());
        // }

        if (snapshot.hasData) {
          // Map<String, dynamic> data = snapshot.data[index];
          return Container(
            margin: EdgeInsets.all(8),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  // horizontalMargin: double.maxFinite,
                  // dataRowMaxHeight: double.infinity,
                  dataTextStyle: TextStyle(),
                  border: TableBorder.all(),
                  columns: [
                    DataColumn(
                        label: Center(
                          child: Text(
                            "ลำดับ",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                    ),
                    DataColumn(
                        label: Center(
                          child: Text(
                            "ชื่อ",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                    ),
                    DataColumn(
                      // columnWidth: FlexColumnWidth(),
                        label: Center(
                          child: Text(
                            "ราคา",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                    ),
                    DataColumn(
                      label: Text(
                        "เวลา",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                  rows: List.generate(snapshot.data.length, (index) {
                    Map<String, dynamic> data = snapshot.data[index];
                    String user_name = data['name'].toString();
                    String price = data['bid_price'].toString();
                    String bidding_date_time = data['created_at'].toString();
                    return DataRow(
                      cells: [
                        DataCell(Center(child: Text('${index + 1}'))),
                        DataCell(Center(child: Text(user_name))),
                        DataCell(Center(child: Text(price))),
                        DataCell(Center(child: Text(bidding_date_time))),
                      ],
                    );
                  }),
                ),
              ),
            ),
          );
        }


        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Stream<dynamic> fetchUserBidList() async* {
    print("Start.");
    await Future.delayed(Duration(seconds: 1));
    String url =
        'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/bids/${ShareProductData
        .productData['id_auctions']}';
    final uri = Uri.parse(url);
    final responce = await http.get(uri);
    final data = jsonDecode(responce.body);
    // print("tset" + data['data'].toString());

    if (data['data'] != '') {
      yield data['data'].toList();
    } else {
      yield null;
    }
    setState(() {});
    print("End.");
  }

  List<DataColumn> test() {
    return [DataColumn(label: Text("data"))];
  }
}
