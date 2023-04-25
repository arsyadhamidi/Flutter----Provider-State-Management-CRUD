import 'package:flutter5/api/api_config.dart';
import 'package:flutter5/model/modelmahasiswa.dart';
import 'package:flutter5/model/modelpekerjaan.dart';
import 'package:http/http.dart' as http;

class NetworkProvider{
  
  Future<List<ModelPekerjaan>?> getDataPekerjaan() async{
    final response = await http.get(Uri.parse(ApiConfig.url + "listpekerjaan.php"));

    List<ModelPekerjaan> datapekerjaan = modelPekerjaanFromJson(response.body);
    return datapekerjaan;
  }

  Future<List<ModelMahasiswa>?> getDataMahasiswa() async{
    final response = await http.get(Uri.parse(ApiConfig.url + "listmahasiswa.php"));

    List<ModelMahasiswa> datamahasiswa = modelMahasiswaFromJson(response.body);
    return datamahasiswa;
  }
  
}