import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skyline_university/Global/appBarLoginImage.dart';
import 'package:skyline_university/Global/rowSection.dart';

void main() => runApp(HomeAppointment());

class Item {
  final name;
  final clipType;

  Item(this.name, this.clipType);
}

class HomeAppointment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeAppointmentState();
  }
}

class _HomeAppointmentState extends State<HomeAppointment> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

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
              SizedBox(
                height: 10,
              ),
              Column(
                children: <Widget>[
                  rowSection(
                      context,
                      'images/orequest.png',
                      'images-white/orequest.png',
                      'General Appointment',
                      "/generalAppointment"),

                  // rowSection(
                  //     context,
                  //     'images/orequest.png',
                  //     'images-white/orequest.png',
                  //     'Leave Application Form',
                  //     "/leaveApplicationForm"),
                ],
              ),
            ],
          ),
        ),
        key: _scaffoldKey,
        appBar: appBarLoginImage(context));
  }
}
