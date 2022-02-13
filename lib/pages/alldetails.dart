import 'package:hive/hive.dart';
import '../model/student.dart';
import '../main.dart';
import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:student_management/widgets/baseappbar.dart';

class AllDetails extends StatelessWidget {
  var box = Hive.box<Student>(boxName);
  final Student obj;

  AllDetails({Key? key, required this.obj}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: BaseAppBar(
        leadingback: true,
        title: const Text("Details"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 75,
              backgroundColor: Colors.blue[200],
              child: obj.imagePath == null
                  ? const Text("No Image",
                      style: TextStyle(fontSize: 25, color: Colors.purple))
                  : ClipOval(
                      child: Image.file(
                      File(obj.imagePath),
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    )),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              obj.name,
              style: const TextStyle(fontSize: 35, color: Colors.purple),
            ),
            const SizedBox(
              height: 20,
            ),
            Text("place : ${obj.place}",
                style: const TextStyle(fontSize: 22, color: Colors.purple)),
            const SizedBox(
              height: 10,
            ),
            Text("age : ${obj.age}",
                style: const TextStyle(fontSize: 22, color: Colors.purple)),
            const SizedBox(
              height: 10,
            ),
            Text("class : ${obj.currentClass}",
                style: const TextStyle(fontSize: 22, color: Colors.purple)),
          ],
        ),
      ),
    );
  }
}
