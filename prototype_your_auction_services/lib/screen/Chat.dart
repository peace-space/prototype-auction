import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/share/ConfigAPI.dart';
import 'package:prototype_your_auction_services/share/ShareChatData.dart';
import 'package:prototype_your_auction_services/share/ShareProductData.dart';
import 'package:prototype_your_auction_services/share/ShareUserData.dart';

class Chat extends StatefulWidget {

  State<Chat> createState() {
    return ChatState();
  }
}

class ChatState extends State<Chat> {
  var _messageController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("data: ${ShareData.userData['id_users']} | ${ShareChatData
            .chatData['id_users_chat_2']}"),
      ),
      body: streamMessageList(),
      // body: StreamBuilder(
      //     stream: streamMessageData(),
      //     builder: (context, asyncSnapshot) {
      //       return Stack(
      //         children: [
      //           ListView.builder(
      //               itemCount: asyncSnapshot.data!.length,
      //               itemBuilder: (context, index)  {
      //                 Map<String, dynamic> data = asyncSnapshot.data![index];
      //                 return Container(
      //                   padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
      //                   child: Align(
      //                     // alignment: (data!['id_users_sender'] != ShareData.userData['id_users'])? Alignment.topLeft: Alignment.topLeft,
      //                     alignment: (data!['id_users_sender'] != ShareData.userData['id_users'])? Alignment.topLeft: Alignment.topRight,
      //                     child: Container(
      //                       child: Text("${data['id_users_sender']}"),
      //                     ),
      //                   ),
      //                 );}
      //           )
      //         ],
      //       );
      //     }
      // )
    );
  }
  Widget streamMessageList() {
    // var alignment = ()
    double left = 0.0;
    double top = 0.0;
    double right = 0.0;
    double bottom = 100.0;
    return StreamBuilder(
        stream: streamMessageData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("เกิดข้อผิดพลาด"),
            );
          }
          if (snapshot.connectionState == ConnectionState.active) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return SafeArea(
                bottom: true,
                // minimum: EdgeInsets.fromLTRB(left, top, right, bottom),
                child: Stack(
                  children: [
                    ListView.builder(
                        padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> data = snapshot.data![index];
                          return Container(
                            padding: EdgeInsets.only(
                                left: 16, right: 16, top: 10, bottom: 10),
                            child: Align(
                              // alignment: (data!['id_users_sender'] != ShareData.userData['id_users'])? Alignment.topLeft: Alignment.topLeft,
                              alignment: (data!['id_users_sender'] != ShareData
                                  .userData['id_users'])
                                  ? Alignment.topLeft
                                  : Alignment.topRight,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: (data!['id_users_sender'] !=
                                      ShareData.userData['id_users'] ? Colors
                                      .grey.shade200 : Colors.blue[200]),
                                ),
                                child: Text("${data['message']}"),
                              ),
                            ),
                          );
                        }
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                        height: 60,
                        width: double.infinity,
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Icon(
                                  Icons.add, color: Colors.white, size: 20,),
                              ),
                            ),
                            SizedBox(width: 15,),
                            Expanded(
                              child: TextField(
                                controller: _messageController,
                                decoration: InputDecoration(
                                    hintText: "ข้อความ",
                                    hintStyle: TextStyle(color: Colors.black54),
                                    border: InputBorder.none
                                ),
                              ),
                            ),
                            SizedBox(width: 15,),
                            FloatingActionButton(
                              onPressed: () {
                                sendMessage();
                              },
                              child: Icon(Icons.send, color: Colors.white,
                                size: 18,),
                              backgroundColor: Colors.blue,
                              elevation: 0,
                            ),
                          ],

                        ),
                      ),
                    ),
                  ],
                )
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }
    );
  }

  // Widget chatStyle(var data) {
  //   if (data != null) {
  //     if (data['id_users_chat_1'] == ShareData.userData['id_users']) {
  //       return Text("data");
  //     }
  //     if (data['id_users_chat_2'] == data) {
  //       return Text("data");
  //     }
  //   }
  //
  //   return Text("data");
  // }

  Stream<List<dynamic>> streamMessageData() async* {
    String api = ConfigAPI().getChatServerGet(
        id_chat_rooms: ShareChatData.chatData['id_chat_rooms']);
    Uri uri = Uri.parse(api);
    final response = await http.get(uri);
    final data = jsonDecode(response.body);
    yield data['data'];
    setState(() {});
  }

  void sendMessage() async {
    Map<String, dynamic> data = {
      'id_chat_rooms': ShareChatData.chatData['id_chat_rooms'],
      'id_users_sender': ShareData.userData['id_users'],
      'id_products' : ShareProductData.productData['id_products'],
      'message': _messageController.text
    };
    String api = ConfigAPI().getSendMessageServerPost();
    Uri uri = Uri.parse(api);
    final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data)
    );

    if (response.statusCode == 200) {
      print('Successfully.');
    } else {
      print('ERROR: ${response.statusCode.toString()}');
    }

    _messageController.text = '';
  }
}
