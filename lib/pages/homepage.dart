import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '../model/personal_details.dart';
import 'package:student_management/pages/details.dart';
import 'package:student_management/widgets/baseappbar.dart';


class HomePage extends StatefulWidget {
  Box<PersonalDetails>? pdBox;
  HomePage({Key? key,this.pdBox}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(pdBox!);
}

class _HomePageState extends State<HomePage> {
  Box<PersonalDetails>? pdBox;
  _HomePageState(this.pdBox);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        appBar: AppBar(),
        title: const Text('Student Management'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search))
        ],
      ),
      body: Column(
        children: [
          ValueListenableBuilder(
              valueListenable: pdBox!.listenable(),

              builder: (context, Box<PersonalDetails> newpersonaldetails, _){
                 List<int> keys = newpersonaldetails.keys.cast<int>().toList();

                return ListView.separated(
                    itemBuilder: (_,index){
                  final int key = keys[index];
                  PersonalDetails pd = newpersonaldetails.get(key)!;
                  return ListTile(
                    title: Text(pd.name??""),
                    subtitle: Text(pd.age.toString()),
                  );
                },
                  separatorBuilder: (_,index)=> Divider(),
                    shrinkWrap: true,
                  itemCount: keys.length);
              })
        ],
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Details()));
        },
        child: const Text("Add", style: TextStyle(color: Colors.tealAccent),),
      ),
    );
  }
}

