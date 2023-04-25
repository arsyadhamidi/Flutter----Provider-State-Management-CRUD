// To parse this JSON data, do
//
//     final modelMahasiswa = modelMahasiswaFromJson(jsonString);

import 'dart:convert';

List<ModelMahasiswa> modelMahasiswaFromJson(String str) => List<ModelMahasiswa>.from(json.decode(str).map((x) => ModelMahasiswa.fromJson(x)));

String modelMahasiswaToJson(List<ModelMahasiswa> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelMahasiswa {
  ModelMahasiswa({
    this.the0,
    this.the1,
    this.the2,
    this.the3,
    this.the4,
    this.the5,
    this.the6,
    this.the7,
    this.the8,
    this.the9,
    this.idMahasiswa,
    this.nama,
    this.nohp,
    this.alamat,
    this.pendidikan,
    this.pekerjaanId,
    this.idPekerjaan,
    this.kodePekerjaan,
    this.namaPekerjaan,
    this.lama,
  });

  String? the0;
  String? the1;
  String? the2;
  String? the3;
  String? the4;
  String? the5;
  String? the6;
  String? the7;
  String? the8;
  String? the9;
  String? idMahasiswa;
  String? nama;
  String? nohp;
  String? alamat;
  String? pendidikan;
  String? pekerjaanId;
  String? idPekerjaan;
  String? kodePekerjaan;
  String? namaPekerjaan;
  String? lama;

  factory ModelMahasiswa.fromJson(Map<String, dynamic> json) => ModelMahasiswa(
    the0: json["0"],
    the1: json["1"],
    the2: json["2"],
    the3: json["3"],
    the4: json["4"],
    the5: json["5"],
    the6: json["6"],
    the7: json["7"],
    the8: json["8"],
    the9: json["9"],
    idMahasiswa: json["id_mahasiswa"],
    nama: json["nama"],
    nohp: json["nohp"],
    alamat: json["alamat"],
    pendidikan: json["pendidikan"],
    pekerjaanId: json["pekerjaan_id"],
    idPekerjaan: json["id_pekerjaan"],
    kodePekerjaan: json["kode_pekerjaan"],
    namaPekerjaan: json["nama_pekerjaan"],
    lama: json["lama"],
  );

  Map<String, dynamic> toJson() => {
    "0": the0,
    "1": the1,
    "2": the2,
    "3": the3,
    "4": the4,
    "5": the5,
    "6": the6,
    "7": the7,
    "8": the8,
    "9": the9,
    "id_mahasiswa": idMahasiswa,
    "nama": nama,
    "nohp": nohp,
    "alamat": alamat,
    "pendidikan": pendidikan,
    "pekerjaan_id": pekerjaanId,
    "id_pekerjaan": idPekerjaan,
    "kode_pekerjaan": kodePekerjaan,
    "nama_pekerjaan": namaPekerjaan,
    "lama": lama,
  };
}
