import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter5/form/form_provider.dart';
import 'package:flutter5/model/model_mahasiswa.dart';
import 'package:provider/provider.dart';

class FormPage extends StatefulWidget {

  final bool isUpdate;
  final DataMahasiswa? data;

  FormPage({Key? key, this.isUpdate = false, this.data}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => FormProvider(
            widget.data?.idMahasiswa.toString() ?? '',
            widget.data?.namaMahasiswa ?? '',
            widget.data?.nohpMahasiswa ?? '',
            widget.data?.alamatMahasiswa ?? '',
            widget.data?.pendidikan ?? '',
        ),
        child: Consumer<FormProvider>(
          builder: (context, formProvider, child) {
            return DefaultTabController(
                length: 3,
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    title: Text(
                        widget.data != null ? "Update Form" :
                        "Add Form"
                    ),
                    bottom: TabBar(
                      tabs: [
                        Tab(child: Text("Biodata")),
                        Tab(child: Text("Pendidikan")),
                        Tab(child: Text("Pekerjaan")),
                      ],
                    ),
                  ),
                  body: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: TabBarView(
                      children: [
                        // Form Biodata
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: ListView(
                            children: [
                              Text("Nama"),
                              SizedBox(height: 15),
                              TextFormField(
                                controller: formProvider.isNamaCont,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.withOpacity(0.2),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none)),
                              ),
                              SizedBox(height: 25),
                              Text("No HP"),
                              SizedBox(height: 15),
                              TextFormField(
                                controller: formProvider.isNoHpCont,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.withOpacity(0.2),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none)),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Text("Alamat"),
                              SizedBox(height: 15),
                              TextFormField(
                                controller: formProvider.isAlamatCont,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.withOpacity(0.2),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none)),
                              ),
                            ],
                          ),
                        ),

                        // Form Pendidikan
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Pendidikan Terakhir"),
                              SizedBox(height: 15),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: (DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      hint: Text(
                                        'Select Pendidikan',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      items: formProvider.items
                                          .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                          .toList(),
                                      value: widget.data != null ? formProvider.selectedValue : formProvider.selectedData,
                                      onChanged: (value) {
                                        setState(() {
                                          if(widget.data != null){
                                            formProvider.selectedValue = value;
                                          }else{
                                            formProvider.selectedData = value;
                                          }
                                        });
                                      },
                                      buttonStyleData: const ButtonStyleData(
                                        height: 40,
                                        width: 140,
                                      ),
                                      menuItemStyleData: const MenuItemStyleData(
                                        height: 40,
                                      ),
                                    ),
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),

                        // Form Pekerjaan
                        Scaffold(
                          body: Padding(
                            padding: EdgeInsets.all(20),
                            child: ListView(
                              children: [
                                Container(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: formProvider.listPekerjaan.length ?? 0,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          child: ListTile(
                                            title: Row(
                                              children: [
                                                Text(formProvider.listPekerjaan[index]["nama_pekerjaan"] ?? ''),
                                                SizedBox(width: 10),
                                                Text(
                                                  "${formProvider.listPekerjaan[index]["lama"] ?? ''} Tahun",
                                                  style: TextStyle(color: Colors.grey),
                                                )
                                              ],
                                            ),
                                            trailing: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  formProvider.listPekerjaan.removeAt(index);
                                                });
                                              },
                                              icon: Icon(Icons.close),
                                            ),
                                          ),
                                        );
                                      },
                                  ),
                                ),
                                SizedBox(height: 20),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Nama Pekerjaan"),
                                        SizedBox(height: 10),
                                        TextFormField(
                                          controller: formProvider.isNamaPerkejaanCont,
                                          decoration: InputDecoration(
                                              fillColor: Colors.grey.withOpacity(0.2),
                                              filled: true,
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                  borderSide: BorderSide.none)),
                                        ),
                                        SizedBox(height: 15),
                                        Text("Lama (Tahun)"),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Text("${formProvider.counter}", style: TextStyle(fontSize: 20),),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            MaterialButton(
                                              onPressed: () {
                                                formProvider.minIncrements();
                                              },
                                              height: 50,
                                              shape: OutlineInputBorder(
                                                borderSide:
                                                BorderSide(color: Colors.grey),
                                              ),
                                              child: Icon(Icons.remove),
                                            ),
                                            SizedBox(width: 10),
                                            MaterialButton(
                                              onPressed: () {
                                                formProvider.addIncrements();
                                              },
                                              height: 50,
                                              shape: OutlineInputBorder(
                                                borderSide:
                                                BorderSide(color: Colors.grey),
                                              ),
                                              child: Icon(Icons.add),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        MaterialButton(
                                          onPressed: () {
                                            formProvider.addDataPekerjaan(context);
                                          },
                                          color: Colors.blue,
                                          height: 50,
                                          minWidth: double.infinity,
                                          child: Text(widget.data != null ? "Update" :
                                            "Tambah",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          bottomNavigationBar: Padding(
                            padding: const EdgeInsets.all(20),
                            child: MaterialButton(
                              onPressed: () async {
                                widget.data != null
                                    ? formProvider.updateMahasiswa(context)
                                    : await formProvider.addMahasiswa(context);
                              },
                              color: Colors.blue,
                              height: 65,
                              child: Text(widget.data != null ? "Update Data" :
                                "SIMPAN",
                                style: TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          },
        ),
    );
  }
}
