import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whats_app_clone/core/lib/custom_widgets.dart';
import 'package:whats_app_clone/future/camera/presentation/camera_view.dart';
import 'package:whats_app_clone/future/chats/presentation/chats_view.dart';
import 'manager/main_controller.dart';

class MainView extends GetWidget<MainController> {
  MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        initialIndex: 1,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: colorSecondary,
            title: CustomText(
              "WhatsApp",
              color: Colors.white,
            ),
            actions: [
              IconButton(
                  onPressed: controller.onSearchClicked,
                  icon: Icon(Icons.search)),
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert),
                onSelected: controller.menuItemSelected,
                itemBuilder: (_) => controller.popupMenus(),
              )
            ],
            bottom: TabBar(
              indicatorColor: Get.isDarkMode ? colorSecondary : Colors.white,
              labelColor:  Get.isDarkMode ? colorSecondary : Colors.white,
              onTap: controller.tabBarItemSelected,
              padding: EdgeInsets.only(top: 15),
              tabs: [
                Tab(icon: Icon(Icons.camera_alt)),
                Tab(
                    icon: CustomText(
                  "CHATS",
                  color: Colors.white,
                )),
                Tab(
                    icon: CustomText(
                  "STATUS",
                  color: Colors.white,
                )),
                Tab(
                    icon: CustomText(
                  "CALLS",
                  color: Colors.white,
                )),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              CameraView(),
              ChatsView(),
              Icon(Icons.directions_bike),
              Icon(Icons.directions_bike),
            ],
          ),
        ));
  }
}
