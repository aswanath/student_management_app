
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
  String searchtext = "";

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
                    cusSearchBar = TextField(
                      autofocus: true,
                      onChanged: (value) {
                        searchtext = value;
                        setState(() {});
                      },
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.tealAccent)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.tealAccent)),
                          hintText: "Search",
                          hintStyle: TextStyle(
                            color: Colors.tealAccent,
                          )),
                      style: const TextStyle(color: Colors.tealAccent, fontSize: 20),
                    );
                  } else {
                    setState(() {
                      searchtext = "";
                    });
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
        builder: (context, Box<Student> newbox, _) {
          List key = newbox.keys.toList();
          if (key.isEmpty) {
            return const Center(
              child: Text("The Student List is Empty"),
            );
          } else {
            List<Student>  data = newbox.values
                .toList()
                .where((element) => element.name
                    .toLowerCase()
                    .contains(searchtext.toLowerCase())).toList();
             if(data.isEmpty){
               return const Center(
                   child: Text("No results found",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),));
            }return Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                                        obj: data, index: index,
                                      )));
                        },
                        leading: data[index].imagePath == null
                            ? CircleAvatar(
                                backgroundColor: Colors.grey,
                                child: const Text(
                                  "No Image",
                                  style: TextStyle(
                                      fontSize: 8, color: Colors.tealAccent),
                                ),
                              )
                            : CircleAvatar(
                                child: ClipOval(
                                    child: Image.file(
                                File(data[index].imagePath),
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
                                              obj: data,
                                              index: index,
                                          searchText: searchtext,
                                            )));
                              },
                              child: const Icon(Icons.edit),
                            ),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Delete"),
                                        content:
                                            Text("Do you want to delete it?"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("No")),
                                          TextButton(
                                              onPressed: () {
                                                data[index].delete();
                                                Navigator.pop(context);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            "Student deleted Successfully")));
                                              },
                                              child: Text("Yes"))
                                        ],
                                      );
                                    });
                              },
                              child: const Icon(Icons.delete,color: Colors.red,),
                            ),
                          ],
                        ),
                        title: Text(
                          data[index].name,
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
                  itemCount: data.length),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purpleAccent,
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
