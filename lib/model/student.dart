import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
part 'student.g.dart';

@HiveType(typeId: 0)
class Student extends HiveObject{
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int age;

  @HiveField(2)
  final int currentClass;

  @HiveField(3)
  final String place;

  @HiveField(4)
  final dynamic imagePath;

  Student({required this.name, required this.age,required this.currentClass, required this.place,required this.imagePath, });
}