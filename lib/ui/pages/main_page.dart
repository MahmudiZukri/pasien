part of 'pages.dart';

const String boxName = "patienst";

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController diseaseController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  List<AssetImage> genreList = [
    AssetImage('assets/male_icon.png'),
    AssetImage('assets/female_icon.png')
  ];
  int selectedIndex = 0;

  Widget build(BuildContext context) {
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
                  return Stack(children: [
                    ListView(
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
                                  padding: EdgeInsets.all(10),
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
                                                    maxLines: 1,
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
                                                    "Nama : ${patient.disease}",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.clip)),
                                            Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.66,
                                                child: Text(
                                                    "Nama : ${patient.location}",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.clip)),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          // IconButton(
                                          //     icon: Icon(Icons.edit),
                                          //     color: Colors.blueAccent,
                                          //     onPressed: () {}),
                                          IconButton(
                                              icon: Icon(Icons.delete),
                                              color: Colors.red,
                                              onPressed: () {
                                                patients.deleteAt(index);
                                                Flushbar(
                                                    duration: Duration(
                                                        milliseconds: 1500),
                                                    flushbarPosition:
                                                        FlushbarPosition.TOP,
                                                    backgroundColor: Colors.red,
                                                    message:
                                                        "Data pasien dihapus",
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: Colors.white,
                                                    ))
                                                  ..show(context);
                                              }),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          margin: EdgeInsets.all(16),
                          child: FloatingActionButton(
                              child: Icon(
                                Icons.add,
                                size: 30,
                              ),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(builder:
                                          (context, StateSetter setState) {
                                        return Dialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                                padding: EdgeInsets.all(10),
                                                child: ListView(
                                                    shrinkWrap: true,
                                                    children: [
                                                      CustomTextField(
                                                          nameController,
                                                          "Nama"),
                                                      CustomTextField(
                                                        ageController,
                                                        "Umur",
                                                        inputNumber: true,
                                                      ),
                                                      CustomTextField(
                                                          diseaseController,
                                                          "Penyakit"),
                                                      CustomTextField(
                                                          locationController,
                                                          "Lokasi Perawatan"),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          customGenderButton(
                                                              genreList[0],
                                                              0,
                                                              setState),
                                                          customGenderButton(
                                                              genreList[1],
                                                              1,
                                                              setState),
                                                        ],
                                                      ),
                                                      SizedBox(height: 5),
                                                      FlatButton(
                                                          onPressed: () {
                                                            //add patient in hive
                                                            final String name =
                                                                nameController
                                                                    .text;
                                                            final String age =
                                                                ageController
                                                                    .text;

                                                            final String
                                                                disease =
                                                                diseaseController
                                                                    .text;
                                                            final String
                                                                location =
                                                                locationController
                                                                    .text;

                                                            if (!(name
                                                                        .trim() !=
                                                                    "" &&
                                                                age
                                                                        .trim() !=
                                                                    "" &&
                                                                selectedIndex !=
                                                                    null &&
                                                                disease.trim() !=
                                                                    "" &&
                                                                location.trim() !=
                                                                    "")) {
                                                              Flushbar(
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          1500),
                                                                  flushbarPosition:
                                                                      FlushbarPosition
                                                                          .TOP,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                  message:
                                                                      "Isi semua field",
                                                                  icon: Icon(
                                                                      Icons
                                                                          .warning,
                                                                      color: Colors
                                                                          .white))
                                                                ..show(context);
                                                            } else {
                                                              Patient patient = Patient(
                                                                  name,
                                                                  int.parse(
                                                                      age),
                                                                  (selectedIndex ==
                                                                          0)
                                                                      ? "Pria"
                                                                      : "Wanita",
                                                                  disease,
                                                                  location);
                                                              patientsBox
                                                                  .add(patient);

                                                              Navigator.pop(
                                                                  context);

                                                              Flushbar(
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          1500),
                                                                  flushbarPosition:
                                                                      FlushbarPosition
                                                                          .TOP,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .green,
                                                                  message:
                                                                      "Data berhasil ditambahkan",
                                                                  icon: Icon(
                                                                      Icons
                                                                          .check_box,
                                                                      color: Colors
                                                                          .white))
                                                                ..show(context);

                                                              nameController
                                                                  .clear();
                                                              ageController
                                                                  .clear();
                                                              selectedIndex = 0;
                                                              diseaseController
                                                                  .clear();
                                                              locationController
                                                                  .clear();
                                                            }
                                                          },
                                                          child: Text(
                                                            "Tambahkan",
                                                            style: TextStyle(
                                                                color: Colors
                                                                        .blueGrey[
                                                                    800]),
                                                          ))
                                                    ])));
                                      });
                                    });
                              }),
                        ))
                  ]);
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

  Widget customGenderButton(AssetImage image, int index, StateSetter setState) {
    return OutlineButton(
        onPressed: () {
          setState(() {
            selectedIndex = index;
          });
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        borderSide: BorderSide(
            color: (selectedIndex == index)
                ? selectedIndex == 0
                    ? Colors.blueAccent
                    : Colors.pink
                : Colors.grey),
        child: Image(
            image: image,
            color: (selectedIndex == index)
                ? selectedIndex == 0
                    ? Colors.blueAccent
                    : Colors.pink
                : Colors.grey));
  }
}
