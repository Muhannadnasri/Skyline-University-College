import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/rowSection.dart';

void main() => runApp(Info());

class Info extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InfoState();
  }
}

class _InfoState extends State<Info> {
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
              rowSection(context, 'images/admission.png', 'images-white/admission.png', 'SUC at the glance',
                  '/glance'),
              rowSection(context, 'images/admission.png', 'images-white/admission.png',
                  'Vision, Mission, Goals & Objectives', '/goals'),
              rowSection(context, 'images/admission.png', 'images-white/admission.png', 'Board of Governors',
                  '/board'),
              rowSection(context, 'images/admission.png', 'images-white/admission.png', 'Founder President',
                  '/founder'),
              rowSection(context, 'images/admission.png', 'images-white/admission.png', 'Executive Council',
                  '/council'),
              rowSection(context, 'images/admission.png', 'images-white/admission.png', 'Dean', '/dean'),
              rowSection(
                  context, 'images/admission.png', 'images-white/admission.png', 'Committees', '/committees'),

//  rowSection(
//                   context, 'images/admission.png', 'images-white/admission.png', 'Committees', '/Calendars'),
            ],
          ),
        ]),
      ),
    );
  }

}
