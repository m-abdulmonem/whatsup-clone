import 'package:get/get.dart';
import 'package:whats_app_clone/future/chats/presentation/manger/chats_controller.dart';
import 'package:whats_app_clone/future/main/presentation/manager/main_controller.dart';
import 'package:whats_app_clone/future/splash/presentation/manger/splash_controller.dart';

class Binding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
    Get.put(MainController(),permanent: true);
    Get.put(ChatsController());

  }

}