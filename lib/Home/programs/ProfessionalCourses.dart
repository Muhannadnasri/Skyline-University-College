import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/rowSection.dart';

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
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                    'images-white/admission.png',
                    'Centre for Continuing Learning',
                    '/centreContinuingLearning'),
                rowSection(
                    context,
                    'images/admission.png',
                    'images-white/admission.png',
                    'Executive Development Program',
                    '/executiveDevelopmentProgram'),
                rowSection(
                    context,
                    'images/admission.png',
                    'images-white/admission.png',
                    'English Language Centre',
                    '/englishLanguageCentre'),
                rowSection(
                    context,
                    'images/admission.png',
                    'images-white/admission.png',
                    'Masters Qualifying Program',
                    '/mastersQualifyingProgram'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
