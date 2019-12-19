import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/appBarLoginImage.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Global/rowSection.dart';
import 'package:skyline_university/Global/zigzag.dart';

void main() => runApp(HomeResult());
// FinalTermResults MidTermMarks StudentGPAProfile GetGPARequirments

class HomeResult extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeResultState();
  }
}

class _HomeResultState extends State<HomeResult> {
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
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  rowSection(
                      context,
                      'images/admission.png',
                      'images-white/admission.png',
                      'Final Term Results',
                      "/FinalTermResults"),
                  rowSection(
                      context,
                      'images/admission.png',
                      'images-white/admission.png',
                      'Mid Term Marks',
                      "/MidTermMarks"),
                  rowSection(
                      context,
                      'images/admission.png',
                      'images-white/admission.png',
                      'Student GPA Profile',
                      "/StudentGPAProfile"),
                  rowSection(
                      context,
                      'images/admission.png',
                      'images-white/admission.png',
                      'GPA Requirments',
                      "/GetGPARequirments"),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ],
          ),
        ),
        appBar: appBarLoginImage(context));
  }
}
//TODO: SystemChrome.setEnabledSystemUIOverlays([]) For hide status Bar
