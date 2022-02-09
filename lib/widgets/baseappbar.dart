import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'dart:core';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:student_management/model/personal_details.dart';

import '../pages/main.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Text title;
  bool centerTitle = false;
  final AppBar appBar;
  List<Widget>? actions;

  BaseAppBar(
      {Key? key,
      required this.title,
      this.centerTitle=false,
      required this.appBar,
        this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      centerTitle: centerTitle,
      titleTextStyle: TextStyle(color: Colors.tealAccent, fontSize: 20),
      backgroundColor: Colors.blueAccent,
      actions: actions,
      iconTheme: IconThemeData(color: Colors.tealAccent),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}

class TextFieldCustom extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;

  const TextFieldCustom({Key? key, required this.labelText, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.blueGrey),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.purple),
            borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.purple),
            borderRadius: BorderRadius.circular(15)),
      ),
      controller: controller,
    );
  }
}

class DetailsPage extends StatefulWidget {
  final Text header;
  final String backoperation;
  final VoidCallback callback;

  DetailsPage(
      {Key? key,
      required this.header,
      required this.backoperation,
      required this.callback})
      : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  late Box<PersonalDetails>? pdBox;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController placeController = TextEditingController();

  File? _image;
  String? gender;
  Future getImage() async{
    final image = ImagePicker();
      PickedFile? pickedFile = await image.getImage(source: ImageSource.gallery);
      setState(() {
        _image = File(pickedFile!.path);
      });
  }
  var items = ['Male', 'Female','Other'];

  @override
  void initState() {
    super.initState();
    pdBox = Hive.box<PersonalDetails>(personalDetailsBox);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        appBar: AppBar(),
        centerTitle: true,
        title: widget.header,
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height*.01,
          ),
          Stack(
            children: [
              _image == null ? CircleAvatar(
                radius:75,
                backgroundColor: Colors.blue[200],
                child: Text("No Image Selected",style: TextStyle(color: Colors.purple),),
              ): ClipOval(child: Image.file(_image!,
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
                    icon: Icon(
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
              controller:  nameController,
              labelText: 'Name',
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
                  controller:  ageController,
                  labelText: 'Age',
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 10 / 100,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 35 / 100,
                height: MediaQuery.of(context).size.height * 7 / 100,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 10, 0, 10),
                      child: DropdownButton(
                          underline: SizedBox(),
                          iconSize: 30,
                          hint: Text('Gender',style: TextStyle(color: Colors.blueGrey),),
                          isExpanded: true,
                          value: gender,
                          style: TextStyle(
                            color: Colors.black,
                              fontSize:16
                          ),
                          icon: Icon(Icons.keyboard_arrow_down),
                          items: items.map((String items){
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                              );
                          }).toList(),
                         onChanged: (String? newVal){
                            setState(() {
                              gender = (newVal);
                            });
                         },
                        ),
                      ),
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
              controller: placeController,
              labelText: 'Place',
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*2/100,
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
                    final String name = nameController.text;
                    final String age = ageController.text;
                    final String place = placeController.text;

                  PersonalDetails personalDetails = PersonalDetails(name: name,age: int.parse(age),place: place);
                    pdBox?.add(personalDetails);
                    Navigator.pop(context,pdBox);
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
                    onPressed: widget.callback,
                    child: Text(
                      widget.backoperation,
                      style: const TextStyle(color: Colors.purple, fontSize: 16),
                    )),
              )
            ],
          )
        ],
      ),
    );
  }

}
