import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_api_list/components/themes.dart';
import 'package:getx_api_list/views/up_coming/listDetail.dart';
import 'package:intl/intl.dart';

import '../../controller/productController.dart';
import '../../views/up_coming/detailPage.dart';

class HorizontalList extends StatelessWidget {
  HorizontalList({super.key});
  final controller = Get.put(ProductController());

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
                "Upcoming Movies",
                style: HeaderTextStyle(/*18, primaryTextColor*/)
              ),
              InkWell(
                onTap: () {
                  Get.to(ListDetail());
                },
                child: Text("Show all")
              ),
            ],
          ),
          SizedBox(height: 15),
          Obx((){
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Container(
                height: 350,
                // color: Colors.black,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    final movieData = controller.movies[index];

                    return InkWell(
                      onTap: () {
                        Get.to(DetailPage(), arguments: {'id' : movieData.id, 'index' : index});
                      },
                      child: Container(
                        width: 170,
                        height: 255,
                        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 225, width: 170,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
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
                                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  child: Text(
                                    movieData.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.fade,
                                    textAlign: TextAlign.justify,
                                    style: SubHeaderTextStyle(/*17, primaryTextColor*/)
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Text(
                                        DateFormat('MMMM').format(movieData.releaseDate),
                                        style: BodyTextStyle(/*15, primaryTextColor*/)
                                      ),
                                    ),
                                    Text(
                                      ' ' + movieData.releaseDate.year.toString(),
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
          })
        ],
      )
    );
  }
}
