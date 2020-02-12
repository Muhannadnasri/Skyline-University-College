import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Global/pdfView.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

void main() => runApp(CDPDownload());

class CDPDownload extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CDPDownloadState();
  }
}

// Map<String, int> body;

class _CDPDownloadState extends State<CDPDownload>
    with TickerProviderStateMixin {
  List cdpCourseJson = [];
  Map cdpCourseMessageJson = {};
  AnimationController _controller;

  @override
  void initState() {
    getCDPCourse();
    super.initState();
    cdpCourseJson = [];
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      appBar: appBarLogin(context, 'CDP'),
      body: cdpCourseJson == null || cdpCourseJson.isEmpty
          ? exception(context)
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
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 30,
                            decoration: new BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
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
                                Text(
                                  'Batch Code : ',
                                  style: TextStyle(
                                      color: isDark(context)
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                Text(
                                  cdpCourseJson[index]['BatchCode'],
                                  style: TextStyle(
                                      color: isDark(context)
                                          ? Colors.white
                                          : Colors.black),
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
//                                       shareCDP(
//                                           'https://www.skylineportal.com/Report/Pages/SkylineCPD-Display.aspx?path1=${cdpCourseJson[index]['Faculty_id']}&batch=${cdpCourseJson[index]['BatchCode']}&studid=$username&reqid=2&cdp=0');
// // TODO: Add New Button Share / view And fix Pdf Viewer

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PdfView(
                                            url: 
                                            
                                            
                                            'http://sky.skylineuniversity.ac.ae/page/PrintLMS.aspx?Id=".CDP_ID."&Type=CDP'
                                            'https://www.skylineportal.com/Report/Pages/SkylineCPD-Display.aspx?path1=${cdpCourseJson[index]['Faculty_id']}&batch=${cdpCourseJson[index]['BatchCode']}&studid=$username&reqid=2&cdp=0',
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                        child: Text(
                                      'Download',
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Colors.blue),
                                    ))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  void _showLoading(isLoading) {
    if (isLoading) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return WillPopScope(
              onWillPop: () {},
              child: new AlertDialog(
                title: Image.asset(
                  'images/logo.png',
                  height: 50,
                ),
                shape: SuperellipseShape(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                content: Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 25.0),
                        child: new CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: new Text('Please Wait....'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    } else {
      Navigator.pop(context);
    }
  }

  Future getCDPCourse() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      http.Response response = await http.post(
        Uri.encodeFull("https://skylineportal.com/moappad/api/test/CDPCourse"),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
        },
      ).timeout(Duration(seconds: 50));

      if (response.statusCode == 200) {
        setState(() {
          cdpCourseJson = json.decode(response.body)['data'];
          cdpCourseMessageJson = json.decode(response.body);
        });
        showLoading(false, context);
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

  Future<void> shareCDP(link) async {
    _showLoading(true);
    try {
      var request = await HttpClient().getUrl(Uri.parse(link));
      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      await Share.file(
          'Share Document', 'Document.pdf', bytes, 'application/pdf');
      Future.delayed(const Duration(seconds: 1), () {
        _showLoading(false);
      });
    } catch (e) {}
  }
}
