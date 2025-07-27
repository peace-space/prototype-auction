import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/share/ShareUserData.dart';

class Chat extends StatefulWidget {

  State<Chat> createState() {
    return ChatState();
  }
}

class ChatState extends State<Chat> {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("data: {id_user} | ${ShareData.userData['id_users']}"),
      ),
    );
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
