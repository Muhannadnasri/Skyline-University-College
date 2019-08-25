import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/rowSection.dart';

// Centre for continuing learning
void main() => runApp(HomePrograms());

class Item {
  final name;
  final clipType;

  Item(this.name, this.clipType);
}

class HomePrograms extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeProgramsState();
  }
}

class _HomeProgramsState extends State<HomePrograms> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: appBar(context, 'Programs'),
      body: Container(
        child: ListView(children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              rowSection(context, 'images/admission.png',
                  'Undergraduate Programs', "/homeUndergraduate"),
              rowSection(context, 'images/admission.png', 'Graduate Programs',
                  "/homeGraduate"),
              rowSection(context, 'images/admission.png',
                  'Professional Courses', "/professionalCourses"),
              rowSection(context, 'images/admission.png', 'Scholarship',
                  "/scholarship"


              ),
              rowSection(context, 'images/admission.png', 'Fee Structure',
                  "/feeStructures"),
            ],
          ),
        ]),
      ),
    );
  }
}
//TODO: SystemChrome.setEnabledSystemUIOverlays([]) For hide status Bar
