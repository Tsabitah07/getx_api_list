import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/popularModel.dart';

class PopularMovieController extends GetxController{
  RxList<Popular> movies = <Popular>[].obs;
  var isLoading = true.obs;
  var isAdult = false.obs;

  @override
  void onInit() {
    super.onInit();
    popularMovies();
  }

  Future<void> popularMovies() async {
    try {
      final response = await http.get(Uri.parse('https://api.themoviedb.org/3/discover/movie?language=en-US&page=1&sort_by=popularity.desc&api_key=19248e2e2b57b25e4d0e63b5fada8777'),);
      if (response.statusCode == 200) {
        final movie = movieFromJson(response.body);
        movies.assignAll(movie.resultsPopular);
        isLoading.value = false;
      } else {
        print("Error: ${response.statusCode.toString()}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}