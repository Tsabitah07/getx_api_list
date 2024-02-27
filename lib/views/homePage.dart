import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_api_list/components/bottomNavBar.dart';
import 'package:getx_api_list/components/listView/carouselList.dart';
import 'package:getx_api_list/components/listView/horizontalList.dart';
import 'package:getx_api_list/components/listView/verticalList.dart';
import 'package:getx_api_list/components/themes.dart';
import 'package:getx_api_list/controller/productController.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Movie List", style: appBar()),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              CarouselList(),
              HorizontalList(),
              VerticalList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(initialPage: 1),
    );
  }
}
