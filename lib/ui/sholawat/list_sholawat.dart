import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListSholawatPage extends StatefulWidget {
  const ListSholawatPage({super.key});

  @override
  State<ListSholawatPage> createState() => _ListSholawatPageState();
}

class _ListSholawatPageState extends State<ListSholawatPage> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          _buildLastRead(),
          _buildListSholawat(),
        ],
      ),
    );
  }

  Widget _buildLastRead() {
    return Container(
      margin: const EdgeInsets.only(top: 10, right: 20, left: 20),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFEBD7FF),
            blurRadius: 5,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: AssetImage('assets/sholawat_cover.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF6655D0).withOpacity(0.3),
                  const Color(0xFF295EE8).withOpacity(0.69),
                ],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
              ),
            ),
          ),
          // Text content
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Last Read',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  'Sholawat Nabi Ta\'dzhimul Qiyam',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListSholawat() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(20),
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {},
          leading: Stack(
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
                    '${index + 1}',
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
          title: Text(
            'Doa Sebelum Makan',
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: const Color(0xFF332885),
            ),
          ),
          trailing: const Icon(
            Icons.bookmark_border,
          ),
        );
      },
      separatorBuilder: (context, index) => Divider(
        color: Colors.grey.withOpacity(0.5),
        thickness: 1, // Uncommented and set to 1
        endIndent: 26,
        indent: 26,
      ),
      itemCount: 6,
    );
  }
}
