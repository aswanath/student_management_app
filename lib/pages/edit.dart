import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'dart:core';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../model/student.dart';
import '../widgets/baseappbar.dart';
import '../main.dart';

class Edit extends StatefulWidget {
  var box = Hive.box<Student>(boxName);
  final Student obj;
  final int index;
  final formKey = GlobalKey<FormState>();

  Edit({Key? key, required this.obj, required this.index}) : super(key: key);

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController classController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  XFile? _image;
  dynamic _imagePath;

  prefilledDetails() {
    nameController.text = widget.obj.name;
    ageController.text = widget.obj.age.toString();
    classController.text = widget.obj.currentClass.toString();
    placeController.text = widget.obj.place;
    _imagePath = widget.obj.imagePath;
  }

  Future getImage() async {
    final ImagePicker image = ImagePicker();
    _image = await image.pickImage(source: ImageSource.gallery);
    if (_image != null) {
      _imagePath = _image!.path;
    }
    return null;
  }

  @override
  void initState() {
    prefilledDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: BaseAppBar(
        leadingback: true,
        centerTitle: true,
        title: const Text("Edit"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: widget.formKey,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              Stack(
                children: [
                  _imagePath == null
                      ? CircleAvatar(
                          radius: 75,
                          backgroundColor: Colors.blue[200],
                          child: const Text(
                            "No Image Selected",
                            style: TextStyle(color: Colors.purple),
                          ),
                        )
                      : ClipOval(
                          child: Image.file(
                          File(_imagePath),
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        )),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.purple,
                      child: IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        onPressed: getImage,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 5 / 100,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 80 / 100,
                child: TextFieldCustom(
                  labelText: 'Name',
                  controller: nameController,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 100,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 10 / 100,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 35 / 100,
                    child: TextFieldCustom(
                      labelText: 'Age',
                      controller: ageController,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 10 / 100,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 35 / 100,
                    child: TextFieldCustom(
                      labelText: 'Class',
                      controller: classController,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 100,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 80 / 100,
                child: TextFieldCustom(
                  labelText: 'Place',
                  controller: placeController,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 100,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .1,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .35,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.box.putAt(
                            widget.index,
                            Student(
                                name: nameController.text,
                                age: int.parse(ageController.text),
                                currentClass: int.parse(classController.text),
                                place: placeController.text,
                                imagePath: _imagePath));
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .1,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .35,
                    child: ElevatedButton(
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
                                  widget.obj.delete();
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }, child: Text("Yes"))
                              ],
                            );
                          });
                        },
                        child: const Text(
                          "Delete",
                          style: TextStyle(color: Colors.purple, fontSize: 16),
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
