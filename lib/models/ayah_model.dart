import 'dart:convert';

import 'package:quran_app/models/detail_surah_model.dart';

class AyahModel {
  int? nomorSurah;
  List<Surah>? surah;
  int? nomorAyat;
  String? teksArab;
  String? teksLatin;
  String? teksIndonesia;
  AudioFull? audio;
  Ayat? ayat;
  AyahModel({
    this.nomorSurah,
    this.surah,
    this.nomorAyat,
    this.teksArab,
    this.teksLatin,
    this.teksIndonesia,
    this.audio,
    this.ayat,
  });

  AyahModel.fromJson(Map<String, dynamic> json) {
    nomorSurah = json['nomor'];
    nomorAyat = json['nomorAyat'];
    teksArab = json['teksArab'];
    teksLatin = json['teksLatin'];
    teksIndonesia = json['teksIndonesia'];
    audio = json['audio'] != null
        ? json['audio'] is String
        ? AudioFull.fromJson(jsonDecode(json['audio']))
        : AudioFull.fromJson(json['audio'])
        : null;
    ayat = json['ayat'] != null
        ? json['ayat'] is String
        ? Ayat.fromJson(jsonDecode(json['ayat']))
        : Ayat.fromJson(json['ayat'])
        : null;
    if (json['data'] != null) {
      surah = <Surah>[];
      if (json['data'] is String) {
        jsonDecode(json['data']).forEach((v) {
          surah!.add(Surah.fromJson(v));
        });
      }  else {
        json['data'].forEach((v) {
          surah!.add(Surah.fromJson(v));
        });
      }
    }
  }

  Map<String, dynamic> toJsonLocal() => {
    'nomor': nomorSurah,
    'data': jsonEncode(surah ?? []),
    'nomorAyat': nomorAyat,
    'teksArab': teksArab,
    'teksIndonesia': teksIndonesia,
    'teksLatin': teksLatin,
    'ayat': jsonEncode(ayat),
    'audio': jsonEncode(audio)
  };

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nomorAyat'] = this.nomorAyat;
    data['teksArab'] = this.teksArab;
    data['teksLatin'] = this.teksLatin;
    data['teksIndonesia'] = this.teksIndonesia;
    if (this.audio != null) {
      data['audio'] = this.audio!.toJson();
    }
    if (this.ayat != null) {
      data['ayat'] = this.ayat!.toJson();
    }
    if (this.surah != null) {
      data['data'] = this.surah!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
