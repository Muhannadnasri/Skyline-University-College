import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
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
  Map classScheduleCourseMessageJson = {};

  @override
  void initState() {
    super.initState();
    getClassScheduleCourseDetails();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
        appBar: appBarLogin(context, 'Class Details'),
        body: classScheduleCourseJson == null
            ? exception(context, FontAwesomeIcons.exclamationTriangle,
                classScheduleCourseMessageJson['message'])
            : Container(
                color: Colors.white,
                child: ListView.builder(
                  itemCount: classScheduleCourseJson.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        elevation: 10,
                        child: DottedBorder(
                          color: Colors.blue,
                          gap: 3,
                          strokeWidth: 1,
                          child: Column(

                            children: <Widget>[
                              Container(
                                decoration: new BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  gradient: LinearGradient(
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
                                  ),
                                ),
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
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: <Widget>[
                                    Text('Faculty Name : '),
                                    Text(
                                      classScheduleCourseJson[index]
                                              ['FACULTY NAME']
                                          .toString(),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
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
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: <Widget>[
                                    Text("Email: "),
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
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: <Widget>[
                                    Text('Course Code : '.padRight(10)),
                                    Text(
                                      classScheduleCourseJson[index]['CODE']
                                          .toString(),
                                    ),
                                  ],
                                ),
                              ),
                             
                            ],
                            
                          ),
                          
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
          classScheduleCourseMessageJson = json.decode(response.body);
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
