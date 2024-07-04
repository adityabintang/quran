import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoaPage extends StatefulWidget {
  const DoaPage({super.key});

  @override
  State<DoaPage> createState() => _DoaPageState();
}

class _DoaPageState extends State<DoaPage> {
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
                'Doa',
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
