import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_api_list/components/themes.dart';
import 'package:getx_api_list/views/homePage.dart';
import 'package:getx_api_list/views/watchlistPage.dart';

import '../views/favoritePage.dart';

class BottomNavBar extends StatelessWidget {
  final initialPage;


  BottomNavBar({
    required this.initialPage
  });

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      height: 55,
      backgroundColor: primaryColor,
      items: [
        TabItem(icon: Icons.playlist_add, title: 'Watchlist'),
        TabItem(icon: Icons.home, title: 'Home'),
        TabItem(icon: Icons.favorite_border, title: 'Favorite'),
      ],
      onTap: (int i) {
        print('click index=$i');

        switch(i){
          case 0:
          // Handle tap on Home
            Get.off(WatchlistPage());
            break;
          case 1:
          // Handle tap on Favorites
            Get.off(HomePage());
            break;
          case 2:
          // Handle tap on Search
            Get.off(FavoritePage());
            break;
        }
      },
      initialActiveIndex: initialPage,
      style: TabStyle.flip,
    );
  }
}
