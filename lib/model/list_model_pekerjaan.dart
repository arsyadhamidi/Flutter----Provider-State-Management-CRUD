// To parse this JSON data, do
//
//     final listDataPekerjaan = listDataPekerjaanFromJson(jsonString);

import 'dart:convert';

ListModelPekerjaan listModelPekerjaanFromJson(String str) => ListModelPekerjaan.fromJson(json.decode(str));

String listModelPekerjaanToJson(ListModelPekerjaan data) => json.encode(data.toJson());

class ListModelPekerjaan {
  int? status;
  bool? error;
  String? message;
  List<DataPekerjaan>? data;

  ListModelPekerjaan({
    this.status,
    this.error,
    this.message,
    this.data,
  });

  factory ListModelPekerjaan.fromJson(Map<String, dynamic> json) => ListModelPekerjaan(
    status: json["status"],
    error: json["error"],
    message: json["message"],
    data: json["data"] == null ? [] : List<DataPekerjaan>.from(json["data"]!.map((x) => DataPekerjaan.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "error": error,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataPekerjaan {
  int? idPekerjaan;
  String? namaPekerjaan;
  String? lama;
  DateTime? createdAt;
  DateTime? updatedAt;

  DataPekerjaan({
    this.idPekerjaan,
    this.namaPekerjaan,
    this.lama,
    this.createdAt,
    this.updatedAt,
  });

  factory DataPekerjaan.fromJson(Map<String, dynamic> json) => DataPekerjaan(
    idPekerjaan: json["id_pekerjaan"],
    namaPekerjaan: json["nama_pekerjaan"],
    lama: json["lama"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id_pekerjaan": idPekerjaan,
    "nama_pekerjaan": namaPekerjaan,
    "lama": lama,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
