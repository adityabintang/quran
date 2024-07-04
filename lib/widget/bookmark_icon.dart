import 'package:flutter/material.dart';
import 'package:quran_app/bloc/bookmark/bloc.dart';
import 'package:quran_app/helper/db_helper.dart';
import 'package:quran_app/models/ayah_model.dart';
import 'package:quran_app/models/detail_surah_model.dart';

class BookmarkIcon extends StatefulWidget {
  final Ayat? ayat;
  final List<Surah>? listSurah;
  final int? numberSurah;
  const BookmarkIcon({
    super.key,
    this.ayat,
    this.listSurah, this.numberSurah,
  });

  @override
  _BookmarkIconState createState() => _BookmarkIconState();
}

class _BookmarkIconState extends State<BookmarkIcon> {
  late Future<bool> _isBookmarkedFuture;
  DatabaseHelper databaseHelper = DatabaseHelper();
  final BookmarksBloc bookmarksBloc = BookmarksBloc(DatabaseHelper());
  AyahModel? ayahModel;
  @override
  void initState() {
    super.initState();
    _isBookmarkedFuture = bookmarksStatus(widget.numberSurah, widget.ayat?.nomorAyat);
    ayahModel = AyahModel(
      nomorSurah: widget.numberSurah,
      surah: widget.listSurah,
      nomorAyat: widget.ayat?.nomorAyat,
      teksArab: widget.ayat?.teksArab,
      teksIndonesia: widget.ayat?.teksIndonesia,
      audio: widget.ayat?.audio,
      ayat: widget.ayat,
    );
  }

  Future<void> _toggleBookmark() async {
    if (await bookmarksStatus(widget.numberSurah, widget.ayat?.nomorAyat)) {
      await databaseHelper.removeBookmarksPerAyah(widget.numberSurah, widget.ayat?.nomorAyat);
      // await databaseHelper.removeBookmarks(widget.ayat);
    } else {
      await databaseHelper.saveBookmarksPerAyah(ayahModel);
      // await databaseHelper.saveBookmarks(widget.ayat);
    }
    setState(() {
      _isBookmarkedFuture = bookmarksStatus(widget.numberSurah, widget.ayat?.nomorAyat);
    });
  }

  Future<bool> bookmarksStatus(int? idSurah, int? idAyat) async {
    final result = await databaseHelper.getBookmarksByIdPerAyah(idSurah, idAyat);
    return result != null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isBookmarkedFuture,
      builder: (context, snapshot) {
        final isAdded = snapshot.data ?? false;
        return IconButton(
          icon: isAdded
              ? const Icon(
                  Icons.bookmark,
                  color: Color(0xFF332885),
                )
              : const Icon(
                  Icons.bookmark_border,
                ),
          onPressed: _toggleBookmark,
          color: const Color(0xFF332885),
        );
      },
    );
  }
}
