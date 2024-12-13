import 'package:flutter/material.dart';
import 'package:quran_app/widget/search.dart';

import '../../../utils/color.dart';

class SearchBoxComponent extends StatelessWidget {
  final TextEditingController? searchController;
  final Function(String)? onSearching;
  final void Function()? onClear;
  final String? sortQuery;
  final String? hintText;

  const SearchBoxComponent({
    super.key,
    @required this.searchController,
    @required this.onSearching,
    @required this.onClear,
    this.sortQuery,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return SearchBox(
      hintText: hintText,
      controller: searchController,
      onSubmitted: (text) => onSearching?.call(text),
      suffixIcon: Icons.search,
      iconColor: const Color(0xFF332885).withOpacity(0.5),
      keyboardType: TextInputType.text,
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: MyColors.grey100,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20)
      ),
      onClear: onClear,
    );
  }
}
