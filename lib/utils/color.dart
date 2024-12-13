// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

class MyColors {
  static Color backgroundApp = const Color(0xFFfafafa);
  static Color toolBarApp = const Color(0xFFf8f8f8);
  static Color statusBarApp = const Color(0xFFe5e5e5);
  // static Color statusBarApp = const Color(0xFFbbbbbb);
  static Color appPrimaryColor = const Color(0xFFFA6F1E);
  static Color appPrimaryColor2 = const Color(0xFFF06210);
  static Color appPrimaryText = const Color(0xFF5f6368);
  static Color appPrimaryText2 = const Color(0xFF767676);
  static Color snackbarColor = const Color(0xFF2c2c2c);
  static Color starRatingColor = const Color(0xFFFBC02B);
  static Color loginBGColor = const Color(0xFF299cd8);
  static Color loginButtonColor = const Color(0xFF162950);
  static Color shimmerBaseColor = const Color(0xFFe5e5e5);
  static Color shimmerHighlisghtColor = const Color(0xFFededed);
  static Color hintColor = Color(0xFFBBBBBB);
  static Color success = const Color(0xFF2ecc71);
  static Color green = const Color(0xFF18D191);
  static Color pink = const Color(0xFFFD7384);
  static Color orange = const Color(0XFFFC7B4D);
  static Color blue = const Color(0XFF53CEDB);
  static Color yellow = const Color(0XFFF1B069);
  static Color kTextColor = Color(0xFF202E2E);
  static Color kTextLigntColor = Color(0xFF7286A5);
  static Color kPrimaryLightColor = Color(0xFFF1E6FF);
  static Color kShadowColor = Color(0xFFE6E6E6);
  static Color kWhite = Color(0xFFfcfcfc);

  static Color test = Colors.grey;

  static Color black = const Color(0xFF2c292a);
  static Color white = const Color(0xFFfcfcfc);
  static Color lightBlue = const Color(0xFF00C6FF);
  static Color grey = const Color(0xFFf2f2f2);
  static Color grey100 = const Color(0xFFF5F5F5);
  static Color grey200 = const Color(0xFFEEEEEE);
  static Color grey300 = const Color(0xFFE0E0E0);
  static Color chipOrange = const Color(0x50FFD180);
  static Color appBarMenu = const Color(0xFF616161);
  static Color menuRide = const Color(0xffe99e1e);
  static Color menuCar = const Color(0xff14639e);
  static Color menuBluebird = const Color(0xff2da5d9);
  static Color menuFood = const Color(0xffec1d27);
  static Color menuSend = const Color(0xff8dc53e);
  static Color menuDeals = const Color(0xfff43f24);
  static Color menuPulsa = const Color(0xff72d2a2);
  static Color menuOther = const Color(0xffa6a6a6);
  static Color menuShop = const Color(0xff0b945e);
  static Color menuMart = const Color(0xff68a9e3);
  static Color menuTix = const Color(0xffe86f16);

  static Color mail = const Color(0xFF34465d);
  static Color whatsapp = const Color(0xFF25D366);
  static Color fb = const Color(0xFF3b5999);
  static Color google = const Color(0xFFdd4b39);
  static Color twitter = const Color(0xFF55acee);

  static List<Color> randomColorList = const [
    Color(0xFFf19066),
    Color(0xFFf5cd79),
    Color(0xFF546de5),
    Color(0xFFe15f41),
    Color(0xFFc44569),
    Color(0xFF574b90),
    Color(0xFFf78fb3),
    Color(0xFF3dc1d3),
    Color(0xFFe66767),
    Color(0xFF303952),
    Color(0xFFf3814d),
    Color(0xFFf7d794),
    Color(0xFF778beb),
    Color(0xFFe77f67),
    Color(0xFFcf6a87),
    Color(0xFF786fa6),
    Color(0xFFf8a5c2),
    Color(0xFF63cdda),
    Color(0xFFea8685),
    Color(0xFF596275),
  ];

  static Color getRandomColor(int val) {
    // print("randomColorList length: " + randomColorList.length.toString());
    // print("val: $val");
    var colors = randomColorList.length;
    var index = 0;
    if (val <= randomColorList.length) {
      index = colors - val;
    } else if (val <= randomColorList.length * 2) {
      index = colors * 2 - val;
    } else if (val <= randomColorList.length * 3) {
      index = colors * 3 - val;
    } else if (val <= randomColorList.length * 4) {
      index = colors * 4 - val;
    } else {
      index = val % randomColorList.length;
    }
    // index = val % randomColorList.length;
    // print(index);
    return randomColorList[index];
  }
}

List<Color> menuColors = [
  MyColors.green,
  MyColors.orange,
  MyColors.pink,
  MyColors.blue,
  MyColors.menuDeals,
];
