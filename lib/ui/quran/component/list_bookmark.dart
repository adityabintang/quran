import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/bloc/bookmark/bloc.dart';
import 'package:quran_app/helper/db_helper.dart';

import '../../../widget/bookmark_icon.dart';

class ListBookmark extends StatefulWidget {
  const ListBookmark({super.key});

  @override
  State<ListBookmark> createState() => _ListBookmarkState();
}

class _ListBookmarkState extends State<ListBookmark> {
  final BookmarksBloc bookmarksBloc = BookmarksBloc(DatabaseHelper());

  @override
  void initState() {
    bookmarksBloc.add(BookmarksFetch());
    super.initState();
  }

  @override
  void dispose() {
    bookmarksBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF0E3FF),
              Color(0xFFFFFFFF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.center,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                _buildAppBar(),
                _buildBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildBody() {
    return BlocBuilder<BookmarksBloc, BookmarksState>(
      bloc: bookmarksBloc,
      builder: (context, state) {
        if (state is BookmarksFailure) {
          return Center(
            child: Text(
              '${state.dataError}',
              style: GoogleFonts.roboto(
                fontSize: 18,
              ),
            ),
          );
        }
        if (state is BookmarksLoaded) {
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.ayat?.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(top: 30, right: 20, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Stack(
                            children: [
                              Image.asset(
                                'assets/label_surah.png',
                                width: 36,
                                height: 36,
                              ),
                              SizedBox(
                                width: 36,
                                height: 36,
                                child: Center(
                                  child: Text(
                                    '${state.ayat?[index].nomorAyat}',
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF332885),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const Spacer(),
                           BookmarkIcon(
                            ayat: state.ayat?[index].ayat,
                             listSurah: state.ayat?[index].surah,
                             numberSurah: state.ayat?[index].nomorSurah,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        '${state.ayat?[index].teksArab}',
                        style: GoogleFonts.amiri(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${state.ayat?[index].teksIndonesia}',
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                );
              });
        }
        return const Center(
          child: CircularProgressIndicator(
            color: Color(0xFF332885),
          ),
        );
      },
    );
  }

  Widget _buildAppBar() {
    return Container(
      margin: const EdgeInsets.only(top: 26),
      child: ListTile(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const ImageIcon(
            AssetImage('assets/arrow_left.png'),
            color: Color(0xFF332885),
            size: 30,
          ),
        ),
        title: Text(
          'Bookmarks',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: const Color(0xFF332885),
          ),
        ),
        trailing: const Icon(
          CupertinoIcons.search,
          size: 20,
          color: Color(0xFF332885),
        ),
      ),
    );
  }
}
