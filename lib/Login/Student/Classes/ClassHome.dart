import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/appBarLoginImage.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Global/rowSection.dart';
import 'package:skyline_university/Global/zigzag.dart';

void main() => runApp(HomeClass());

class HomeClass extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeClassState();
  }
}

class _HomeClassState extends State<HomeClass> {
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
                    'Course Details',
                    "/CourseDetails"),
                rowSection(
                    context,
                    'images/admission.png',
                    'images-white/admission.png',
                    'Class Schedule Weekday',
                    "/ClassScheduleWeekday"),
                rowSection(
                    context,
                    'images/admission.png',
                    'images-white/admission.png',
                    'Class Schedule Weekend',
                    "/ClassScheduleWeekend"),
                rowSection(
                    context,
                    'images/admission.png',
                    'images-white/admission.png',
                    'Class Schedule Mqp WeekDay',
                    "/ClassScheduleMqpWeekDay")
              ],
            ),
          ],
        )),
        appBar: appBarLoginImage(context));
  }
}
//TODO: SystemChrome.setEnabledSystemUIOverlays([]) For hide status Bar
