// To parse this JSON data, do
//
//     final listModelMahasiswa = listModelMahasiswaFromJson(jsonString);

import 'dart:convert';

ListModelMahasiswa listModelMahasiswaFromJson(String str) => ListModelMahasiswa.fromJson(json.decode(str));

String listModelMahasiswaToJson(ListModelMahasiswa data) => json.encode(data.toJson());

class ListModelMahasiswa {
  int? status;
  bool? error;
  String? message;
  List<DataMahasiswa>? data;

  ListModelMahasiswa({
    this.status,
    this.error,
    this.message,
    this.data,
  });

  factory ListModelMahasiswa.fromJson(Map<String, dynamic> json) => ListModelMahasiswa(
    status: json["status"],
    error: json["error"],
    message: json["message"],
    data: json["data"] == null ? [] : List<DataMahasiswa>.from(json["data"]!.map((x) => DataMahasiswa.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "error": error,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataMahasiswa {
  int? idMahasiswa;
  String? namaMahasiswa;
  String? nohpMahasiswa;
  String? alamatMahasiswa;
  String? pendidikan;
  DateTime? createdAt;
  DateTime? updatedAt;

  DataMahasiswa({
    this.idMahasiswa,
    this.namaMahasiswa,
    this.nohpMahasiswa,
    this.alamatMahasiswa,
    this.pendidikan,
    this.createdAt,
    this.updatedAt,
  });

  factory DataMahasiswa.fromJson(Map<String, dynamic> json) => DataMahasiswa(
    idMahasiswa: json["id_mahasiswa"],
    namaMahasiswa: json["nama_mahasiswa"],
    nohpMahasiswa: json["nohp_mahasiswa"],
    alamatMahasiswa: json["alamat_mahasiswa"],
    pendidikan: json["pendidikan"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id_mahasiswa": idMahasiswa,
    "nama_mahasiswa": namaMahasiswa,
    "nohp_mahasiswa": nohpMahasiswa,
    "alamat_mahasiswa": alamatMahasiswa,
    "pendidikan": pendidikan,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
