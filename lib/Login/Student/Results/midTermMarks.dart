import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(MidTermMarks());

class MidTermMarks extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MidTermMarksState();
  }
}

// Map<String, int> body;

class _MidTermMarksState extends State<MidTermMarks> {
  List midTermMarksJson = [];
  Map midTermMarksMessageJson = {};
  @override
  void initState() {
    super.initState();
    getMidTermMarks();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    return Scaffold(
      appBar: appBarLogin(context, 'Mid Term Marks'),
      body: midTermMarksJson == null ||
              midTermMarksJson.isEmpty &&
                  midTermMarksMessageJson['success'] == 0
          ? exception(context, 
              midTermMarksMessageJson['message'])
          : Container(
              child: ListView.builder(
                itemCount: midTermMarksJson.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      elevation: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
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
                                    child: Text(
                                      midTermMarksJson[index]['COURSE NAME'],
                                      style: TextStyle(color: Colors.white),
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
                            padding: const EdgeInsets.only(left: 10, top: 10.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Course Code : ',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: isDark(context)
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                Text(
                                  midTermMarksJson[index]['COURSE CODE'],
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: isDark(context)
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 10.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Faculty Name : ',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: isDark(context)
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                Text(
                                  midTermMarksJson[index]['FACULTY NAME'],
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: isDark(context)
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 10.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Semester : ',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: isDark(context)
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                Text(
                                  midTermMarksJson[index]['SEMESTER NAME'],
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: isDark(context)
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 10.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Marks : ',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: isDark(context)
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                Text(
                                  midTermMarksJson[index]['MARKS'].toString(),
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: isDark(context)
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
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

  Future getMidTermMarks() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });
    try {
      http.Response response = await http.post(
        Uri.encodeFull(
            "https://skylineportal.com/moappad/api/test/MidTermMarks"),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          midTermMarksJson = json.decode(response.body)['data'];
          midTermMarksMessageJson = json.decode(response.body);
        });
        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getMidTermMarks);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getMidTermMarks);
      }
    }
  }
}
