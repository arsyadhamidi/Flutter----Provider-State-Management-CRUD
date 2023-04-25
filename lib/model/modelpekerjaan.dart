// To parse this JSON data, do
//
//     final modelPekerjaan = modelPekerjaanFromJson(jsonString);

import 'dart:convert';

List<ModelPekerjaan> modelPekerjaanFromJson(String str) => List<ModelPekerjaan>.from(json.decode(str).map((x) => ModelPekerjaan.fromJson(x)));

String modelPekerjaanToJson(List<ModelPekerjaan> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelPekerjaan {
  ModelPekerjaan({
    this.the0,
    this.the1,
    this.the2,
    this.idPekerjaan,
    this.namaPekerjaan,
    this.lama,
  });

  String? the0;
  String? the1;
  String? the2;
  String? idPekerjaan;
  String? namaPekerjaan;
  String? lama;

  factory ModelPekerjaan.fromJson(Map<String, dynamic> json) => ModelPekerjaan(
    the0: json["0"],
    the1: json["1"],
    the2: json["2"],
    idPekerjaan: json["id_pekerjaan"],
    namaPekerjaan: json["nama_pekerjaan"],
    lama: json["lama"],
  );

  Map<String, dynamic> toJson() => {
    "0": the0,
    "1": the1,
    "2": the2,
    "id_pekerjaan": idPekerjaan,
    "nama_pekerjaan": namaPekerjaan,
    "lama": lama,
  };
}
