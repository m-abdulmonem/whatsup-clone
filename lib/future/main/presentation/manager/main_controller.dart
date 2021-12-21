import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whats_app_clone/core/lib/custom_widgets.dart';

class MainController extends GetxController{
  final menuItems = <String>[
    "New group",
    "New broadcast",
    "Linked devices",
    "Starred messages",
    "Settings"
  ];


  void onSearchClicked(){

  }

  void menuItemSelected(String item){

  }

  void tabBarItemSelected(int index){
    if (index == 0) Get.toNamed('main/camera');
  }

  List<PopupMenuEntry<String>> popupMenus(){
    var items = <PopupMenuEntry<String>>[];
    menuItems.map((title) => items.add(PopupMenuItem(child: CustomText(title),value: title,)));
    return items;
  }
  
}