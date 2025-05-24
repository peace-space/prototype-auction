import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/share_data/ShareProductData.dart';

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

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

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
                            "ชื่อ",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                    ),
                    DataColumn(
                      label: Text(
                        "เสนอราคาเมื่อ",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "เสนอราคาเมื่อ",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                  rows: List.generate(snapshot.data.length, (index) {
                    Map<String, dynamic> data = snapshot.data[index];
                    String user_name = data['id_users'].toString();
                    String bidding_date_time = data['id_auctions'].toString();
                    return DataRow(
                      cells: [
                        DataCell(Center(child: Text(user_name))),
                        DataCell(Center(child: Text(user_name))),
                        DataCell(Center(child: Text(bidding_date_time))),
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
    String url =
        'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/bids/${ShareProductData
        .productData['id_auctions']}';
    final uri = Uri.parse(url);
    final responce = await http.get(uri);
    final data = jsonDecode(responce.body);
    print(data);
    yield data.toList();
    // setState(() {});
    print("End.");
  }

  List<DataColumn> test() {
    return [DataColumn(label: Text("data"))];
  }
}
