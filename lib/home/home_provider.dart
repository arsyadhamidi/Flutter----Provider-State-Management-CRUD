import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter5/api/api_config.dart';
import 'package:flutter5/model/modelmahasiswa.dart';
import 'package:flutter5/model/modelpekerjaan.dart';
import 'package:flutter5/network/network.dart';
import 'package:http/http.dart' as http;

class HomeProvider extends ChangeNotifier{

  List<ModelMahasiswa>? listMahasiswa;
  bool isLoading = true;

  HomeProvider(){
    init();
  }

  init(){
    listDataMahasiswa();
  }

  Future<List<ModelMahasiswa>?> listDataMahasiswa() async{

    isLoading = true;
    notifyListeners();

    try{
      final response = await NetworkProvider().getDataMahasiswa();
      Future.delayed(Duration(seconds: 3), () {
        isLoading = false;
        listMahasiswa = response;
        notifyListeners();
      });

    }catch(e){
      print(e);
    }

  }


  Future<List<ModelMahasiswa>?> deleteDataMahasiswa(BuildContext context, String id_mahasiswa) async{

    try{
      final response = await http.post(Uri.parse(ApiConfig.url + "deletemahasiswa.php"), body: {
        'id_mahasiswa': id_mahasiswa
      });
      List<ModelMahasiswa> delMahasiswa = modelMahasiswaFromJson(response.body);
      if(delMahasiswa != null){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text("Delete Data Mahasiswa Successfully"))
        );
        notifyListeners();
        return delMahasiswa;
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text("Delete Data Mahasiswa Failed"))
        );
      }
    }catch(e){
      print(e);
    }

  }



}