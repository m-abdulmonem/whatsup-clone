import '../manger/chats_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'chat_item.dart';

class ChatsBody extends GetWidget<ChatsController> {
  const ChatsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
        itemCount: controller.chats.length,
        itemBuilder: (_, index) => ChatItem(
            name: controller.chats[index].name,
            message: controller.chats[index].message,
            time: controller.chats[index].time,
            picture: controller.chats[index].picture));
  }
}
