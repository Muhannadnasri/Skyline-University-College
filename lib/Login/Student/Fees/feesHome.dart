import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/appBarLoginImage.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Global/rowSection.dart';
import 'package:skyline_university/Global/zigzag.dart';

void main() => runApp(HomeFees());

class HomeFees extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeFeesState();
  }
}

class _HomeFeesState extends State<HomeFees> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                rowSection(context, 'images/admission.png', 'images-white/admission.png', 'Pay Online',
                    "/PayOnline"),
                rowSection(context, 'images/admission.png', 'images-white/admission.png', 'Admission Kit',
                    "/AdmissionKit"),
              ],
            ),
          ],
        ),
      ),
          appBar: 
              appBarLoginImage(context)

     
    );
  }
}
