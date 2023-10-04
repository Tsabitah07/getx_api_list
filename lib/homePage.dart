import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_api_list/productController.dart';

class HomePage extends StatelessWidget {
  final movieController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Movie List"),
      ),
      body: Obx(
        () => movieController.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: movieController.movies.length,
                itemBuilder: (BuildContext context, int index) {
                  final movieData = movieController.movies[index];
                  return Container(
                    margin: EdgeInsets.all(15),
                    child: Card(
                      margin: EdgeInsets.all(11),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: ListTile(
                        leading: Image.network('https://image.tmdb.org/t/p/w500/${movieData.posterPath}'),
                        title: Text(movieData.title),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
