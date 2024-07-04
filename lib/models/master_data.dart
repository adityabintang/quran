import 'package:flutter/material.dart';

class MasterData {
  String? id;
  String? image;
  IconData? icon;
  Color? color;
  String? title;
  Function? onTap;

  MasterData({
    this.id,
    this.image,
    this.icon,
    this.title,
    this.color,
    this.onTap,
  });
}