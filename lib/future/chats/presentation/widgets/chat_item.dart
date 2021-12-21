import 'package:flutter/material.dart';
import 'package:whats_app_clone/core/lib/custom_widgets.dart';

class ChatItem extends StatefulWidget {
  final String name, message, time, picture;
  const ChatItem(
      {Key? key,
      required this.name,
      required this.message,
      required this.time,
      required this.picture})
      : super(key: key);

  @override
  _ChatItemState createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        title: CustomText(widget.name),
        subtitle: CustomText(widget.message),
        isThreeLine: true,
        leading: CircleAvatar(
          radius: 50,
          foregroundImage: NetworkImage(widget.picture),
        ),
        trailing: CustomText(widget.time),
      ),
    );
  }
}
