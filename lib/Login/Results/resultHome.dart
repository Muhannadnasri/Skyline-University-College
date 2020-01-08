import 'package:flutter/material.dart';
import 'package:skyline_university/Global/appBarLoginImage.dart';
import 'package:skyline_university/Global/rowSection.dart';

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
                      'images/final.png',
                      'images-white/final.png',
                      'Final Term Results',
                      "/finalTermResults"),
                  rowSection(
                      context,
                      'images/final.png',
                      'images-white/final.png',
                      'Mid Term Marks',
                      "/midTermMarks"),
                  rowSection(
                      context,
                      'images/gpa.png',
                      'images-white/gpa.png',
                      'Student GPA Profile',
                      "/studentGPAProfile"),
                  rowSection(
                      context,
                      'images/rgpa.png',
                      'images-white/rgpa.png',
                      'GPA Requirments',
                      "/getGPARequirments"),
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
