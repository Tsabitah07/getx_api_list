import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:getx_api_list/components/themes.dart';
import 'package:getx_api_list/controller/favoriteController.dart';
import 'package:getx_api_list/controller/popularMovieController.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key});
  final controller = Get.put(PopularMovieController());
  final favoritesController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = Get.arguments as Map<String, dynamic>;
    final int id = arguments['id'];
    final int index = arguments['index'];

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 300,
              width: width,
              decoration: BoxDecoration(
                color: backgroundColor,
                image: DecorationImage(
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/w500/${controller.movies[index].backdropPath}'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.45), BlendMode.darken),
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  width: width,
                  height: 265,
                  color: Colors.transparent,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 17, left: 15),
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 27,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 17, right: 15),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                favoritesController.favorites.contains(id)
                                  ?favoritesController.removeFromFavorite(id)
                                  :favoritesController.addToFavorite(id);
                              },
                              icon: Obx((){
                                if(favoritesController.favorites.contains(id)){
                                  return Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 27,
                                  );
                                } else {
                                  return Icon(
                                    Icons.favorite_border_outlined,
                                    color: Colors.white,
                                    size: 27,
                                  );
                                }
                              })
                            ),
                            // IconButton(
                            //   onPressed: () {},
                            //   icon: Icon(
                            //     Icons.playlist_add,
                            //     color: Colors.white,
                            //     size: 27,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: width,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(21),
                      topRight: Radius.circular(21),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            child: Transform.translate(
                              offset: Offset(0, -45),
                              child: Container(
                                width: 113, height: 163,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage('https://image.tmdb.org/t/p/w500/${controller.movies[index].posterPath}'),
                                        fit: BoxFit.cover
                                    )
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: width - 200,
                            margin: EdgeInsets.only(left: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    controller.movies[index].title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: HeaderTextStyle(/*22, primaryTextColor*/)
                                ),
                                Text(
                                    DateFormat('yMMM').format(controller.movies[index].releaseDate),
                                    style: bodyTextStyle2(/*17, secondaryTextColor*/)
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${controller.movies[index].voteAverage.toString()} • ',
                                      style: bodyTextStyle2(/*17, secondaryTextColor*/),
                                    ),
                                    RatingBar.builder(
                                      initialRating: controller.movies[index].voteAverage / 2,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 20,
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {},
                                      ignoreGestures: true,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(height: 25),
                      Container(
                        // margin: EdgeInsets.only(top: 15),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        width: width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx((){
                              if(controller.movies[index].adult == controller.isAdult.value){
                                return Text(
                                  "Rating Usia: SU (Semua Umur)",
                                  style: bodyTextStyle2(/*17, primaryTextColor*/),
                                );
                              } else {
                                return Text(
                                  "Rating Usia: 18+",
                                  style: bodyTextStyle2(/*17, primaryTextColor*/),
                                );
                              }
                            }),
                            SizedBox(height: 7),
                            Text(
                              "Overview",
                              textAlign: TextAlign.start,
                              style: bodyTextStyle2(/*17, primaryTextColor*/),
                            ),
                            Text(
                              controller.movies[index].overview,
                              textAlign: TextAlign.justify,
                              style: bodyTextStyle2(/*15, secondaryTextColor*/),
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
