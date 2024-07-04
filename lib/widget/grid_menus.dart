import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/models/master_data.dart';

class GridMenus extends StatelessWidget {
  final Function onMenuTap;
  final List<MasterData> listMenu;

  const GridMenus({super.key, required this.onMenuTap, required this.listMenu});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 26, right: 26, left: 20),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: listMenu.length,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1,
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemBuilder: (BuildContext context, int index) {

          return _rowMasterData(listMenu[index]);
        },
      ),
    );
  }

  Widget _rowMasterData(MasterData listMenu) {
    return InkWell(
      onTap: () => onMenuTap(listMenu.onTap),
      child: Card(
        borderOnForeground: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: listMenu.id == '3' ? 25 : 40,
                top: listMenu.id == '3' ? 15 : 17,
              ),
              child: Text(
                '${listMenu.title}',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: const Color(0xFF332885),
                ),
              ),
            ),
            Align(
              alignment: listMenu.id == '1'
                  ? listMenu.id == '4'
                      ? Alignment.bottomLeft
                      : Alignment.bottomRight
                  : Alignment.bottomCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  '${listMenu.image}',
                  fit: BoxFit.cover,
                  // width: 88,
                  height: 78,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
