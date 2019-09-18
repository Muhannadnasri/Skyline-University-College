import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  Map currentTimeJson = {};
  bool isDone = false;
  @override
  void initState() {
    super.initState();
    currentTimeJson = {};

    getCurrent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: isDone
              ? ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: 15,
                        ),
                        rowSection(context, 'images/admission.png',
                            'Course Details', "/CourseDetails"),
                        currentTimeJson['Shift_Desc'] == "MORNING" ||
                                currentTimeJson['Shift_Desc'] == "EVENING"
                            ? rowSection(
                                context,
                                'images/admission.png',
                                'Class Schedule Weekday',
                                "/ClassScheduleWeekday")
                            : SizedBox(),
                        currentTimeJson['Shift_Desc'] == "WEEKEND"
                            ? rowSection(
                                context,
                                'images/admission.png',
                                'Class Schedule Weekend',
                                "/ClassScheduleWeekend")
                            : SizedBox(),
                        currentTimeJson['Shift_Desc'] == "MQP"
                            ? rowSection(
                                context,
                                'images/admission.png',
                                'Class Schedule Mqp WeekDay',
                                "/ClassScheduleMqpWeekDay")
                            : SizedBox(),
                      ],
                    ),
                  ],
                )
              : SizedBox()),
         appBar: 
        PreferredSize(
          preferredSize: Size.fromHeight(250.0),
          child: Stack(

            children: <Widget>[
              
              Column(
                children: <Widget>[
                  ZigZag(
                    clipType: ClipType.waved,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.white,
                                              blurRadius:
                                                  12.0, // has the effect of softening the shadow
                                              spreadRadius:
                                                  3.0, // has the effect of extending the shadow
                                            )
                                          ],
                                        ),
                                        child: Image.asset(
                                          studentJson['data']['user_type'] ==
                                                  'FAC'
                                              ? 'images/professor-male.png'
                                              : studentJson['data']['Gender'] ==
                                                      'M'
                                                  ? 'images/male.png'
                                                  : studentJson['data']
                                                              ['Gender'] ==
                                                          'F'
                                                      ? 'images/female.png'
                                                      : 'images/professor-male.png',
                                          height: 25,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          studentJson['data']['name'].toString(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  studentJson['data']['user_type'] == 'STF'
                                      ? SizedBox(
                                          height: 10,
                                        )
                                      : Row(
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.white,
                                                    blurRadius:
                                                        12.0, // has the effect of softening the shadow
                                                    spreadRadius:
                                                        3.0, // has the effect of extending the shadow
                                                  )
                                                ],
                                              ),
                                              child: Image.asset(
                                                'images/degree.png',
                                                height: 25,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                studentJson['data']['program']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.white,
                                              blurRadius:
                                                  12.0, // has the effect of softening the shadow
                                              spreadRadius:
                                                  3.0, // has the effect of extending the shadow
                                            )
                                          ],
                                        ),
                                        child: Image.asset(
                                          'images/year.png',
                                          height: 25,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          studentJson['data']['acadyear_desc']
                                              .toString(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      height: 250,
                      decoration: new BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF104C90),
                            Color(0xFF3773AC),
                          ],
                          stops: [
                            0.7,
                            0.9,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              Padding(
                padding: const EdgeInsets.only(top: 80.0, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: <Widget>[
                    studentJson['photo'].toString() ==
                            "https:\/\/skylineportal.com\/sitgmioxg\/professor.png"
                        ? Container(
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: Container(
                              width: 110.0,
                              height: 110.0,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue),
                                shape: BoxShape.circle,
                                color: Colors.white,
                                image: DecorationImage(
                                  fit: BoxFit.fitHeight,
                                  image: AssetImage(
                                    'images/logosmall.png',
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: Container(
                              width: 110.0,
                              height: 110.0,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue),
                                shape: BoxShape.circle,
                                color: Colors.white,
                                image: DecorationImage(
                                  fit: BoxFit.fitHeight,
                                  image: NetworkImage(
                                    studentJson['photo'].toString(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                   GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.arrow_back_ios,
                          size: 15,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Back',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            logOut(context);
                          });
                        },
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              height: 30,
                            ),
                            Icon(
                              FontAwesomeIcons.powerOff,
                              color: Colors.red,
                              size: 17,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Logout',
                              style: TextStyle(fontSize: 17, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
     
    );
  }

  Future getCurrent() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getCurrentAndNewShift'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      );
      if (response.statusCode == 200) {
        setState(
          () {
            isDone = true;
            currentTimeJson =
                json.decode(response.body)['data']['current_shift'];
          },
        );

        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getCurrent);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getCurrent);
      }
    }
  }
}
//TODO: SystemChrome.setEnabledSystemUIOverlays([]) For hide status Bar
