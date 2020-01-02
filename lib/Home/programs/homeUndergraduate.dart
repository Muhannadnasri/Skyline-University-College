import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/rowSection.dart';

// Centre for continuing learning
void main() => runApp(HomeUndergraduate());

class Item {
  final name;
  final clipType;

  Item(this.name, this.clipType);
}

class HomeUndergraduate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeUndergraduateState();
  }
}

class _HomeUndergraduateState extends State<HomeUndergraduate> {
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
      appBar: appBar(context, 'Undergraduate'),
      body: Container(
        child: ListView(
          children: <Widget>[
            FittedBox(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  rowSection(context, 'images/admission.png', 'images-white/admission.png',
                      'School Of Business', '/underGraduateBusiness'),
                  rowSection(context, 'images/admission.png', 'images-white/admission.png',
                      'School Of Information Technology', '/underGraduateIT'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//TODO: SystemChrome.setEnabledSystemUIOverlays([]) For hide status Bar
