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
        title: Text(
          "Pengelola Data Pasien Meninggal",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
                patientsBox.add(Patient("Eren Yeager", 10, "Pria",
                    "Serangan Jantung", "Mayo Clinic"));
                patientsBox.add(Patient("Malty S. Melromarc", 29, "Wanita",
                    "Covid-19", "Cleveland Clinic"));
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
                                  padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
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
                                      Column(
                                        children: [
                                          IconButton(
                                              icon: Icon(Icons.edit),
                                              color: Colors.blueAccent,
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      nameController.text =
                                                          patients
                                                              .getAt(index)
                                                              .name;
                                                      ageController.text =
                                                          patients
                                                              .getAt(index)
                                                              .age
                                                              .toString();
                                                      diseaseController.text =
                                                          patients
                                                              .getAt(index)
                                                              .disease;
                                                      locationController.text =
                                                          patients
                                                              .getAt(index)
                                                              .location;
                                                      selectedIndex = patients
                                                                  .getAt(index)
                                                                  .gender ==
                                                              'Pria'
                                                          ? 0
                                                          : 1;

                                                      return StatefulBuilder(
                                                          builder: (context,
                                                              StateSetter
                                                                  setState) {
                                                        return Dialog(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                            child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            18),
                                                                child: ListView(
                                                                    shrinkWrap:
                                                                        true,
                                                                    children: [
                                                                      CustomTextField(
                                                                          nameController,
                                                                          "Nama"),
                                                                      CustomTextField(
                                                                        ageController,
                                                                        "Umur",
                                                                        inputNumber:
                                                                            true,
                                                                      ),
                                                                      CustomTextField(
                                                                          diseaseController,
                                                                          "Penyakit"),
                                                                      CustomTextField(
                                                                          locationController,
                                                                          "Lokasi Perawatan"),
                                                                      SizedBox(
                                                                          height:
                                                                              5),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          customGenderButton(
                                                                              genreList[0],
                                                                              0,
                                                                              setState),
                                                                          SizedBox(
                                                                              width: 14),
                                                                          customGenderButton(
                                                                              genreList[1],
                                                                              1,
                                                                              setState),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              16),
                                                                      FlatButton(
                                                                          onPressed:
                                                                              () {
                                                                            //update patient data

                                                                            String
                                                                                name =
                                                                                nameController.text;
                                                                            String
                                                                                age =
                                                                                ageController.text;

                                                                            String
                                                                                disease =
                                                                                diseaseController.text;

                                                                            String
                                                                                location =
                                                                                locationController.text;

                                                                            if (!(name.trim() != "" &&
                                                                                age.trim() != "" &&
                                                                                selectedIndex != null &&
                                                                                disease.trim() != "" &&
                                                                                location.trim() != "")) {
                                                                              Flushbar(duration: Duration(milliseconds: 1500), flushbarPosition: FlushbarPosition.TOP, backgroundColor: Colors.red, message: "Isi semua field", icon: Icon(Icons.warning, color: Colors.white))..show(context);
                                                                            } else {
                                                                              Patient patient = Patient(name, int.parse(age), (selectedIndex == 0) ? "Pria" : "Wanita", disease, location);
                                                                              patientsBox.putAt(index, patient);

                                                                              Navigator.pop(context);

                                                                              Flushbar(duration: Duration(milliseconds: 1500), flushbarPosition: FlushbarPosition.TOP, backgroundColor: Colors.green, message: "Data berhasil diubah", icon: Icon(Icons.check_box, color: Colors.white))..show(context);

                                                                              nameController.clear();
                                                                              ageController.clear();
                                                                              selectedIndex = 0;
                                                                              diseaseController.clear();
                                                                              locationController.clear();
                                                                            }
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            "Ubah",
                                                                            style:
                                                                                TextStyle(color: Colors.blueGrey[800]),
                                                                          ))
                                                                    ])));
                                                      });
                                                    });
                                              }),
                                          IconButton(
                                              icon: Icon(Icons.delete),
                                              color: Colors.red,
                                              onPressed: () {
                                                //delete patient data
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
                              backgroundColor: Colors.teal,
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
                                                    BorderRadius.circular(15)),
                                            child: Padding(
                                                padding: EdgeInsets.all(18),
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
                                                      SizedBox(height: 5),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          customGenderButton(
                                                              genreList[0],
                                                              0,
                                                              setState),
                                                          SizedBox(width: 14),
                                                          customGenderButton(
                                                              genreList[1],
                                                              1,
                                                              setState),
                                                        ],
                                                      ),
                                                      SizedBox(height: 16),
                                                      FlatButton(
                                                          onPressed: () {
                                                            //add patient data
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

  Widget customGenderButton(
    AssetImage image,
    int index,
    StateSetter setState,
  ) {
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
      child: Container(
        height: 48,
        width: (MediaQuery.of(context).size.width - 196) / 2,
        padding: EdgeInsets.all(10),
        child: Image(
            image: image,
            color: (selectedIndex == index)
                ? selectedIndex == 0
                    ? Colors.blueAccent
                    : Colors.pink
                : Colors.grey),
      ),
    );
  }
}
