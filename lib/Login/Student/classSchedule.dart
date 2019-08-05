import 'dart:convert';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/zigzag.dart';
import 'package:skyline_university/Home/home.dart';
import 'package:superellipse_shape/superellipse_shape.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(CourseDetails());

class CourseDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CourseDetailsState();
  }
}

// Map<String, int> body;

class _CourseDetailsState extends State<CourseDetails> {
  List classScheduleCourseJson = [];

  @override
  void initState() {
    super.initState();
    getClassScheduleCourseDetails();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: 70,
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
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
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
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      "Class Schedule",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        logOut(context);
                      },
                      child: GestureDetector(
                        onTap: () {
                          logOut(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.powerOff,
                                color: Colors.red,
                                size: 15,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Logout',
                                style:
                                    TextStyle(fontSize: 15, color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //TODO: Put all Icon Container
            ],
          ),
        ),
        body: Container(
          color: Colors.grey[300],
          child: classScheduleCourseJson == null
              ? Center(child: Text(''))
              : ListView.builder(
                  itemCount: classScheduleCourseJson.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      elevation: 10,
                      child: DottedBorder(
                        color: Colors.blue,
                        gap: 3,
                        strokeWidth: 1,
                        child: Column(
                          children: <Widget>[
                            FittedBox(
                              child: Row(children: <Widget>[
                                Text(
                                  classScheduleCourseJson[index]['COURSE NAME'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ]),
                            ),
                            Row(
                              children: <Widget>[
                                Text('Faculty Name : '),
                                Text(
                                    classScheduleCourseJson[index]
                                            ['FACULTY NAME']
                                        .toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text("EXTN:"),
                                GestureDetector(
                                  onTap: () {
                                    launch('tel:0097165441155' +
                                            ',1' +
                                            ',' +
                                            classScheduleCourseJson[index]
                                                    ['EXTN']
                                                .toString()
//
                                        );
                                  },
                                  child: Text(
                                    ' +97165441155 : ' +
                                        classScheduleCourseJson[index]['EXTN']
                                            .toString(),
                                    style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text("Email: "),
                                GestureDetector(
                                  onTap: () {
                                    launch('mailto:' +
                                        classScheduleCourseJson[index]['MAILID']
                                            .toString());
                                  },
                                  child: Text(
                                    classScheduleCourseJson[index]['MAILID']
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('Course Code : '.padRight(10)),
                                Text(
                                  classScheduleCourseJson[index]['CODE']
                                      .toString(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ));
  }

  Future getClassScheduleCourseDetails() async {
    Future.delayed(Duration.zero, () {
      classScheduleCourseJson = [];
      showLoading(true, context);
    });
    try {
      http.Response response = await http.post(
        Uri.encodeFull(
            "https://skylineportal.com/moappad/api/web/classScheduleCourseDetails"),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'usertype':studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          classScheduleCourseJson = json.decode(response.body)['data'];
        });
        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getClassScheduleCourseDetails);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getClassScheduleCourseDetails);
      }
    }
  }
}
