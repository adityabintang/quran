import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/widget/text_field_container.dart';

import '../utils/color.dart';

class SearchBox extends StatefulWidget {
  final String? hintText;
  final IconData? icon, prefixIcon, suffixIcon;
  final Color? iconColor;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final Function()? onClear;
  final String? initValue;
  final Color? backGroundColor;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final InputBorder? border;
  const SearchBox({
    super.key,
    this.hintText,
    this.icon,
    this.iconColor,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.initValue,
    this.backGroundColor,
    this.keyboardType,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.border,
  });

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  // bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    // widget.controller?.addListener(() {
    //   setState(() {
    //     _showClearButton = widget.controller!.text.isNotEmpty;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      color: widget.backGroundColor ?? MyColors.grey,
      child: TextField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        keyboardType: widget.keyboardType ?? TextInputType.text,
        // cursorColor: MyColors.appPrimaryColor,
        decoration: InputDecoration(
          icon: widget.icon != null
              ? Icon(
                  widget.icon,
                  color: widget.iconColor ?? MyColors.appPrimaryColor,
                )
              : null,
          // labelText: hintText,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: const Color(0xFF332885).withOpacity(0.5),
          ),
          // suffixIcon: _getClearButton(),
          suffixIcon: widget.suffixIcon != null
              ? Icon(
                  widget.suffixIcon,
                  color: widget.iconColor ?? MyColors.appPrimaryColor,
                )
              : null,
          prefixIcon: widget.prefixIcon != null
              ? Icon(
                  widget.prefixIcon,
                  color: widget.iconColor ?? MyColors.appPrimaryColor,
                )
              : null,
          border: widget.border,
        ),
      ),
    );
  }

  // Widget? _getClearButton() {
  //   if (!_showClearButton) {
  //     return null;
  //   }
  //
  //   return IconButton(
  //     onPressed: widget.onClear,
  //     icon: const Icon(Icons.clear),
  //   );
  // }
}
