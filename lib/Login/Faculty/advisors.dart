import 'dart:convert';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:http/http.dart' as http;

import 'package:superellipse_shape/superellipse_shape.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(Advisors());

class Advisors extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AdvisorsState();
  }
}

// Map<String, int> body;

class _AdvisorsState extends State<Advisors> {
  List myAdvisorsJson = [];

  @override
  void initState() {
    super.initState();
    getAdvisors();
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
                      "Advisor Students",
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
          child: ListView.builder(
            itemCount: myAdvisorsJson.length,
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
                          height: 40,
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
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    myAdvisorsJson[index]['Name'],
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
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            children: <Widget>[
                              Text('Roll No : '),
                              Text(myAdvisorsJson[index]['RollNo']),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            children: <Widget>[
                              Text('AdvisorName : '),
                              Text(myAdvisorsJson[index]['AdvisorName']),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            children: <Widget>[
                              Text('GPA : '),
                              Text(myAdvisorsJson[index]['Gpa'].toString()),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            children: <Widget>[
                              Text('Level : '),
                              Text(myAdvisorsJson[index]['S_Level']),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            children: <Widget>[
                              Text('Mobile No : '),
                              GestureDetector(
                                  onTap: () {
                                    launch('tel:00' +
                                        myAdvisorsJson[index]['MobileNo']
                                            .toString());
                                  },
                                  child: Text(
//

                                    myAdvisorsJson[index]['MobileNo']
                                            .toString()
                                            .startsWith('9', 0)
                                        ? '00' +
                                            myAdvisorsJson[index]['MobileNo']
                                                .toString()
                                        : '' +
                                            myAdvisorsJson[index]['MobileNo']
                                                .toString(),

                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.blue),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            children: <Widget>[
                              Text('Mail No : '),
                              GestureDetector(
                                  onTap: () {
                                    launch('mailto:' +
                                        myAdvisorsJson[index]['MailId']
                                            .toString());
                                  },
                                  child: Text(
                                    myAdvisorsJson[index]['MailId'],
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.blue),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            children: <Widget>[
                              Text('With TOC : '),
                              Text(myAdvisorsJson[index]['With TOC'] == null
                                  ? 'No'
                                  : myAdvisorsJson[index]['With TOC']),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            children: <Widget>[
                              Text('With Sap : '),
                              Text(myAdvisorsJson[index]['WithSap'] == ''
                                  ? 'No'
                                  : myAdvisorsJson[index]['WithSap']),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            children: <Widget>[
                              Text('Shift Time : '),
                              Text(myAdvisorsJson[index]['shift'] == 'E'
                                  ? 'Evening'
                                  : myAdvisorsJson[index]['shift'] == 'M'
                                      ? 'Morning'
                                      : myAdvisorsJson[index]['shift'] == 'W'
                                          ? 'Weekend'
                                          : ''),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            children: <Widget>[
                              Text('Repeating Course : '),
                              Text(myAdvisorsJson[index]['Repeating Course'] ==
                                      ''
                                  ? 'No'
                                  : 'Yes'),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: myAdvisorsJson[index]['CondAdm'] == ''
                              ? SizedBox()
                              : Row(
                                  children: <Widget>[
                                    Text('CondAdm : '),
                                    Text(
                                        myAdvisorsJson[index]['CondAdm'] == null
                                            ? ''
                                            : myAdvisorsJson[index]['CondAdm']),
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

  void _showError(String msg, IconData icon) {
    showLoading(false, context);
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
                padding: const EdgeInsets.only(left: 30.0),
                child: new Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: new Icon(icon),
                    ),
                    new Text(msg)
                  ],
                ),
              ),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    getAdvisors();
                  },
                  child: new Text('Try again'),
                ),
              ],
            ),
          );
        });
  }

  Future getAdvisors() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getMyAdvisees'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'advisory_id': studentJson['data']['user_id'],
          'usertype':studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            myAdvisorsJson = json.decode(response.body)['data'];
          },
        );

        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getAdvisors);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getAdvisors);
      }
    }
  }
}
