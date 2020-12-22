import 'package:hive/hive.dart';
part 'patient.g.dart';

@HiveType(typeId: 0)
class Patient {
  @HiveField(0)
  String name;
  @HiveField(1)
  int age;
  @HiveField(2)
  String gender;
  @HiveField(3)
  String disease;
  @HiveField(4)
  String location;

  Patient(this.name, this.age, this.gender, this.disease, this.location);
}
