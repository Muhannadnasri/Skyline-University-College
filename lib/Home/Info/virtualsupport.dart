import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Global/rowSection.dart';

void main() => runApp(VirtualSupport());

class VirtualSupport extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VirtualSupportState();
  }
}

class _VirtualSupportState extends State<VirtualSupport> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: appBar(context, 'Departments'),
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
                      : 'images/admission.png',
                  'images-white/admission.png',
                  'Student Services Department',
                  '/studentServicesDepartments'),
              rowSection(
                  context,
                  isDark(context)
                      ? 'images-white/admission.png'
                      : 'images/admission.png',
                  'images-white/admission.png',
                  'Marketing Department',
                  '/marketingDepartment'),
              rowSection(
                  context,
                  isDark(context)
                      ? 'images-white/admission.png'
                      : 'images/admission.png',
                  'images-white/admission.png',
                  'Admission Department',
                  '/admissionDepartment'),
              rowSection(
                  context,
                  isDark(context)
                      ? 'images-white/admission.png'
                      : 'images/admission.png',
                  'images-white/admission.png',
                  'Media Department',
                  '/mediaDepartment'),
              rowSection(
                  context,
                  isDark(context)
                      ? 'images-white/admission.png'
                      : 'images/admission.png',
                  'images-white/admission.png',
                  'Finance Department',
                  '/financeDepartment'),
            ],
          ),
        ]),
      ),
    );
  }
}
