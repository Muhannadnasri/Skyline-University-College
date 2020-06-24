import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/global.dart';
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
    
    return Scaffold(
        appBar: appBarLogin(context, 'Class Details'),
        body: classScheduleCourseJson == null||classScheduleCourseJson.isEmpty
            ? exception(context)
            : Container(
                child: ListView.builder(
                  itemCount: classScheduleCourseJson.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        elevation: 5,
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: new BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  gradient: isDark(context)
                                      ? LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color(0xFF1F1F1F),
                                            Color(0xFF1F1F1F),
                                          ],
                                          stops: [
                                            0.7,
                                            0.9,
                                          ],
                                        )
                                      : LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color(0xFF104C90),
                                            Color(0xFF3773AC),
                                          ],
                                          stops: [
                                            0.7,
                                            0.9,
                                          ],
                                        )),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Text(
                                          classScheduleCourseJson[index]
                                              ['COURSE NAME'],
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: <Widget>[
                                  Text('Faculty Name : ',
                                      style: TextStyle(
                                          color: isDark(context)
                                              ? Colors.white
                                              : Colors.black)),
                                  Text(
                                      classScheduleCourseJson[index]
                                              ['FACULTY NAME']
                                          .toString(),
                                      style: TextStyle(
                                          color: isDark(context)
                                              ? Colors.white
                                              : Colors.black)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text("EXTN:",
                                      style: TextStyle(
                                          color: isDark(context)
                                              ? Colors.white
                                              : Colors.black)),
                                  GestureDetector(
                                    onTap: () {
                                      launch('tel:0097165441155' +
                                          ',1' +
                                          ',' +
                                          classScheduleCourseJson[index]['EXTN']
                                              .toString());
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
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: <Widget>[
                                  Text("Email: ",
                                      style: TextStyle(
                                          color: isDark(context)
                                              ? Colors.white
                                              : Colors.black)),
                                  GestureDetector(
                                    onTap: () {
                                      launch('mailto:' +
                                          classScheduleCourseJson[index]
                                                  ['MAILID']
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
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: <Widget>[
                                  Text('Course Code : ',
                                      style: TextStyle(
                                          color: isDark(context)
                                              ? Colors.white
                                              : Colors.black)),
                                  Text(
                                    classScheduleCourseJson[index]['CODE']
                                        .toString(),
                                    style: TextStyle(
                                        color: isDark(context)
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                ],
                              ),
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
          'usertype': studentJson['data']['user_type'],
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
