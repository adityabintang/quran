class DoaModel {
  int? id;
  String? judul;
  String? latin;
  String? arab;
  String? terjemah;

  DoaModel({this.id, this.judul, this.latin, this.arab, this.terjemah});

  DoaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    judul = json['judul'];
    latin = json['latin'];
    arab = json['arab'];
    terjemah = json['terjemah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['judul'] = this.judul;
    data['latin'] = this.latin;
    data['arab'] = this.arab;
    data['terjemah'] = this.terjemah;
    return data;
  }
}
