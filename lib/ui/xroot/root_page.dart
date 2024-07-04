import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_app/ui/home/home.dart';
import 'package:quran_app/ui/quran/quran_page.dart';

class RootPage extends StatefulWidget {
  final int? tabIndex;

  const RootPage({super.key, this.tabIndex});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  DateTime currentBackPressTime = DateTime.now();
  List<Widget> pages = [];
  Widget? currentPage;
  int currentTabIndex = 0;
  final Key keyTab1 = const PageStorageKey('tab1');
  final Key keyTab2 = const PageStorageKey('tab2');
  final Key keyTab3 = const PageStorageKey('tab3');
  final Key keyTab4 = const PageStorageKey('tab4');

  final PageStorageBucket bucket = PageStorageBucket();

  HomePage tab1 = const HomePage();
  QuranPage tab2 = const QuranPage();
  Container tab3 = Container();
  Container tab4 = Container();

  // Future<bool?> _showBackDialog() {
  //   return showDialog<bool>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Are you sure?'),
  //         content: const Text(
  //           'Are you sure you want to leave this page?',
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             style: TextButton.styleFrom(
  //               textStyle: Theme.of(context).textTheme.labelLarge,
  //             ),
  //             child: const Text('Nevermind'),
  //             onPressed: () {
  //               Navigator.pop(context, false);
  //             },
  //           ),
  //           TextButton(
  //             style: TextButton.styleFrom(
  //               textStyle: Theme.of(context).textTheme.labelLarge,
  //             ),
  //             child: const Text('Leave'),
  //             onPressed: () {
  //               SystemNavigator.pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  Widget _buildBottomNavigationBar() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      child: BottomNavigationBar(
        elevation: 10,
        backgroundColor: CupertinoColors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentTabIndex,
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
            // currentPage = pages[index];
          });
        },
        items: const [
          BottomNavigationBarItem(
            activeIcon: ImageIcon(
              AssetImage('assets/home_active.png'),
              color: Color(0xFF332885),
              size: 22,
            ),
            icon: ImageIcon(
              AssetImage('assets/home.png'),
              color: Colors.grey,
              size: 22,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            activeIcon: ImageIcon(
              AssetImage('assets/ic_quran_active.png'),
              color: Color(0xFF332885),
              size: 22,
            ),
            icon: ImageIcon(
              AssetImage('assets/ic_quran.png'),
              color: Colors.grey,
              size: 22,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            activeIcon: ImageIcon(
              AssetImage('assets/clock_active.png'),
              color: Color(0xFF332885),
              size: 22,
            ),
            icon: ImageIcon(
              AssetImage('assets/clock.png'),
              color: Colors.grey,
              size: 22,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            activeIcon: ImageIcon(
              AssetImage('assets/user.png'),
              color: Color(0xFF332885),
              size: 22,
            ),
            icon: ImageIcon(
              AssetImage('assets/user.png'),
              color: Colors.grey,
              size: 22,
            ),
            label: "",
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tab1 = HomePage(
      key: keyTab1,
    );

    tab2 = QuranPage(
      key: keyTab2,
    );
    tab3 = Container(
      key: keyTab3,
    );
    tab4 = Container(
      key: keyTab4,
    );

    pages = [tab1, tab2, tab3, tab4];
    currentPage = tab1;
    if (widget.tabIndex != null) {
      setState(() {
        currentTabIndex = widget.tabIndex ?? 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (didPop) {
            return;
          }
          // final bool shouldPop = await _showBackDialog() ?? false;
          if (context.mounted) {
            SystemNavigator.pop();
          }
        },
        child: pages[currentTabIndex],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
