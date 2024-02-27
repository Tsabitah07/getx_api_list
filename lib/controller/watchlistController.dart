import 'dart:core';

import 'package:get/get.dart';
import 'package:getx_api_list/controller/productController.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/productModel.dart';

class WatchlistController extends GetxController{
  static Database? _database;
  static final String tableName = 'watchlist';
  RxList<int> watchlist = RxList<int>();
  RxBool inList = false.obs;

  onInit() async {
    super.onInit();
    await initDB();
  }

  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  static Future<Database> initDB() async {
    final path = await getDatabasesPath();
    final _databasePath = join(path, 'watchlist.db');

    return await openDatabase(_databasePath, version: 1,
        onCreate: (db, version) async {
          await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        voteAverage INTEGER,
        poster_path TEXT,
        backdrop_path TEXT,
        release_date TEXT
      )
    ''');
        });
  }

  static Future<void> insertAllPopularMovies(
      List<Map<String, dynamic>> products) async {
    final db = await database;
    // Gunakan transaction untuk menyisipkan semua produk secara bersamaan - kata gpt
    await db.transaction((txn) async {
      for (var product in products) {
        await txn.insert(tableName, product,
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    });
  }

  Future<void> removeMovies(int id) async {
    final db = await database;
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> insertMovies(List<int> watchlist) async {
    final db = await database;
    await db.transaction((txn) async {
      for (var id in watchlist) {
        await txn.insert(tableName, {'id': id},
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    });
  }

  void addToFavorite(int id) async {
    try {
      if (!watchlist.contains(id)) {
        watchlist.add(id);
        await insertMovies([id]);
        inList != inList;
      }
    } catch (e) {
      print("Error adding movie to watchlist: $e");
    }
  }

  void removeFromFavorite(int id) async {
    try {
      watchlist.remove(id);
      await removeMovies(id);
      inList == inList;
    } catch (e) {
      print("Error removing movie from watchlist: $e");
    }
  }

  Future<List<int>> getAllWatchlist() async {
    final db = await database;
    final List<Map<String, dynamic>> watchlist = await db.query(tableName);
    return watchlist.map((map) => map['id'] as int).toList();
  }

  Result findMovieById(int id) {
    final popularMovieController = Get.find<ProductController>();
    RxList<Result> movieList = popularMovieController.movies;

    try {
      return movieList.firstWhere((movie) => movie.id == id);
    } catch (e) {
      print("Movie with id $id not found: $e");
      return Result(
          adult: false,
          backdropPath: "",
          genreIds: [],
          id: 0,
          originalLanguage: '',
          originalTitle: '',
          overview: '',
          popularity: 0,
          posterPath: '',
          releaseDate: DateTime.now(),
          title: '',
          video: false,
          voteAverage: 0,
          voteCount: 0);
    }
  }
}