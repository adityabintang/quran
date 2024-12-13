import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/ui/doa/component/search_box.dart';
import 'package:quran_app/ui/doa/list_doa.dart';
import 'package:quran_app/ui/sholawat/list_sholawat.dart';
import 'package:quran_app/widget/search.dart';

class PrayersPage extends StatefulWidget {
  const PrayersPage({super.key});

  @override
  State<PrayersPage> createState() => _PrayersPageState();
}

class _PrayersPageState extends State<PrayersPage> {
  final _searchController = TextEditingController();

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
              SearchBoxComponent(
                hintText: 'Search Sholawat',
                searchController: _searchController,
                onSearching: _onSearching,
                onClear: _onClear,
              ),
              const Expanded(
                child: ListSholawatPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void>? _onSearching(String text) {
    return null;
  }

  void _onClear() {
    setState(() {});
  }

  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 26,
                top: 26,
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const ImageIcon(
                  AssetImage('assets/arrow_left.png'),
                  color: Color(0xFF332885),
                  size: 30,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 12,
                top: 26,
              ),
              child: Text(
                'Sholawat',
                style: GoogleFonts.roboto(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF332885),
                ),
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(
            right: 26,
            top: 26,
          ),
          child: Row(
            children: [
              Icon(
                CupertinoIcons.bookmark_fill,
                size: 20,
                color: Color(0xFF332885),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
