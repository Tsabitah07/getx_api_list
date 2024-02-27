import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:getx_api_list/components/bottomNavBar.dart';
import 'package:getx_api_list/components/themes.dart';
import 'package:getx_api_list/controller/watchlistController.dart';
import 'package:intl/intl.dart';

import '../models/productModel.dart';

class WatchlistPage extends StatelessWidget {
  WatchlistPage({super.key});
  final controller = Get.put(WatchlistController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Watchlist"),
      ),
      body: Obx(() {
        if(controller.watchlist.isEmpty){
          return Center(
            child: Text("No Favorites Movies"),
          );
        } else {
          return ListView.builder(
            itemCount: controller.watchlist.length,
            itemBuilder: (context, index) {
              final movieId = controller.watchlist[index];
              final Result movieDetails = controller.findMovieById(movieId);

              return Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                height: 170, width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage('https://image.tmdb.org/t/p/w500/${movieDetails.backdropPath}'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.45), BlendMode.darken),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movieDetails.title, style: SubHeaderTextStyle(/*20, Colors.white*/)),
                    Row(
                      children: [
                        Text('${DateFormat('yMMMMd').format(movieDetails.releaseDate)} ● ', style: BodyTextStyle(/*15, Colors.white*/)),
                        RatingBar.builder(
                          initialRating: movieDetails.voteAverage / 2,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 15,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {},
                          ignoreGestures: true,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        }
      }),
      bottomNavigationBar: BottomNavBar(initialPage: 0),
    );
  }
}
