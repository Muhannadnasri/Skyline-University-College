import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(CDPDownload());

class CDPDownload extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CDPDownloadState();
  }
}

// Map<String, int> body;

class _CDPDownloadState extends State<CDPDownload> {
  List cdpCourseJson = [];
  Map cdpCourseMessageJson = {};
  @override
  void initState() {
    getCDPCourse();
    super.initState();
    cdpCourseJson = [];
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      appBar: appBarLogin(context, 'CDP'),
      body: cdpCourseJson == null
          ? Center(child: Text(''))
          : Container(
              child: ListView.builder(
                itemCount: cdpCourseJson.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      elevation: 10,
                      child: DottedBorder(
                        color: Colors.blue,
                        gap: 3,
                        strokeWidth: 1,
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 30,
                              decoration: new BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
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
                                      ])),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        cdpCourseJson[index]['Name'],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: <Widget>[
                                  Text('Batch Code : '),
                                  Text(
                                    cdpCourseJson[index]['BatchCode'],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                      onTap: () {
                                        launch(
                                          'https://www.skylineportal.com/Report/Pages/SkylineCPD-Display.aspx?path1=${cdpCourseJson[index]['Faculty_id']}&batch=${cdpCourseJson[index]['BatchCode']}&studid=$username&reqid=2&cdp=0',
                                        );
                                      },
                                      child: Container(
                                          child: Text(
                                        'View',
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            color: Colors.blue),
                                      ))),
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
            ),
    );
  }

  Future getCDPCourse() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      http.Response response = await http.post(
        Uri.encodeFull(
            "https://skylineportal.com/moappad/api/web/getCDPCourse"),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1'
        },
      ).timeout(Duration(seconds: 50));

      if (response.statusCode == 200) {
        setState(() {
          cdpCourseJson = json.decode(response.body)['data'];
          cdpCourseMessageJson = json.decode(response.body);
        });
        showLoading(false, context);
      }
      if (cdpCourseMessageJson['success'] == '0') {
        showLoading(false, context);
        Fluttertoast.showToast(
            msg: cdpCourseMessageJson['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey[400],
            textColor: Colors.black87,
            fontSize: 13.0);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getCDPCourse);
      } else {
        showLoading(false, context);

        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getCDPCourse);
      }
    }
  }
}
