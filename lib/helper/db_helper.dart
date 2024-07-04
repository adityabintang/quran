import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:quran_app/models/ayah_model.dart';
import 'package:quran_app/models/detail_surah_model.dart';
import 'package:quran_app/models/error_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  static const String _tblBookmark = 'bookmarks';
  static const String _tblBookmarkPerAyah = 'bookmarks_per_ayah';

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/quran_app.db';

    var db = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

  void _onCreate(Database db, int version) async {
    // await db.execute('''
    // CREATE TABLE $_tblBookmark(
    // nomorAyat INTEGER PRIMARY KEY,
    // teksArab TEXT,
    // teksLatin TEXT,
    // teksIndonesia TEXT,
    // audio TEXT
    // )
    // ''');
    await db.execute('''
    CREATE TABLE $_tblBookmarkPerAyah(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nomorAyat INTEGER,
    nomor INTEGER,
    data TEXT,
    teksArab TEXT,
    teksLatin TEXT,
    teksIndonesia TEXT,
    ayat TEXT,
    audio TEXT,
    UNIQUE(nomor, nomorAyat)
    )
    ''');
  }

  Future<int> saveBookmarksPerAyah(AyahModel? ayat) async {
    final db = await database;
    return await db!.insert(_tblBookmarkPerAyah, ayat!.toJsonLocal());
  }

  Future<Either<ErrorModel, List<AyahModel>>> getPerAyah() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db!.query(_tblBookmarkPerAyah);
    if (maps.isNotEmpty) {
      return Right(List.generate(maps.length, (i) {
        return AyahModel.fromJson(maps[i]);
      }));
    } else {
      return Left(
          ErrorModel.fromJson(jsonDecode('Gagal mengambil data list ayat')));
    }
  }

  Future<AyahModel?> getBookmarksByIdPerAyah(int? surahId, int? ayatId) async {
    final db = await database;
    final results = await db!.query(
      _tblBookmarkPerAyah,
      where: 'nomor = ? AND nomorAyat = ?',
      whereArgs: [surahId, ayatId],
    );
    if (results.isNotEmpty) {
      return AyahModel.fromJson(results.first);
    } else {
      return null;
    }
  }

  Future<int> removeBookmarksPerAyah(int? surahId, int? ayatId) async {
    final db = await database;
    return await db!.delete(
      _tblBookmarkPerAyah,
      where: 'nomor = ? AND nomorAyat = ?',
      whereArgs: [surahId, ayatId],
    );
  }

// Future<int> saveBookmarks(Ayat? ayat) async {
//   final db = await database;
//   return await db!.insert(_tblBookmark, ayat!.toJsonLocal());
// }
//
// Future<Either<ErrorModel, List<Ayat>>> getAyatList() async {
//   final db = await database;
//   final List<Map<String, dynamic>> maps = await db!.query(_tblBookmark);
//   if (maps.isNotEmpty) {
//     return Right(List.generate(maps.length, (i) {
//       return Ayat.fromJson(maps[i]);
//     }));
//   } else {
//     return Left(ErrorModel.fromJson(jsonDecode('Gagal mengambil data list ayat')));
//   }
// }
//
// Future<Ayat?> getBookmarksById(int? id) async {
//   final db = await database;
//   final results = await db!.query(
//     _tblBookmark,
//     where: 'nomorAyat = ?',
//     whereArgs: [id],
//   );
//   if (results.isNotEmpty) {
//     return Ayat.fromJson(results.first);
//   } else {
//     return null;
//   }
// }
//
// Future<int> removeBookmarks(Ayat? ayat) async {
//   final db = await database;
//   return await db!.delete(
//     _tblBookmark,
//     where: 'nomorAyat = ?',
//     whereArgs: [ayat?.nomorAyat],
//   );
// }
}
