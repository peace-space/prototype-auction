import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/share/ShareChatData.dart';
import 'package:prototype_your_auction_services/share/ShareUserData.dart';

class ChatTest extends StatefulWidget {

  State<ChatTest> createState() {
    return ChatTestState();
  }
}

class ChatTestState extends State<ChatTest> {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("data: ${ShareData.userData['id_users']} | ${ShareChatData
            .chatData['id_users_chat_2']}"),
      ),
        body: Text('A'));
  }
  Widget streamMessageList() {
    // var alignment = ()
    return StreamBuilder(
      stream: streamMessageData(),
      builder: (context, snapshot) => ListView(),
    );
  }

  Stream<List<dynamic>> streamMessageData() async* {
    List<dynamic> data = [];
    yield data;
  }
}
