import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:getx_api_list/controller/productController.dart';
import 'package:intl/intl.dart';

import '../../components/themes.dart';
import '../up_coming/detailPage.dart';

class ListDetail extends StatelessWidget {
  ListDetail({super.key});
  final controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upcoming Movies",
            style: HeaderTextStyle(/*18, primaryTextColor*/)
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: ListView.builder(
              itemCount: controller.movies.length,
              itemBuilder: (context, index) {
                final movieData = controller.movies[index];

                return InkWell(
                  onTap: () {
                    Get.to(DetailPage(), arguments: {'id' : movieData.id, 'index' : index});
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 185,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 160, width: 95,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage('https://image.tmdb.org/t/p/w500/${movieData.posterPath}')
                              )
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: width * .55,
                              child: Text(
                                  movieData.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.fade,
                                  textAlign: TextAlign.justify,
                                  style: HeaderTextStyle(/*20, primaryTextColor*/)
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                    DateFormat('MMMM').format(movieData.releaseDate),
                                    style: BodyTextStyle(/*15, primaryTextColor*/)
                                ),
                                Text(
                                    " " + movieData.releaseDate.day.toString(),
                                    style: BodyTextStyle(/*15, primaryTextColor*/)
                                ),
                                Text(
                                    ", ",
                                    style: TextStyle(
                                        fontSize: 15
                                    )
                                ),
                                Text(
                                    movieData.releaseDate.year.toString(),
                                    style: BodyTextStyle(/*15, primaryTextColor*/)
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${controller.movies[index].voteAverage.toString()} • ',
                                  style: BodyTextStyle(/*17, secondaryTextColor*/),
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
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      }),
    );
  }
}
