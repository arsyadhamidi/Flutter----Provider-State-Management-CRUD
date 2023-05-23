import 'package:flutter5/api/api_config.dart';
import 'package:flutter5/model/model_mahasiswa.dart';
import 'package:flutter5/model/list_model_pekerjaan.dart';
import 'package:http/http.dart' as http;

class NetworkProvider{
  
  Future<ListModelPekerjaan> getDataPekerjaan(String idMahasiswa) async{
    final response = await http.post(Uri.parse(ApiConfig.url + "get-pekerjaan"), body: {
      'id_mahasiswa': idMahasiswa
    });

    ListModelPekerjaan datapekerjaan = listModelPekerjaanFromJson(response.body);
    return datapekerjaan;
  }

  Future<ListModelMahasiswa> getDataMahasiswa() async{
    final response = await http.get(Uri.parse(ApiConfig.url + "get-mahasiswa"));

    ListModelMahasiswa getMahasiswa = listModelMahasiswaFromJson(response.body);
    return getMahasiswa;
  }
  
}