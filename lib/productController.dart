import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_api_list/productModel.dart';
import 'package:http/http.dart' as http;

class ProductController extends GetxController {
  RxList<Result> movies = <Result>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    try {
      final response = await http.get(Uri.parse('https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&sort_by=popularity.desc&api_key=19248e2e2b57b25e4d0e63b5fada8777'),);
      if (response.statusCode == 200) {
        final movie = movieFromJson(response.body);
        movies.assignAll(movie.results);
        isLoading.value = false;
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}