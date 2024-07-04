import 'package:flutter/material.dart';
import 'package:quran_app/models/master_data.dart';
import 'package:quran_app/ui/doa/doa_page.dart';
import 'package:quran_app/ui/xroot/root_page.dart';

class Menus {
  goQuranPage(BuildContext context) {
    // debugPrint('Quran');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const RootPage(
          tabIndex: 1,
        ),
      ),
    );
  }

  goDoaPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const DoaPage(),
      ),
    );
  }

  goSholawatPage() {
    debugPrint('Sholawat');
  }

  List<MasterData> buildMenus(BuildContext context) {
    List<MasterData> masterDataList = [];

    masterDataList.add(MasterData(
      id: '1',
      icon: Icons.card_travel,
      image: "assets/quran.png",
      // color: MyColors.green,
      title: "Quran",
      onTap: () => goQuranPage(context),
    ));

    masterDataList.add(MasterData(
      id: '2',
      icon: Icons.card_travel,
      image: "assets/doa.png",
      // color: MyColors.green,
      title: "Doa",
      onTap: () => goDoaPage(context),
    ));

    masterDataList.add(MasterData(
      id: '3',
      icon: Icons.card_travel,
      image: "assets/sholawat.png",
      // color: MyColors.green,
      title: "Sholawat",
      onTap: goSholawatPage,
    ));

    return masterDataList;
  }

  List<MasterData> buildMenusV2() {
    List<MasterData> masterDataList = [];

    masterDataList.add(MasterData(
      id: '4',
      icon: Icons.card_travel,
      image: "assets/asmaul_husna.png",
      // color: MyColors.green,
      title: "Asmaul Husna",
      onTap: goQuranPage,
    ));

    masterDataList.add(MasterData(
      id: '5',
      icon: Icons.card_travel,
      image: "assets/sholat.png",
      // color: MyColors.green,
      title: "Jadwal Sholat",
      onTap: goDoaPage,
    ));

    return masterDataList;
  }
}
