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

import 'advisorAppointment.dart';

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
  Map myAdvisorMessageJson = {};
  @override
  void initState() {
    super.initState();
    getMyAdvisor();
    myAdvisorJson = [];
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
        appBar: appBarLogin(context, 'Advisor Details'),
        body: myAdvisorJson == null
            ? exception(context, FontAwesomeIcons.exclamationTriangle,
                myAdvisorMessageJson['message'])
            : Container(
                color: Colors.white,
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
                        child: DottedBorder(
                          color: Colors.blue,
                          gap: 3,
                          strokeWidth: 1,
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
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AdvisorAppointment(
                                                          myAdvisorName:
                                                              myAdvisorJson[
                                                                          index]
                                                                      [
                                                                      'NAME OF THE FACULTY']
                                                                  .toString()),
                                                ),
                                              );
                                            },
                                            child: Icon(
                                              FontAwesomeIcons.calendarAlt,
                                              color: Colors.white,
                                              size: 20,
                                            )),
                                      ),
                                    ]),
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
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Text('Postion : '),
                                  Text(
                                    myAdvisorJson[index]['DESIGNATION']
                                        .toString(),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Mobile Phone : "),
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
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Text("Extestion NO : "),
                                  Text(myAdvisorJson[index]['EXTENSION NO']
                                      .toString()),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Text('Email ID : '.padRight(10)),
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
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Text('Faclty ID : '),
                                  Text(
                                    myAdvisorJson[index]['FACULTY_ID']
                                        .toString(),
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

  Future getMyAdvisor() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getMyAdvisors'),
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
        setState(
          () {
            myAdvisorJson = json.decode(response.body)['data'];
            myAdvisorMessageJson = json.decode(response.body);
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
