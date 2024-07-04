import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/models/doa_model.dart';
import 'package:quran_app/models/error_model.dart';
import 'package:http/http.dart' as http;
import 'package:quran_app/utils/constants.dart';

class DoaRepository {
  Future<Either<ErrorModel, List<DoaModel>?>> fetchDoa() async {
    final response = await http.get(
      Uri.parse(daftarDoa),
    );
    debugPrint(daftarDoa);

    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      final data = res as List;
      return right(data.map((rawPost) {
        return DoaModel.fromJson(rawPost);
      }).toList());
    } else {
      throw left(ErrorModel.fromJson(json.decode(response.body)));
    }
  }
}
