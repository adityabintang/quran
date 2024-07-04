import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_app/bloc/detail_surah/bloc.dart';
import 'package:quran_app/bloc/detail_surah/repository.dart';
import 'package:quran_app/widget/bookmark_icon.dart';
import '../../../models/detail_surah_model.dart';

class TabBarSurah extends StatefulWidget {
  final List<Surah>? dataList;
  final int? index;
  final ValueChanged<int>? onTabChanged;
  final Surah? data;

  const TabBarSurah({
    super.key,
    this.dataList,
    this.index,
    this.onTabChanged,
    this.data,
  });

  @override
  State<TabBarSurah> createState() => _TabbarSurahState();
}

class _TabbarSurahState extends State<TabBarSurah>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  DetailSurahBloc detailSurahBloc = DetailSurahBloc(DetailSurahRepository());

  final ScrollController _scrollController = ScrollController();

  final AudioPlayer audioPlayer = AudioPlayer();
  int currentAyatIndex = 0;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: widget.dataList?.length ?? 0, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.index != null) {
        _tabController!
            .animateTo((widget.dataList!.length - 1) - widget.index!);
      }
    });
    _tabController?.addListener(() {
      final currentIndex = _tabController!.index;
      final reversedIndex = widget.dataList!.length - 1 - currentIndex;
      widget.onTabChanged?.call(widget.dataList?[reversedIndex].nomor ?? 0);
      detailSurahBloc.add(
          DetailSurahFetch(numberSurah: widget.dataList![reversedIndex].nomor));
      setState(() {});
    });
    detailSurahBloc.add(DetailSurahFetch(
        numberSurah: widget.dataList?[widget.index ?? 0].nomor));
    audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        setState(() {
          _playNextAyat();
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    detailSurahBloc.close();
    audioPlayer.dispose();
    super.dispose();
  }

  void _playNextAyat() {
    final currentState = detailSurahBloc.state;
    if (currentState is DetailSurahLoaded) {
      final ayatList = currentState.surah?.data?.ayat ?? [];
      if (currentAyatIndex < ayatList.length - 1) {
        currentAyatIndex++;
        audioPlayer.setUrl(ayatList[currentAyatIndex].audio?.s01 ?? '');
        audioPlayer.play();
        setState(() {
          isPlaying = true;
          _scrollToCurrentAyat();
        });
      } else {
        setState(() {
          isPlaying = false;
        });
      }
    }
  }

  void _scrollToCurrentAyat() {
    _scrollController.animateTo(
      currentAyatIndex * 150.0, // Adjust the offset as needed
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
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
        child: DefaultTabController(
          length: _tabController?.length ?? 0,
          child: Column(
            children: [
              _buildTabBar(),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: widget.dataList?.reversed.map((e) {
                        return _buildFirstAyat();
                      }).toList() ??
                      [],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFirstAyat() {
    return BlocBuilder<DetailSurahBloc, DetailSurahState>(
      bloc: detailSurahBloc,
      builder: (context, state) {
        if (state is DetailSurahFailure) {
          return Center(
            child: Text(
              '${state.dataError}',
              style: GoogleFonts.roboto(
                fontSize: 18,
              ),
            ),
          );
        }
        if (state is DetailSurahLoaded) {
          return SingleChildScrollView(
            controller: _scrollController,
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30, right: 20, left: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF9466B1),
                        Color(0xFF3D4DD8),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            '${state.surah?.data?.ayat?[0].teksArab}ِ',
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Center(
                          child: Text(
                            '${state.surah?.data?.ayat?[0].teksIndonesia}',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _buildAyatItems(state.surah),
              ],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            color: Color(0xFF332885),
          ),
        );
      },
    );
  }

  Widget _buildAyatItems(DetailSurahModel? surah){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: ((surah?.data?.ayat?.length ?? 0) - 1)
          .clamp(0, surah?.data?.ayat?.length ?? 0),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        // Start from the second Ayah
        final data = surah?.data?.ayat?.elementAt(index + 1);
        return Container(
          margin:
          const EdgeInsets.only(top: 30, right: 20, left: 20),
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
                            '${data?.nomorAyat}',
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
                  // FutureBuilder<bool>(
                  //   future: bookmarksStatus(state.surah?.data?.ayat
                  //       ?.elementAt(index + 1)
                  //       .nomorAyat),
                  //   builder: (context, snapshot) {
                  //     final isAdded = snapshot.data ?? false;
                  //     return IconButton(
                  //       icon: isAdded
                  //           ? const Icon(
                  //               Icons.bookmark,
                  //         color: Color(0xFF332885),
                  //             )
                  //           : const Icon(
                  //               Icons.bookmark_border,
                  //             ),
                  //       onPressed: () async {
                  //         await databaseHelper.saveBookmarks(
                  //           state.surah?.data?.ayat
                  //               ?.elementAt(index + 1),
                  //         );
                  //         // if (!isAddedWatchlist) {
                  //         //   bookmarkBloc.add(SaveBookmarks(state.surah!));
                  //         // }
                  //         //
                  //         // String message = !isAddedWatchlist
                  //         //     ? BookmarkBloc.watchlistAddSuccessMessage
                  //         //     : BookmarkBloc.watchlistRemoveSuccessMessage;
                  //         //
                  //         // final stateBookmark = BlocProvider.of<BookmarkBloc>(context).state;
                  //         //
                  //         // if (stateBookmark is SaveBookmarksMessage || stateBookmark is BookmarksStatus) {
                  //         //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                  //         //   bookmarkBloc.add(BookmarksStatusEvent(state.surah?.data?.nomor ?? 0));
                  //         // } else {
                  //         //   showDialog(
                  //         //     context: context,
                  //         //     builder: (context) {
                  //         //       return const AlertDialog(
                  //         //         content: Text('Failed'),
                  //         //       );
                  //         //     },
                  //         //   );
                  //         // }
                  //       },
                  //       color: const Color(0xFF332885),
                  //     );
                  //   },
                  // ),
                  BookmarkIcon(
                    ayat: surah?.data?.ayat
                        ?.elementAt(index + 1),
                    listSurah: widget.dataList,
                    numberSurah: widget.dataList?[widget.index ?? 0].nomor,
                  ),
                  IconButton(
                    icon: Icon(
                      isPlaying && currentAyatIndex == index + 1
                          ? Icons.pause
                          : Icons.play_arrow_sharp,
                      color: const Color(0xFF332885),
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        if (isPlaying &&
                            currentAyatIndex == index + 1) {
                          audioPlayer.pause();
                          isPlaying = false;
                        } else {
                          currentAyatIndex = index + 1;
                          audioPlayer
                              .setUrl(data?.audio?.s01 ?? '');
                          audioPlayer.play();
                          isPlaying = true;
                        }
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                '${data?.teksArab}',
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
                  '${data?.teksIndonesia}',
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
      },
    );
  }

  Widget _buildTabBar() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 55,
            width: 90,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelPadding: const EdgeInsets.symmetric(horizontal: 8),
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
              unselectedLabelColor: Colors.black,
              labelColor: Colors.white,
              labelStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold),
              unselectedLabelStyle: GoogleFonts.roboto(color: Colors.white),
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: const Color(0xFF332885),
              ),
              tabs: widget.dataList?.reversed.map((e) {
                    return Tab(
                      child: Container(
                        height: 35,
                        width: 90,
                        decoration: BoxDecoration(
                          color: const Color(0xFF5541EA).withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: const Color(0xFF5541EA).withOpacity(0.2),
                              width: 1),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "${e.nomor}. ${e.namaLatin}",
                            style: GoogleFonts.roboto(fontSize: 10),
                          ),
                        ),
                      ),
                    );
                  }).toList() ??
                  [],
            ),
          ),
        ),
      ],
    );
  }
}
