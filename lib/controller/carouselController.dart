import 'package:get/get.dart';

import '../models/carouselModel.dart';

class AdvertismentController extends GetxController {
  var advertismentList = <CarouselModel>[].obs;

  @override
  void onInit() {
    advertismentList.addAll([
      CarouselModel(
          // "https://patch.com/img/cdn20/users/22844250/20180716/040649/styles/raw/public/processed_images/general_movies_shutterstock-1531771529-5078.jpg",
          "https://www.intofilm.org/intofilm-production/11393/scaledcropped/630x355/resources/11393/spring-screenings-2024-header.jpg",
          "",
          ""),
      CarouselModel(
          // "https://media.istockphoto.com/id/1237804526/vector/movie-night-concept-with-popcorn-cinema-tickets-drink-tape-in-cartoon-style-movie-or-cinema.jpg?s=612x612&w=0&k=20&c=FWIp6SXBqUg-_PWtoTxOy00b2aeg5xNDiRcFr6IF4l4=",
          "https://www.intofilm.org/intofilm-production/11393/scaledcropped/630x355/resources/11393/spring-screenings-2024-header.jpg",
          "",
          ""),
      CarouselModel(
          // "https://awsimages.detik.net.id/community/media/visual/2021/10/05/sudah-boleh-makan-di-bioskop-5-jajanan-ini-yang-bikin-kangen-2_43.jpeg?w=600&q=90",
          "https://img.freepik.com/premium-vector/flat-design-cinema-festival-horizontal-banner_23-2149949264.jpg",
          // "Hungry while watching",
          // "go get your snack and make your movie night perfect",
          "", ""),
      CarouselModel(
          "https://www.intofilm.org/intofilm-production/11393/scaledcropped/630x355/resources/11393/spring-screenings-2024-header.jpg",
          "",
          ""),
      CarouselModel(
          "https://img.freepik.com/premium-vector/flat-design-cinema-festival-horizontal-banner_23-2149949264.jpg",
          "",
          ""),
    ]);
    super.onInit();
  }
}
