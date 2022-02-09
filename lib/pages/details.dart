import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/baseappbar.dart';
import 'dart:ui';

class Details extends StatefulWidget {

  Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {


  @override
  Widget build(BuildContext context) {
    return DetailsPage(header: Text("Create"), backoperation: 'Back' , callback: (){
      Navigator.of(context).pop();
    });
  }


}
