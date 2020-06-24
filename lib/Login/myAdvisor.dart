import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:url_launcher/url_launcher.dart';

import 'E-Reques/StudentForm/advisorAppointment.dart';

void main() => runApp(MyAdvisor());

class MyAdvisor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAdvisorState();
  }
}

// Map<String, int> body;

class _MyAdvisorState extends State<MyAdvisor> {
  List myAdvisorJson = [];
  @override
  void initState() {
    super.initState();
    getMyAdvisor();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        bottomNavigationBar: myAdvisorJson == null || myAdvisorJson.isEmpty
            ? SizedBox()
            : BottomAppBar(
                child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdvisorAppointment(
                          myAdvisorId:
                              myAdvisorJson[0]['FACULTY_ID'].toString(),
                          myAdvisorName: myAdvisorJson[0]['NAME OF THE FACULTY']
                              .toString()),
                    ),
                  );
                },
                child: Material(
                  elevation: 3,
                  shadowColor: Colors.black,
                  color:
                      isDark(context) ? Color(0xFF121212) : Color(0xFF275d9b),
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Text(
                      "Make Appointment",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              )),
        appBar: appBarLogin(context, 'Advisor Details'),
        body: myAdvisorJson == null || myAdvisorJson.isEmpty
            ? exception(context)
            : Container(
                child: ListView.builder(
                  itemCount: myAdvisorJson.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        elevation: 10,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          myAdvisorJson[index]
                                              ['NAME OF THE FACULTY'],
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ]),
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
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Postion : ',
                                    style: TextStyle(
                                        color: isDark(context)
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                  Text(
                                    myAdvisorJson[index]['DESIGNATION']
                                        .toString(),
                                    style: TextStyle(
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
                            GestureDetector(
                              onTap: () {
                                launch('tel:00' +
                                        myAdvisorJson[index]['TELPHONE NO'] +
                                        ',1' +
                                        ',' +
                                        myAdvisorJson[index]['EXTENSION NO']
                                            .toString()
//
                                    );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Mobile Phone : ",
                                      style: TextStyle(
                                          color: isDark(context)
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                    Text(
                                      '00' +
                                          myAdvisorJson[index]['TELPHONE NO']
                                              .toString(),
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Colors.blue),
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
                                  Text(
                                    "Extestion NO : ",
                                    style: TextStyle(
                                        color: isDark(context)
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                  Text(
                                    myAdvisorJson[index]['EXTENSION NO']
                                        .toString(),
                                    style: TextStyle(
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
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Email ID : ',
                                    style: TextStyle(
                                        color: isDark(context)
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      launch('mailto:' +
                                          myAdvisorJson[index]['EMAIL ID']
                                              .toString());
                                    },
                                    child: Text(
                                      myAdvisorJson[index]['EMAIL ID']
                                          .toString(),
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Colors.blue),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Faclty ID : ',
                                    style: TextStyle(
                                        color: isDark(context)
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                  Text(
                                    myAdvisorJson[index]['FACULTY_ID']
                                        .toString(),
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
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ));
  }

  Future getMyAdvisor() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull('https://skylineportal.com/moappad/api/test/MyAdvisors'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            myAdvisorJson = json.decode(response.body)['data'];
          },
        );

        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getMyAdvisor);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getMyAdvisor);
      }
    }
  }
}
