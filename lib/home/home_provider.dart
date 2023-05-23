import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter5/api/api_config.dart';
import 'package:flutter5/model/model_mahasiswa.dart';
import 'package:flutter5/network/network_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  List<DataMahasiswa>? listMahasiswa;
  bool isLoading = true;

  HomeProvider() {
    init();
  }

  init() {
    listDataMahasiswa();
  }

  Future<void> listDataMahasiswa() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await NetworkProvider().getDataMahasiswa();
      Future.delayed(Duration(seconds: 3), () {
        isLoading = false;
        listMahasiswa = response.data ?? [];
        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteDataMahasiswa(
      BuildContext context, String idMahasiswa) async {
    final response = await http.post(
        Uri.parse(ApiConfig.url + "delete-mahasiswa"),
        body: {"id_mahasiswa": idMahasiswa});
    await jsonDecode(response.body);
    notifyListeners();
  }
}
