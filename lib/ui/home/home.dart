import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/models/master_data.dart';
import 'package:quran_app/ui/home/menus.dart';
import 'package:quran_app/widget/grid_menus.dart';
import 'package:quran_app/widget/grid_menus_v2.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MasterData> _masterDataList = [];
  Menus userMenus = Menus();

  void onMenuTap(Function onMenuTap) {
    onMenuTap();
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 26,
                    top: 26,
                  ),
                  child: Text(
                    'Assalamualaikum, Bintang',
                    style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF332885)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 26,
                    top: 3,
                  ),
                  child: Text(
                    'Salatiga, 20 Juni 2024',
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                    ),
                  ),
                ),
                _buildRecitation(context),
                _buildPray(),
                _buildLastRead(),
                _buildKiblat(),
                _buildMyNotes(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMyNotes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 26,
            top: 26,
          ),
          child: Text(
            'My Notes',
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.separated(
            itemCount: 2,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                width: 200,
                margin: const EdgeInsets.only(top: 10, left: 18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: const Color(0xFF6A8BFF).withOpacity(0.3),
                  border: Border.all(
                    width: 2,
                    color: const Color(0xFF6A8BFF).withOpacity(0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 18,
                          width: 47,
                          margin: const EdgeInsets.only(left: 15, top: 11),
                          decoration: BoxDecoration(
                              color: const Color(0xFF332885).withOpacity(0.4),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                            child: Text(
                              '27 Juni',
                              style: GoogleFonts.roboto(
                                  color: const Color(0xFF332885),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          height: 18,
                          width: 50,
                          margin: const EdgeInsets.only(top: 11, right: 16),
                          decoration: BoxDecoration(
                              color: const Color(0xFFFFE24A),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                            child: Text(
                              'Progress',
                              style: GoogleFonts.roboto(
                                color: const Color(0xFFE55527),
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          'Al-Fatihah 1 - Al-Baqoroh 200',
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: const Color(0xFF686868),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Container();
            },
          ),
        )
      ],
    );
  }

  Widget _buildKiblat() {
    return Container(
      margin: const EdgeInsets.only(top: 30, right: 20, left: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF6877FF),
            Color(0xFF35F8A6),
            // Color(0xFFFF78C1),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Magrib 17:30 WIB ',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        '20:30:10 Menjelang Azan',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        height: 18,
                        width: 30,
                        decoration: BoxDecoration(
                            color: const Color(0xFF51FF62),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(30)),
                        child: const Icon(
                          Icons.volume_up,
                          size: 15,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/kiblat.png',
                  fit: BoxFit.cover,
                  height: 68,
                  width: 67, // Provide width to the image to avoid overflow
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLastRead() {
    return Container(
      margin: const EdgeInsets.only(top: 30, right: 20, left: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF3B97ED),
            Color(0xFFCA74FF),
            Color(0xFFFF78C1),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Last Read',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Al-Baqarah',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  // const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '15 %',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(17),
                    value: 0.5,
                    backgroundColor: const Color(0xFF070000).withOpacity(0.5),
                    minHeight: 10,
                    valueColor: const AlwaysStoppedAnimation(Colors.white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/Alquran.png',
                  fit: BoxFit.cover,
                  height: 68,
                  width: 88, // Provide width to the image to avoid overflow
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecitation(BuildContext context) {
    _buildMenus(context);
    return GridMenus(
      onMenuTap: onMenuTap,
      listMenu: _masterDataList,
    );
  }

  Widget _buildPray() {
    _buildMenusV2();
    return GridMenusV2(
      onMenuTap: onMenuTap,
      listMenu: _masterDataList,
    );
  }

  _buildMenus(BuildContext context) {
    _masterDataList = [];

    _masterDataList = userMenus.buildMenus(context);
  }

  _buildMenusV2() {
    _masterDataList = [];

    _masterDataList = userMenus.buildMenusV2();
  }
}
