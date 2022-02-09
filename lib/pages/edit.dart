import 'package:flutter/cupertino.dart';
import 'package:student_management/widgets/baseappbar.dart';

class Edit extends StatefulWidget {
  const Edit({Key? key}) : super(key: key);

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  @override
  Widget build(BuildContext context) {
    return DetailsPage(header: Text("Edit"), backoperation: 'Delete', callback: (){});
  }
}
