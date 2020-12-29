import 'package:flutter/material.dart';
import 'package:pasien/model/patient.dart';
import 'package:pasien/ui/pages/pages.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appDocumentDirectory =
      await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(PatientAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Raleway', primaryColor: Colors.teal),
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
