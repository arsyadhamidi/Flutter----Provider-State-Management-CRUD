import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter5/api/api_config.dart';
import 'package:flutter5/model/list_model_pekerjaan.dart';
import 'package:flutter5/model/model_pekerjaan.dart';
import 'package:flutter5/network/network_provider.dart';
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

  // Pekerjaan
  int counter = 1;
  bool minus = false;
  List<Map<String, String>> listPekerjaan = [];
  var idmahasiswa;

  FormProvider(String idMahasiswa, String nama, String nohp, String alamat, String pendidikan){
    init(idMahasiswa, nama, nohp, alamat, pendidikan);
  }

  init(String idMahasiswa, String nama, String nohp, String alamat, String pendidikan){
    idmahasiswa = idMahasiswa;
    isNamaCont.text = nama;
    isNoHpCont.text = nohp;
    isAlamatCont.text = alamat;
    selectedValue = pendidikan;


    listDataPekerjaan();
  }

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
    listPekerjaan.add(
        {
          'nama_pekerjaan': isNamaPerkejaanCont.text,
          'lama' : counter.toString(),
        }
    );
    notifyListeners();
  }

  Future<void> listDataPekerjaan() async {
    try{
      final response = await NetworkProvider().getDataPekerjaan(idmahasiswa.toString());
      listPekerjaan = (response.data ?? []).map((e) => {
        'nama_pekerjaan': e.namaPekerjaan ?? '',
        'lama' : e.lama?.toString() ?? '',
      }).toList() ;
      notifyListeners();
    }catch(e){
      print(e);
    }
  }

  Future<void> addMahasiswa(BuildContext context) async{
    final response = await http.post(Uri.parse(ApiConfig.url + "add-mahasiswa"), body: {
      'nama_mahasiswa': isNamaCont.text,
      'nohp_mahasiswa': isNoHpCont.text,
      'alamat_mahasiswa': isAlamatCont.text,
      'pendidikan': selectedData,
      'pekerjaan': jsonEncode(listPekerjaan),
    });

    var addmahasiswa = await jsonDecode(response.body);

    if(addmahasiswa["status"] == 200){
      Navigator.pop(context);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Add Failed")));
    }
  }

  Future<void> updateMahasiswa(BuildContext context) async{
    final response = await http.post(Uri.parse(ApiConfig.url + "update-pekerjaan"), body: {
      'id_mahasiswa': idmahasiswa,
      'nama_mahasiswa': isNamaCont.text,
      'nohp_mahasiswa': isNoHpCont.text,
      'alamat_mahasiswa': isAlamatCont.text,
      'pendidikan': selectedValue,
      'pekerjaan': jsonEncode(listPekerjaan),
    });

    var updatemahasiswa = jsonDecode(response.body);

    if(updatemahasiswa["status"] == 200){
      Navigator.pop(context);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Update Failed")));
    }

  }



}