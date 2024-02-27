import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_api_list/components/themes.dart';
import 'package:getx_api_list/controller/popularMovieController.dart';
import 'package:getx_api_list/views/popular/detailPage.dart';
import 'package:getx_api_list/views/popular/listDetail.dart';
import 'package:intl/intl.dart';

class VerticalList extends StatelessWidget {
  VerticalList({super.key});
  final controller = Get.put(PopularMovieController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Popular Movies",
                style: HeaderTextStyle(/*18, primaryTextColor*/)
              ),
              InkWell(
                child: Text("Show all"),
                onTap: (){
                  Get.to(ListDetail());
                },
              ),
            ],
          ),
          SizedBox(height: 15),
          Obx(() {
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Container(
                height: 131 * 10.5,
                child: ListView.builder(
                  itemCount: 7,
                  // itemCount: controller.movies.length,
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
                          color: primaryColor,
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
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                    style: SubHeaderTextStyle(/*20, primaryTextColor*/)
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
        ],
      ),
    );
  }
}
