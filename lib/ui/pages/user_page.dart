part of 'pages.dart';

List<Patient> listPatient = [];

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Data Pasien",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              })
        ],
      ),
      body: FutureBuilder(
          future: Hive.openBox<Patient>(boxName),
          // ignore: missing_return
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error),
                );
              } else {
                Box<Patient> patientsBox = Hive.box<Patient>(boxName);
                if (patientsBox.length == 0) {
                  patientsBox.add(Patient("Anwar Amir", 52, "Pria",
                      "Tubercolosis", "RSUP H. Adam Malik"));
                  patientsBox.add(Patient("Eric S H Manurung", 36, "Pria",
                      "Tubercolosis", "RSUP H. Adam Malik"));
                  patientsBox.add(Patient("Marlina Panggabean", 49, "Wanita",
                      "Tubercolosis", "RSUP H. Adam Malik"));
                  patientsBox.add(Patient("Sahrani", 50, "Wanita",
                      "Tubercolosis", "RSU Haji Medan"));
                  patientsBox.add(Patient("Mustiono", 54, "Pria",
                      "Tubercolosis", "RSU Haji Medan"));
                }
                return ValueListenableBuilder(
                    valueListenable: patientsBox.listenable(),
                    builder: (context, Box<Patient> patients, _) {
                      listPatient = patients.values.toList();
                      return ListView(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height,
                            color: Colors.blueGrey[200],
                            child: ListView.builder(
                                itemCount: patients.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (_, index) {
                                  Patient patient = patients.getAt(index);

                                  return Container(
                                    padding:
                                        EdgeInsets.fromLTRB(10, 15, 10, 15),
                                    margin: EdgeInsets.only(
                                        bottom: index == patients.length - 1
                                            ? 170
                                            : 0,
                                        left: 20,
                                        right: 20,
                                        top: index == 0 ? 20 : 14),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 6,
                                              offset: Offset(3, 3),
                                              color:
                                                  Colors.black.withOpacity(0.5))
                                        ]),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.66,
                                                  child: Text(
                                                      "Nama : ${patient.name}",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.clip)),
                                              Text(
                                                  "Umur : ${patient.age.toString()}"),
                                              Text(
                                                  "Jenis Kelamin : ${patient.gender}"),
                                              Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.66,
                                                  child: Text(
                                                      "Penyakit : ${patient.disease}",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.clip)),
                                              Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.66,
                                                  child: Text(
                                                      "Lokasi Perawatan : ${patient.location}",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.clip)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ],
                      );
                    });
              }
            }
          }),
    );
  }
}

class DataSearch extends SearchDelegate<Patient> {
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var filteredPatient = listPatient;
    final showList = query.isEmpty
        ? listPatient
        : filteredPatient
            .where((value) =>
                value.name.toLowerCase().startsWith(query.toLowerCase()) ||
                value.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
    return Container(
      color: Colors.blueGrey[200],
      child: ListView.builder(
          itemCount: showList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (_, index) {
            return Container(
              padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
              margin: EdgeInsets.only(
                  bottom: index == showList.length - 1 ? 170 : 0,
                  left: 20,
                  right: 20,
                  top: index == 0 ? 20 : 14),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 6,
                        offset: Offset(3, 3),
                        color: Colors.black.withOpacity(0.5))
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.66,
                            child: Text("Nama : ${showList[index].name}",
                                maxLines: 2, overflow: TextOverflow.clip)),
                        Text("Umur : ${showList[index].age.toString()}"),
                        Text("Jenis Kelamin : ${showList[index].gender}"),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.66,
                            child: Text("Penyakit : ${showList[index].disease}",
                                maxLines: 2, overflow: TextOverflow.clip)),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.66,
                            child: Text(
                                "Lokasi Perawatan : ${showList[index].location}",
                                maxLines: 2,
                                overflow: TextOverflow.clip)),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
