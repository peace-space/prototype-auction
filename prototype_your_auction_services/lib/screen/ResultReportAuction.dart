import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/screen/ConfirmPayment.dart';
import 'package:prototype_your_auction_services/share/ConfigAPI.dart';
import 'package:prototype_your_auction_services/share/ShareProductData.dart';
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
                  return Center(child: Text("เกิดข้อผิดพลาด"));
                }

                if (snapshot.connectionState == ConnectionState.active) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData) {
                  return Center(
                    child: Text("ไม่มีข้อมูล", style: TextStyle(
                      fontSize: 16
                    ),),
                  );
                }

                if (snapshot.hasData) {
                  Map<String, dynamic> data = snapshot.data![index];
                  return Card(
                    child: ListTile(
                      onTap: () => goToConfirmPayment(data),
                      leading: Image.network(
                        '${ConfigAPI().getImageAuctionApiServerGet(
                            image_auction_path: data['image_path_1'])}',
                        // cacheHeight: 1200,
                        // cacheWidth: 9200,
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("คุณเป็นผู้ประมูลสำเร็จ", style: TextStyle(
                              color: Colors.green
                          ),),
                          Text(
                            'No. Bill-${data['id_bill_auctions'].toString()}',
                            style: TextStyle(
                                fontSize: 13
                            ),),
                          Text('ชื่อ: ${data['name_product'].toString()}'),
                          Text('สถานะ: ${paymentStatus(
                              data['id_payment_status_types'])
                              .toString()}'),
                          Text("จำนวนเงิน: ${data['debts'].toString()} บาท",
                            style: TextStyle(
                              fontSize: 16,
                            ),)
                          // Text('${data['payment_status'].toString()}'),
                        ],
                      ),
                      // trailing: Column(
                      //   children: [
                      //     // Text("คุณเป็นผู้ประมูลสำเร็จ", style: TextStyle(
                      //     //     color: Colors.green
                      //     // ),),
                      //     // Text("จำนวนเงิน ${data['debts'].toString()} บาท",
                      //     //   style: TextStyle(
                      //     //     fontSize: 16,
                      //     //   ),)
                      //   ],
                      // ),
                    ),
                  );
                }

                return Center(child: CircularProgressIndicator());
              }
          ),
    );
  }

  Stream<dynamic> fetchResultReportAuction() async* {
    // String url = 'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/result-report-auction/${ShareData
    //     .userData['id_users']}';
    String url = ConfigAPI().getResultReportAuction(id_users: ShareData
        .userData['id_users']);
    final uri = Uri.parse(url);
    final responce = await http.get(uri);
    if (responce.statusCode == 200) {
      final body = jsonDecode(responce.body);
      // print(body['data'].toString());
      // ShareProductData.productData = body['data'];
      // print(ShareProductData.productData);
      yield body['data'];
      // setState(() {});
    }
  }

  String paymentStatus(int payment_status_types) {
    if (payment_status_types == 2) {
      return "กำลังตรวจสอบ";
    } else if (payment_status_types == 3) {
      return "ชำระเงินแล้ว";
    }
    return "รอการชำระเงิน";
  }

  void goToConfirmPayment(Map<String, dynamic> data) {
    ShareProductData.productData = data;
    print(data.toString());
    Navigator.push(context,
        MaterialPageRoute(
          builder: (context) => ConfirmPayment(),
        ));
  }


}
