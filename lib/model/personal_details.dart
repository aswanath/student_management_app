import 'package:hive/hive.dart';
import 'dart:io';
part 'personal_details.g.dart';


@HiveType(typeId: 0)
class PersonalDetails extends HiveObject{
  @HiveField(0)
  final String? name;

  @HiveField(1)
  final int? age;
  
  @HiveField(2)
  final String? place;


  PersonalDetails({required this.name , required this.age, required this.place});
}
