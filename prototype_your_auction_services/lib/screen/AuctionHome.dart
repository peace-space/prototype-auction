import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/screen/AppBar.dart';
import 'package:prototype_your_auction_services/screen/DetailAuction.dart';
import 'package:prototype_your_auction_services/share_data/ShareProductData.dart';
import 'package:prototype_your_auction_services/share_data/ShareUserData.dart';

class AuctionHome extends StatefulWidget {
  State<AuctionHome> createState() {
    return AuctionHomeState();
  }
}

class AuctionHomeState extends State<AuctionHome> {
  String messageButton = "รายการ";
  bool _changeDisplay = false;
  String loginStatus = "";
  Map<String, dynamic> images_data = {};

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      loginStatus = logedIn();
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home: ${loginStatus}"),
      ),
      body: Column(
        children: [
          Container(
            //color: Colors.lightBlueAccent,
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
            alignment: Alignment.topRight,
            height: 23,
            child: changeDisplayButton(context),
          ),
          SizedBox(width: 10,),
          Expanded(
              child: displayer(context)
          )
        ],
      ),
      drawer: createDrawer(context),
    );
  }

  String logedIn() {
    if (ShareData.logedIn) {
      return "เข้าสู่ระบบแล้ว";
    } else {
      return "ยังไม่เข้าสู่ระบบ";
    }
  }

  // Widget auctionGrid(BuildContext ctx) {
  //   double left = 8.0;
  //   double top = 0.0;
  //   double right = 8.0;
  //   double bottom = 8.0;
  //
  //   return StreamBuilder(
  //       stream: fetchAuctionData(),
  //       builder: (context, snapshot) {
  //         if (snapshot.hasError) {
  //           return const Center(
  //             child: Text("Error."),
  //           );
  //         }
  //
  //         if (snapshot.connectionState == ConnectionState.active) {
  //           return const Center(
  //               child: CircularProgressIndicator()
  //           );
  //         }
  //
  //         if (snapshot.hasData) {
  //           return GridView.builder(
  //             padding: EdgeInsets.fromLTRB(left, top, right, bottom),
  //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //               crossAxisCount: 2, //จำนวนคอลลัมน์
  //               crossAxisSpacing: 10, //ระยะห่างระหว่างคอลลัมน์
  //               mainAxisSpacing: 10, //ระยะห่างระหว่างแถว
  //               //mainAxisExtent: 300, //ขนาดของรูปภาพ
  //               childAspectRatio: 0.52, //อัตตราส่วนของช่อง (กว้าง / สูง)
  //             ),
  //             itemCount: snapshot.data?.length,
  //             itemBuilder: (context, index) {
  //               Map<String, dynamic> data = snapshot.data?[index];
  //               return InkWell(
  //                 onTap: () => goToDetailAuction(ctx, snapshot.data?[index]),
  //                 child: Card(
  //                     shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(15)
  //                     ),
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.stretch,
  //                       children: [
  //                         Expanded(
  //                           child: ClipRRect(
  //                               borderRadius: BorderRadius.vertical(
  //                                   top: Radius.circular(15)),
  //                               child: Image.network(
  //                                 'https://picsum.photos/200/300?random=${index}',
  //                                 fit: BoxFit.cover,)
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: EdgeInsets.all(8.0),
  //                           child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               // Text(data['name_product']),
  //                               SizedBox(height: 5,),
  //                               Text("ราคาสูงสุด ฿${data['start_price']
  //                                   .toString()}"),
  //                               SizedBox(height: 5,),
  //                               Text("เวลา: ",
  //                                 style: TextStyle(
  //                                     color: Colors.red,
  //                                     fontSize: 18
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         )
  //                       ],
  //                     )
  //                 ),
  //               );
  //             },
  //           );
  //         }
  //
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //   );
  // }
  Widget auctionGrid(BuildContext ctx) {
    double left = 8.0;
    double top = 0.0;
    double right = 8.0;
    double bottom = 8.0;

    return StreamBuilder(
        stream: fetchAuctionData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error."),
            );
          }

          if (snapshot.connectionState == ConnectionState.active) {
            return const Center(
                child: CircularProgressIndicator()
            );
          }

          if (snapshot.hasData) {
            return GridView.builder(
              padding: EdgeInsets.fromLTRB(left, top, right, bottom),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //จำนวนคอลลัมน์
                crossAxisSpacing: 10, //ระยะห่างระหว่างคอลลัมน์
                mainAxisSpacing: 10, //ระยะห่างระหว่างแถว
                //mainAxisExtent: 300, //ขนาดของรูปภาพ
                childAspectRatio: 0.52, //อัตตราส่วนของช่อง (กว้าง / สูง)
              ),
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> data = snapshot.data?[index];
                // fetchImage(data['id_auctions']);
                return InkWell(
                  onTap: () => goToDetailAuction(ctx, snapshot.data?[index]),
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(15)),
                                child: Image.network(
                                  'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/public/}',
                                  fit: BoxFit.cover,)
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text(data['name_product']),
                                SizedBox(height: 5,),
                                Text("ราคาสูงสุด ฿${data['start_price']
                                    .toString()}"),
                                SizedBox(height: 5,),
                                Text("เวลา: ",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 18
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        }
    );
  }

  Widget auctionList(BuildContext ctx) {
    return StreamBuilder(
        stream: fetchAuctionData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error."),
            );
          }

          if (snapshot.connectionState == ConnectionState.active) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                padding: EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  Map<String, dynamic> data = snapshot.data?[index];
                  // print(data['id_auctions'].toString());
                  // print(images_data.toString());
                  // fetchImage(data['id_auctions']);
                  double left = 0.0;
                  double top = 0.0;
                  double right = 8.0;
                  double bottom = 8.0;
                  return Padding(
                    padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                    child: ListTile(
                      onTap: () => goToDetailAuction(ctx, data),
                      leading: ClipRRect(
                          borderRadius: BorderRadius.vertical(),
                          child: Image.network(
                            'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/public/storage/'
                                +
                                'images/product-images${images_data['image_path']}',
                            cacheHeight: 600,
                            cacheWidth: 500,
                          )
                      ),
                      title: Text(data['name_product']),
                      subtitle: Text(
                          "ราคาสูงสุด ฿${data['start_price'].toString()}"),
                      trailing: Text("เวลา",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 18
                        ),),
                    ),
                  );
                }
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        }
    );
  }

  // Widget auctionList(BuildContext ctx) {
  //   return StreamBuilder(
  //       stream: fetchAuctionData(),
  //       builder: (context, snapshot) {
  //         if (snapshot.hasError) {
  //           return const Center(
  //             child: Text("Error."),
  //           );
  //         }
  //
  //         if (snapshot.connectionState == ConnectionState.active) {
  //           return Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         }
  //
  //         if (snapshot.hasData) {
  //           return ListView.builder(
  //               itemCount: snapshot.data?.length,
  //               padding: EdgeInsets.all(8),
  //               itemBuilder: (context, index) {
  //                 Map<String, dynamic> data = snapshot.data?[index];
  //                 print(data['id_auctions'].toString());
  //
  //                 double left = 0.0;
  //                 double top = 0.0;
  //                 double right = 8.0;
  //                 double bottom = 8.0;
  //                 return Padding(
  //                   padding: EdgeInsets.fromLTRB(left, top, right, bottom),
  //                   child: ListTile(
  //                     onTap: () => goToDetailAuction(ctx, data),
  //                     leading: ClipRRect(
  //                         borderRadius: BorderRadius.vertical(),
  //                         child: Image.network(
  //                           'https://picsum.photos/500/500?random=${index}',
  //                           cacheHeight: 600,
  //                           cacheWidth: 500,
  //                         )
  //                     ),
  //                     title: Text(data['name_product']),
  //                     subtitle: Text(
  //                         "ราคาสูงสุด ฿${data['start_price'].toString()}"),
  //                     trailing: Text("เวลา",
  //                       style: TextStyle(
  //                           color: Colors.red,
  //                           fontSize: 18
  //                       ),),
  //                   ),
  //                 );
  //               }
  //           );
  //         }
  //
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //   );
  // }

  Stream<List<dynamic>> fetchAuctionData() async* {
    await Future.delayed(Duration(seconds: 1));
    print("Start");
    String url = 'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/auction';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final resData = jsonDecode(response.body);
    List<dynamic> auctions_data = resData['data']['auctions_data'];
    List<dynamic> images_data = resData['data']['images'];
    yield auctions_data;
    setState(() {
      images_data = images_data;
    });
    print("End");
  }

  Stream<Map<dynamic, String>> fetchImage(dynamic id_auctions) async* {
    print("Start.Image");
    String url = 'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/image/${id_auctions}';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final resData = jsonDecode(response.body);
    await Future.delayed(Duration(seconds: 500));
    Map<String, dynamic> data = resData['data'];
    print(data.runtimeType);
    // yield data;
    print(data.toString());
    setState(() {
      images_data = data;
    });
    print("End.Image");
  }

  Widget displayer(BuildContext ctx) {
    if (_changeDisplay) {
      return auctionList(ctx);
    } else {
      return auctionGrid(ctx);
    }
  }

  void changeDisplayStatus(BuildContext ctx) {
    if (_changeDisplay) {
      setState(() {
        messageButton = "รายการ";
        _changeDisplay = false;
      });
    } else {
      setState(() {
        messageButton = "รูปภาพ";
        _changeDisplay = true;
      });
    }
  }

  Widget changeDisplayButton(BuildContext ctx) {
    return ElevatedButton(
        onPressed: () => changeDisplayStatus(ctx),
        child: Text(messageButton)
    );
  }

  void goToDetailAuction(BuildContext ctx, Map<String, dynamic> data) {
    ShareProductData.productData = data;
    final route = MaterialPageRoute(
      builder: (ctx) => DetailAuction(),
    );

    Navigator.push(ctx, route);
  }
}