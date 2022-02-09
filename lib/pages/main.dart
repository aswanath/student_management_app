import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'homepage.dart';
import 'package:hive/hive.dart';
import 'package:student_management/model/personal_details.dart';
import 'package:hive_flutter/hive_flutter.dart';
const String personalDetailsBox = "personal_details";
Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
   final document = await getApplicationDocumentsDirectory();
   Hive.init(document.path);
  Hive.registerAdapter(PersonalDetailsAdapter());
  await Hive.openBox<PersonalDetails>(personalDetailsBox);
  runApp(StudentManagement());
}

class StudentManagement extends StatelessWidget {
  const StudentManagement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:ThemeData(
        primaryColor: Colors.blueAccent,
        iconTheme: const IconThemeData(
          color: Colors.brown
        ),
      ),
      home: HomePage(),
    );
  }
}

