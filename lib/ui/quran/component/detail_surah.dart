import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/ui/quran/component/tabbar_surah.dart';
import '../../../models/detail_surah_model.dart';

class DetailSurahPage extends StatefulWidget {
  final Surah? data;
  final List<Surah>? dataList;
  final int? index;

  const DetailSurahPage({super.key, this.data, this.dataList, this.index});

  @override
  State<DetailSurahPage> createState() => _DetailSurahPageState();
}

class _DetailSurahPageState extends State<DetailSurahPage> {
  late ValueNotifier<Surah?> currentSurahNotifier;

  @override
  void initState() {
    super.initState();
    currentSurahNotifier = ValueNotifier<Surah?>(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
          child: Column(
            children: [
              _buildAppBar(),
              Expanded(
                child: TabBarSurah(
                  data: widget.data,
                  dataList: widget.dataList,
                  index: widget.index,
                  onTabChanged: (int index){
                    currentSurahNotifier.value = widget.dataList?[index - 1];
                  },
                ),
              ),
              // _buildTabBarSurah(),
              // _buildFirstAyah(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return ValueListenableBuilder(
      valueListenable: currentSurahNotifier,
      builder: (context, currentSurah, child) {
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
              '${currentSurah?.namaLatin}',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: const Color(0xFF332885),
              ),
            ),
            subtitle: Text(
              '${currentSurah?.tempatTurun} - ${currentSurah?.arti} - ${currentSurah?.jumlahAyat} Ayat',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                fontSize: 10,
                color: Colors.grey,
              ),
            ),
            // trailing: const Icon(
            //   CupertinoIcons.bookmark_fill,
            //   size: 20,
            //   color: Color(0xFF332885),
            // ),
          ),
        );
      },
    );
  }
}
