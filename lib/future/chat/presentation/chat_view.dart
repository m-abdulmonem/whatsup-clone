import 'package:flutter/material.dart';
import 'widgets/chat_body.dart';

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChatBody(),
    );
  }
}

