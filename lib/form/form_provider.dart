import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter5/api/api_config.dart';
import 'package:flutter5/model/modelpekerjaan.dart';
import 'package:flutter5/network/network.dart';
import 'package:http/http.dart' as http;

class FormProvider extends ChangeNotifier{

  TextEditingController isNamaCont = TextEditingController();
  TextEditingController isNoHpCont = TextEditingController();
  TextEditingController isAlamatCont = TextEditingController();
  TextEditingController isNamaPerkejaanCont = TextEditingController();

  // Pendidikan
  String? selectedValue;
  String? selectedData;
  final List<String> items = [
    'SLTA / MA / SMK',
    'SLTP/MTs',
    'SDN / MIN',
    'Tidak Sekolah',
  ];

  FormProvider(String nama, String nohp, String alamat, String pendidikan){
    init(nama, nohp, alamat, pendidikan);
  }

  init(String nama, String nohp, String alamat, String pendidikan){
    if(nama != null || nohp != null || alamat != null || pendidikan != null){
      isNamaCont.text = nama;
      isNoHpCont.text = nohp;
      isAlamatCont.text = alamat;
      selectedValue = pendidikan;
    }


    listDataPekerjaan();
  }

  // Pekerjaan
  int counter = 1;
  bool minus = false;

  void addIncrements(){
    counter++;
    minus = false;
    notifyListeners();
  }

  void minIncrements(){
    if(counter == 1){
      minus = true;
    }else{
      minus = false;
      counter--;
    }
    notifyListeners();
  }

  Future<void> addDataPekerjaan(BuildContext context) async{
    final response = await http.post(Uri.parse(ApiConfig.url + "addpekerjaan.php"), body: {
      'nama_pekerjaan': isNamaPerkejaanCont.text,
      'lama': counter.toString(),
    });

    var addpekerjaan = jsonDecode(response.body);

    if(addpekerjaan != null){
      listDataPekerjaan();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text("Add Data Pekerjaan Successfully!", style: TextStyle(color: Colors.white),)));
      notifyListeners();
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("Add Data Pekerjaan Failed!", style: TextStyle(color: Colors.white),)));
      notifyListeners();
    }

    notifyListeners();

  }

  List<ModelPekerjaan>? listPekerjaan;

  Future<List<ModelPekerjaan>?> listDataPekerjaan() async {
    try{
      final response = await NetworkProvider().getDataPekerjaan();
      listPekerjaan = response;
      notifyListeners();
    }catch(e){
      print(e);
    }
  }


  Future<List<ModelPekerjaan>?> deleteDataPekerjaan(BuildContext context, String id_pekerjaan) async{
    try{
      final response = await http.post(Uri.parse(ApiConfig.url + "deletepekerjaan.php"), body: {
        'id_pekerjaan': id_pekerjaan,
      });
      List<ModelPekerjaan> deletepekerjaan = modelPekerjaanFromJson(response.body);
      if(deletepekerjaan != null){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text("Delete Data Pekerjaan Successfully!", style: TextStyle(color: Colors.white),)));
        return deletepekerjaan;
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text("Delete Data Pekerjaan Failed!", style: TextStyle(color: Colors.white),)));
      }
    }catch(e){
      print(e);
    }
  }


  Future<void> addDataMahasiswa(BuildContext context) async{
    try{
      final response = await http.post(Uri.parse(ApiConfig.url + "addmahasiswa.php"), body: {
        'nama': isNamaCont.text,
        'nohp': isNoHpCont.text,
        'alamat': isAlamatCont.text,
        'pendidikan': selectedData,
      });
      var addMahasiswa = await json.decode(json.encode(response.body));
      print(response.body);
      if(addMahasiswa != Null){
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text("Add Mahasiswa Successfully!", style: TextStyle(color: Colors.white),)));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text("Add Mahasiswa Failed!", style: TextStyle(color: Colors.white),)));
      }
      notifyListeners();
    }catch(e){
      print(e);
    }
  }


  Future<void> updateDataMahasiswa(BuildContext context, String id) async{
    try{
      final response = await http.post(Uri.parse(ApiConfig.url + "updatemahasiswa.php"), body: {
        'id_mahasiswa': id,
        'nama': isNamaCont.text,
        'nohp': isNoHpCont.text,
        'alamat': isAlamatCont.text,
        'pendidikan': selectedValue,
      });

      print(response.body);

      var updateMahasiswa = await json.decode(json.encode(response.body));

      if(updateMahasiswa != null){
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text("Update Data Mahasiswa Successfully!", style: TextStyle(color: Colors.white),)));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text("Update Data Mahasiswa Failed!", style: TextStyle(color: Colors.white),)));
      }

      notifyListeners();
    }catch(e){
      print(e);
    }
  }

}