import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skyline_university/Global/appBarLoginImage.dart';
import 'package:skyline_university/Global/rowSection.dart';

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
    return Scaffold(
        body: Container(
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  rowSection(context, 'images/admission.png',
                      'images-white/admission.png', 'Pay Online', "/payOnline"),
                  rowSection(
                      context,
                      'images/admission.png',
                      'images-white/admission.png',
                      'Admission Kit',
                      "/AdmissionKit"),
                ],
              ),
            ],
          ),
        ),
        appBar: appBarLoginImage(context));
  }
}
