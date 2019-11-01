import 'package:flutter/material.dart';

import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/global.dart';


import 'package:skyline_university/Global/rowSection.dart';

void main() => runApp(HomeAdmission());

class HomeAdmission extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeAdmissionState();
  }
}

class _HomeAdmissionState extends State<HomeAdmission> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),


            rowSection(context,isDark(context)?'images-white/admission.png':'images/admission.png','Application Form','/AdmissionForm'),

          ],
        ),
      ),
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: appBar(context, 'Admission'),
    );
  }
}
//TODO: SystemChrome.setEnabledSystemUIOverlays([]) For hide status Bar
