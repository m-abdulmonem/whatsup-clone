import 'package:get/get.dart';
import 'package:whats_app_clone/future/chats/domain/models/chat_model.dart';

class ChatsController extends GetxController{

  String get picture => 'https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';

  List<ChatModel> get chats => [
    ChatModel(name: 'ali', message: 'hi our bros', picture: picture, time: '5:31pm'),
    ChatModel(name: 'mohamed', message: 'hi our bros', picture: picture, time: '5:31pm'),
    ChatModel(name: 'ibram', message: 'hi our bros', picture: picture, time: '5:31pm'),
    ChatModel(name: 'hessan', message: 'hi our bros', picture: picture, time: '5:31pm'),
    ChatModel(name: 'abdo', message: 'hi our bros', picture: picture, time: '5:31pm'),
    ChatModel(name: 'hassn', message: 'hi our bros', picture: picture, time: '5:31pm'),
    ChatModel(name: 'mostafa', message: 'hi our bros', picture: picture, time: '5:31pm'),
    ChatModel(name: 'youssf', message: 'hi our bros', picture: picture, time: '5:31pm'),
    ChatModel(name: 'amr', message: 'hi our bros', picture: picture, time: '5:31pm'),
  ];

}