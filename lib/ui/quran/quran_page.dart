import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/ui/quran/component/list_bookmark.dart';
import 'package:quran_app/ui/quran/juz_page.dart';
import 'package:quran_app/ui/quran/surah_page.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({super.key});

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  List menus = ['Surah', 'Juz'];
  int selectedTab = 0;
  List ui = [const SurahPage(), const JuzPage()];

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(),
              Padding(
                padding: const EdgeInsets.only(top: 26),
                child: _buildTabBar(),
              ),
              Expanded(
                child: ui[selectedTab],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 26,
            top: 26,
          ),
          child: Text(
            'Al-Qur’an',
            style: GoogleFonts.roboto(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF332885),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 26,
            top: 26,
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  CupertinoIcons.bookmark_fill,
                  size: 20,
                  color: Color(0xFF332885),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ListBookmark()),
                  );
                },
              ),
              const SizedBox(
                width: 10,
              ),
              const Icon(
                CupertinoIcons.search,
                size: 20,
                color: Color(0xFF332885),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      height: 45,
      decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(50)),
      child: DefaultTabController(
        length: menus.length,
        child: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          unselectedLabelColor: const Color(0xFF332885),
          labelColor: const Color(0xFF332885),
          // indicatorColor: const Color(0xFF332885),
          // labelStyle: TextStyle(fontSize: ),
          onTap: (index) {
            setState(() {
              selectedTab = index;
            });
          },
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 2.0, // Thickness of the underline
              color: Color(0xFF332885), // Color of the underline
            ),
            insets: EdgeInsets.symmetric(horizontal: 50.0),
          ),
          // indicator: BoxDecoration(
          //     gradient:
          //         const LinearGradient(colors: [Colors.white, Colors.white]),
          //     borderRadius: BorderRadius.circular(50),
          //     color: Colors.redAccent),
          tabs: menus.map((e) {
            return Tab(text: e);
          }).toList(),
        ),
      ),
    );
  }
}
