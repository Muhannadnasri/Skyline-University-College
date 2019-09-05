import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Global/rowSection.dart';
import 'package:skyline_university/Home/programs/professionalProgram.dart';
import 'package:skyline_university/Home/programs/undergraduateProgram.dart';

void main() => runApp(ProfessionalCourses());

class ProfessionalCourses extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfessionalCoursesState();
  }
}

class _ProfessionalCoursesState extends State<ProfessionalCourses> {
  List programsJson = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: appBar(context, 'Professional Programs'),
      body: ListView(
        children: <Widget>[
          FittedBox(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                rowSection(
                    context,
                    'images/admission.png',
                    'Centre for Continuing Learning',
                    '/centreContinuingLearning'),
                rowSection(
                    context,
                    'images/admission.png',
                    'Executive Development Program',
                    '/executiveDevelopmentProgram'),
                rowSection(context, 'images/admission.png',
                    'English Language Centre', '/englishLanguageCentre'),
                rowSection(context, 'images/admission.png',
                    'Masters Qualifying Program', '/mastersQualifyingProgram'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
