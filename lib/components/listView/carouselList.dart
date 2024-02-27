import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../controller/carouselController.dart';
import '../themes.dart';

class CarouselList extends StatelessWidget {
  CarouselList({Key? key}) : super(key: key);
  final controller = Get.put(AdvertismentController());

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: CarouselSlider.builder(
          itemCount: controller.advertismentList.length,
          itemBuilder: (context, index, realIndex) {
            final advertisment = controller.advertismentList[index];
            return Stack(
              children: [
                Container(
                    width: width,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(
                          advertisment.image,
                        ),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.1), BlendMode.darken),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 5,),
                          Text(
                            advertisment.title,
                            style: HeaderTextStyle(/*20, primaryTextColor*/),
                          ),
                          SizedBox(height: 4),
                          Text(
                            advertisment.etc,
                            style: BodyTextStyle(/*16, secondaryTextColor*/)
                          )
                        ],
                      ),
                    )),
              ],
            );
          },
          options: CarouselOptions(
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            autoPlay: true,
          ),
        ));
  }
}