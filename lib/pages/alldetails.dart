import 'package:hive/hive.dart';
import 'package:student_management/pages/image_view.dart';
import '../model/student.dart';
import '../main.dart';
import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:student_management/widgets/baseappbar.dart';

class AllDetails extends StatelessWidget {
  final  box = Hive.box<Student>(boxName);
  final List<Student> obj;
  final int index;

  AllDetails({Key? key, required this.obj, required this.index}) : super(key: key);

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
              backgroundColor: Colors.grey,
              child: obj[index].imagePath == null
                  ? const Text("No Image",
                      style: TextStyle(fontSize: 25, color: Colors.tealAccent))
                  : GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> ViewImage(imagepath: obj[index].imagePath,)));
                },
                    child: ClipOval(
                        child: Image.file(
                        File(obj[index].imagePath),
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      )),
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              obj[index].name,
              style: const TextStyle(fontSize: 35, color: Colors.deepOrangeAccent),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const  SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Class : ",style: TextStyle(color: Colors.grey,fontSize: 16),),
                    SizedBox(height: 12,),
                    Text("Age    : ",style: TextStyle(color: Colors.grey,fontSize: 16),),
                    SizedBox(height: 12,),
                    Text("Place : ",style: TextStyle(color: Colors.grey,fontSize: 16),),
                  ],
                ),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(obj[index].currentClass.toString(),
                               style: const TextStyle(fontSize: 22, color: Colors.purple)),
                    const  SizedBox(height: 3,),
                    Text(obj[index].age.toString(),
                            style: const TextStyle(fontSize: 22, color: Colors.purple)),
                    const  SizedBox(height: 3,),
                    Text(obj[index].place,
                               style: const TextStyle(fontSize: 22, color: Colors.purple)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
