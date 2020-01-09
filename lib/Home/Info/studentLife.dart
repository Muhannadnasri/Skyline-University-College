import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Global/rowSection.dart';

void main() => runApp(StudentLife());

class StudentLife extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StudentLifeState();
  }
}

class _StudentLifeState extends State<StudentLife> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: appBar(context, 'Skyline Info'),
      body: Container(
        child: ListView(children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              rowSection(
                  context,
                  isDark(context)
                      ? 'images-white/admission.png'
                      : 'images/admission.png', 'images-white/admission.png',
                  'International Students',
                  '/internationalStudents'),
              rowSection(
                  context,
                  isDark(context)
                      ? 'images-white/admission.png'
                      : 'images/admission.png', 'images-white/admission.png',
                  'Know More About Skyline',
                  '/knowMoreAboutSkyline'),
              rowSection(
                  context,
                  isDark(context)
                      ? 'images-white/admission.png'
                      : 'images/admission.png', 'images-white/admission.png',
                  'Student Services Department',
                  '/studentServicesDepartment'),
              rowSection(
                  context,
                  isDark(context)
                      ? 'images-white/admission.png'
                      : 'images/admission.png', 'images-white/admission.png',
                  'Academic Advising & Mentoring ',
                  '/academicAdvisingAndMentoring'),
              rowSection(
                  context,
                  isDark(context)
                      ? 'images-white/admission.png'
                      : 'images/admission.png', 'images-white/admission.png',
                  'Clubs',
                  '/clubs'),
              rowSection(
                  context,
                  isDark(context)
                      ? 'images-white/admission.png'
                      : 'images/admission.png', 'images-white/admission.png',
                  'Student Event Committees',
                  '/studentEventCommittees'),
              rowSection(
                  context,
                  isDark(context)
                      ? 'images-white/admission.png'
                      : 'images/admission.png', 'images-white/admission.png',
                  'Sports Department',
                  '/sportsDepartment'),
            ],
          ),
        ]),
      ),
    );
  }
}
