import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/models/error_model.dart';
import 'package:http/http.dart' as http;
import 'package:quran_app/utils/constants.dart';

import '../../models/detail_surah_model.dart';

class DetailSurahRepository {
  Future<Either<ErrorModel, DetailSurahModel>> getDetailSurah(int? numberSurah) async {
    final response = await http.get(
      Uri.parse('$detailSurah/$numberSurah'),
    );
    debugPrint('$detailSurah/$numberSurah');

    if (response.statusCode == 200) {
      return right(DetailSurahModel.fromJson(json.decode(response.body)));
    } else {
      throw left(ErrorModel.fromJson(json.decode(response.body)));
    }
  }
}
