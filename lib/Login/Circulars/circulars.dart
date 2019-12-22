import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:superellipse_shape/superellipse_shape.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(Circulars());

class Circulars extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CircularsState();
  }
}

// Map<String, int> body;

class _CircularsState extends State<Circulars> {
  List circularsJson = [];
  Map circularsMessageJson = {};
  @override
  void initState() {
    super.initState();
    getStudentCirculars();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
        appBar: appBarLogin(context, "Circulars"),
        body: circularsJson.isEmpty
            ? exception(context, FontAwesomeIcons.exclamationTriangle,
                circularsMessageJson['message'])
            : Container(
                child: circularsJson == null
                    ? Center(child: Text(''))
                    : ListView.builder(
                        itemCount: circularsJson.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 5, top: 5),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              elevation: 10,
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 30,
                                      decoration: new BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
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
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.access_time,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              circularsJson[index]
                                                  ['published_datetime'],
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              circularsJson[index]['title']
                                                  .toString(),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 15),
                                          child: InkWell(
                                            child: Text(
                                              'Download',
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                            onTap: () {
                                              launch(
                                                  circularsJson[index]['path']);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
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

  Future getStudentCirculars() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });
    try {
      http.Response response = await http.post(
        Uri.encodeFull(
            "https://skylineportal.com/moappad/api/web/getDataByType"),
        headers: {
          "API-KEY": API,
        },
        body: {
          'student_id': username,
          'type': 'circular',
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          circularsJson = json.decode(response.body)['data'];
          circularsMessageJson = json.decode(response.body);
        });
        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        // showErrorServer(context, getStudentCirculars());
      } else {
        showLoading(false, context);

        // showErrorConnect(context, getStudentCirculars());
      }
    }
  }

  Future<void> shareCIR(link) async {
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
