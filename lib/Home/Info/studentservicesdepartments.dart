import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Global/rowSection.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(StudentServicesDepartments());

class StudentServicesDepartments extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StudentServicesDepartmentsState();
  }
}

class _StudentServicesDepartmentsState
    extends State<StudentServicesDepartments> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: appBar(context, 'Student Services'),
      body: Container(
        child: ListView(
          children: <Widget>[
            Card(
              child: ListTile(
                title: Text('Ms. Shahenaz'),
                leading: Image.asset('images/logosmall.png'),
                subtitle: Text('SSD'),
                trailing: GestureDetector(
                  onTap: () {
                    launch('msteams://teams.microsoft.com/l/chat/0/0?users=' +
                        'ssd@skylineuniversity.ac.ae');
                  },
                  child: Icon(
                    Icons.send,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
             Card(
              child: ListTile(
                title: Text('Ms. Tsetsei'),
                leading: Image.asset('images/logosmall.png'),
                subtitle: Text('Counselor'),
                trailing: GestureDetector(
                  onTap: () {
                    launch('msteams://teams.microsoft.com/l/chat/0/0?users=' +
                        'counselor@skylineuniversity.ac.ae');
                  },
                  child: Icon(
                    Icons.send,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
