import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/share/ShareUserData.dart';

class Chat extends StatefulWidget {
  final int id_user;

  Chat(this.id_user);

  State<Chat> createState() {
    return ChatState(id_user);
  }
}

class ChatState extends State<Chat> {
  final int id_user;
  ChatState(this.id_user);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("data: ${id_user} | ${ShareData.userData['id_users']}"),
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
