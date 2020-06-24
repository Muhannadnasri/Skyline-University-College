import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(FinalTermResults());

class FinalTermResults extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FinalTermResultsState();
  }
}

class _FinalTermResultsState extends State<FinalTermResults> {
  List finalTermResultsJson = [];

  @override
  void initState() {
    super.initState();
    getFinalTermResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarLogin(context, 'Final Reults'),
      body: finalTermResultsJson == null || finalTermResultsJson.isEmpty
          ? exception(context)
          : Container(
              child: ListView.builder(
                itemCount: finalTermResultsJson.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        elevation: 20,
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
                                padding: const EdgeInsets.only(
                                    left: 10, top: 10.0, bottom: 5),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      child: Expanded(
                                        child: Text(
                                          finalTermResultsJson[index]
                                              ['Courses'],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, top: 10.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Course Code : ',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: isDark(context)
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                  Text(
                                    finalTermResultsJson[index]['Course Code'],
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: isDark(context)
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, top: 10.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Faculty Name : ',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: isDark(context)
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                  Text(
                                    finalTermResultsJson[index]['Faculty Name'],
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: isDark(context)
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, top: 10.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Semester : ',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: isDark(context)
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                  Text(
                                    finalTermResultsJson[index]['Semester'],
                                    style: TextStyle(
                                        fontSize: 13,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      'Grade',
                                      style: TextStyle(
                                          color: isDark(context)
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      finalTermResultsJson[index]
                                          ['Over All Grade'],
                                      style: TextStyle(
                                          color: isDark(context)
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      'Result',
                                      style: TextStyle(
                                          color: isDark(context)
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      child: finalTermResultsJson[index]
                                                      ['Results']
                                                  .toString() ==
                                              "FAIL"
                                          ? Text(
                                              finalTermResultsJson[index]
                                                  ['Results'],
                                              style:
                                                  TextStyle(color: Colors.red),
                                            )
                                          : finalTermResultsJson[index]
                                                          ['Results']
                                                      .toString() ==
                                                  "PASS"
                                              ? Text(
                                                  finalTermResultsJson[index]
                                                      ['Results'],
                                                  style: TextStyle(
                                                      color: Colors.green),
                                                )
                                              : finalTermResultsJson[index]
                                                              ['Results']
                                                          .toString() ==
                                                      "ABSENT"
                                                  ? Text(
                                                      finalTermResultsJson[
                                                          index]['Results'],
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    )
                                                  : Text('NOT AVAILABLE'),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      'Status',
                                      style: TextStyle(
                                          color: isDark(context)
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      child: finalTermResultsJson[index]
                                                      ['Status']
                                                  .toString() ==
                                              "F"
                                          ? Text(
                                              finalTermResultsJson[index]
                                                  ['Status'],
                                              style:
                                                  TextStyle(color: Colors.red),
                                            )
                                          : finalTermResultsJson[index]
                                                          ['Status']
                                                      .toString() ==
                                                  "P"
                                              ? Text(
                                                  finalTermResultsJson[index]
                                                      ['Status'],
                                                  style: TextStyle(
                                                      color: Colors.green),
                                                )
                                              : finalTermResultsJson[index]
                                                              ['Status']
                                                          .toString() ==
                                                      "AB"
                                                  ? Text(
                                                      finalTermResultsJson[
                                                          index]['Status'],
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    )
                                                  : Text('NOT AVAILABLE'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            )
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

  Future getFinalTermResults() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });
    try {
      http.Response response = await http.post(
        Uri.encodeFull(
            "https://skylineportal.com/moappad/api/test/getFinalTermResults"),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          finalTermResultsJson = json.decode(response.body)['data'];
        });
        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getFinalTermResults);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getFinalTermResults);
      }
    }
  }
}
