import 'package:hive/hive.dart';
part 'model.g.dart';
//hiveModel
@HiveType(typeId: 0)
class StudentModel extends HiveObject{
  @HiveField(0)
  String name;
  @HiveField(1)
  String age;
  @HiveField(2)
  String domain;
  @HiveField(3)
  String number;
  @HiveField(4)
  String image;
  StudentModel(
      {required this.name,
      required this.age,
      required this.domain,
      required this.number,
      required this.image});
}
