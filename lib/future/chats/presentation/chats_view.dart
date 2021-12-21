import 'package:flutter/material.dart';
import 'widgets/chats_body.dart';


class ChatsView extends StatelessWidget {
  const ChatsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChatsBody(),
    );
  }
}
