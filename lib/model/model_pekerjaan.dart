// To parse this JSON data, do
//
//     final modelPekerjaan = modelPekerjaanFromJson(jsonString);

import 'dart:convert';

ModelPekerjaan modelPekerjaanFromJson(String str) => ModelPekerjaan.fromJson(json.decode(str));

String modelPekerjaanToJson(ModelPekerjaan data) => json.encode(data.toJson());

class ModelPekerjaan {
  int? status;
  bool? error;
  String? message;
  Data? data;

  ModelPekerjaan({
    this.status,
    this.error,
    this.message,
    this.data,
  });

  factory ModelPekerjaan.fromJson(Map<String, dynamic> json) => ModelPekerjaan(
    status: json["status"],
    error: json["error"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "error": error,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  String? namaPekerjaan;
  String? lama;

  Data({
    this.namaPekerjaan,
    this.lama,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    namaPekerjaan: json["nama_pekerjaan"],
    lama: json["lama"],
  );

  Map<String, dynamic> toJson() => {
    "nama_pekerjaan": namaPekerjaan,
    "lama": lama,
  };
}
