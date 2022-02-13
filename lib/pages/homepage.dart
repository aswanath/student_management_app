import 'package:flutter/material.dart';
import 'package:student_management/model/student.dart';
import 'package:student_management/pages/alldetails.dart';
import 'package:student_management/pages/add.dart';
import 'package:student_management/pages/edit.dart';
import 'package:student_management/main.dart';
import 'package:student_management/widgets/baseappbar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text("Student Management");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: BaseAppBar(
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (cusIcon.icon == Icons.search) {
                    cusIcon = const Icon(Icons.close);
                    cusSearchBar = const TextField(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.tealAccent)
                        ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.tealAccent)
                          ),
                          hintText: "Search",
                          hintStyle: TextStyle(
                            color: Colors.tealAccent,
                          )),
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    );
                  } else {
                    cusIcon = const Icon(Icons.search);
                    cusSearchBar = const Text("Student Management");
                  }
                });
              },
              icon: cusIcon)
        ],
        title: cusSearchBar,
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Student>(boxName).listenable(),
        builder: (context, Box<Student> newbox, _){
          List key = newbox.keys.toList();
          if (key.isEmpty) {
            return const Center(
              child: Text("The Student List is Empty"),
            );
          } else {
            return ListView.separated(
                itemBuilder: (context, index) {
                  Student? data = newbox.getAt(index);
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                    child: ListTile(
                      visualDensity: const VisualDensity(vertical: 2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      tileColor: Colors.white,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllDetails(
                                      obj: data!,
                                    )));
                      },
                      leading: data?.imagePath == null
                          ? CircleAvatar(
                              backgroundColor: Colors.blue[200],
                              child: const Text(
                                "No Image",
                                style: TextStyle(
                                    fontSize: 8, color: Colors.purple),
                              ),
                            )
                          : CircleAvatar(
                              child: ClipOval(
                                  child: Image.file(
                              File(data!.imagePath),
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ))),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Edit(
                                            obj: data!,
                                            index: index,
                                          )));
                            },
                            child: const Icon(Icons.edit),
                          ),
                          TextButton(
                            onPressed: () {
                              showDialog(context: context, builder: (BuildContext context){
                               return AlertDialog(
                                  title: Text("Delete"),
                                  content: Text("Do you want to delete it?"),
                                  actions: [
                                    TextButton(onPressed: (){
                                      Navigator.pop(context);
                                    }, child: Text("No")),
                                    TextButton(onPressed: (){
                                      data!.delete();
                                      Navigator.pop(context);
                                    }, child: Text("Yes"))
                                  ],
                                );
                              });
                            },
                            child: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                      title: Text(
                        data!.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.blue[50],
                  );
                },
                itemCount: key.length);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Details()));
        },
        child: const Text(
          "Add",
          style: TextStyle(color: Colors.tealAccent),
        ),
      ),
    );
  }
}
