import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:quran_app/models/error_model.dart';
import 'package:quran_app/models/surah_model.dart';
import 'package:http/http.dart' as http;
import 'package:quran_app/utils/constants.dart';

class SurahRepository {
  Future<Either<ErrorModel, SurahModel>> getSurah() async {
    final response = await http.get(
      Uri.parse(daftarSurat),
    );
    debugPrint(daftarSurat);

    if (response.statusCode == 200) {
      return right(SurahModel.fromJson(json.decode(response.body)));
    } else {
      throw left(ErrorModel.fromJson(json.decode(response.body)));
    }
  }
}
