import 'package:flutter/material.dart';
import 'package:flutter5/form/form_page.dart';
import 'package:flutter5/home/home_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text("Provider State Management"),
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: homeProvider.isLoading == true
                      ? Center(child: CircularProgressIndicator())
                      : homeProvider.listMahasiswa!.isEmpty
                          ? Center(child: Text("No Data"))
                          : ListView.builder(
                              itemCount: homeProvider.listMahasiswa?.length ?? 0,
                              itemBuilder: (context, index) {
                                return Card(
                                  shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Colors.blue)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: ListTile(
                                      onTap: () async{
                                         await Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => FormPage(
                                              isUpdate: true,
                                              data: homeProvider.listMahasiswa?[index]
                                            )));
                                         setState(() {
                                           homeProvider.listDataMahasiswa();
                                         });
                                      },
                                      title: Text(
                                        homeProvider.listMahasiswa?[index].namaMahasiswa ??
                                            '',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(homeProvider
                                              .listMahasiswa?[index].nohpMahasiswa ??
                                              ''),
                                          Text(homeProvider
                                              .listMahasiswa?[index].alamatMahasiswa ??
                                              ''),
                                          Text(homeProvider.listMahasiswa?[index]
                                              .pendidikan ??
                                              ''),
                                        ],
                                      ),
                                      trailing: IconButton(
                                          onPressed: () {
                                             homeProvider.deleteDataMahasiswa(
                                                context,
                                                homeProvider.listMahasiswa?[index]
                                                    .idMahasiswa
                                                    .toString() ??
                                                    '');
                                             homeProvider.listDataMahasiswa();
                                          },
                                          icon: Icon(Icons.delete)),
                                    ),
                                  ),
                                );
                              },
                            )
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FormPage(
                      isUpdate: false,
                    )));
                setState(() {
                  homeProvider.listDataMahasiswa();
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
