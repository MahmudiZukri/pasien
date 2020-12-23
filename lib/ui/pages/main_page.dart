part of 'pages.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const String boxName = "patienst";

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Pengelola Data Pasien Meninggal"),
      ),
      body: FutureBuilder(
        future: Hive.openBox<Patient>(boxName),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error),
              );
            } else {
              Box<Patient> patientsBox = Hive.box<Patient>(boxName);
              if (patientsBox.length == 0) {
                patientsBox.add(Patient("Robert", 10, "Laki laki",
                    "Serangan Jantung", "Mayo Clinic"));
                patientsBox.add(Patient(
                    "Selena", 29, "Perempuan", "Covid-19", "Cleveland Clinic"));
              }
              return ValueListenableBuilder(
                valueListenable: patientsBox.listenable(),
                builder: (context, Box<Patient> patients, _) {
                  return Container(
                    color: Colors.blueGrey[200],
                    padding: EdgeInsets.all(20),
                    child: ListView.builder(
                        itemCount: patients.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (_, index) {
                          Patient patient = patients.getAt(index);
                          return Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(bottom: 12),
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
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Nama : ${patient.name}"),
                                      Text("Umur : ${patient.age.toString()}"),
                                      Text("Jenis Kelamin : ${patient.gender}"),
                                      Text("Penyakit : ${patient.disease}"),
                                      Text(
                                          "Lokasi Perawatan : ${patient.location}")
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                        icon: Icon(Icons.edit),
                                        color: Colors.blueAccent,
                                        onPressed: () {}),
                                    IconButton(
                                        icon: Icon(Icons.delete),
                                        color: Colors.red,
                                        onPressed: () {
                                          patients.deleteAt(index);
                                        }),
                                  ],
                                )
                              ],
                            ),
                          );
                        }),
                  );
                },
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
