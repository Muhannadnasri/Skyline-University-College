import 'dart:convert';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/zigzag.dart';
import 'package:skyline_university/Home/home.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

void main() => runApp(Circulars());

class Circulars extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CircularsState();
  }
}

String circular = 'circular';
// Map<String, int> body;

class _CircularsState extends State<Circulars> {
  List circularsJson = [];

  @override
  void initState() {
    super.initState();
    getStudentCirculars();
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
                      "Circulars",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                       logOut(context);},
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
                              style: TextStyle(fontSize: 15, color: Colors.red),
                            ),
                          ],
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
          color: Colors.grey[300],
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
                          height: 110,
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
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.access_time,color: Colors.white,size: 20,),
                                        SizedBox(width: 10,),
                                        Text(
                                          circularsJson[index]
                                              ['published_datetime'],
                                          style: TextStyle(color: Colors.white),
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
                                    Flexible(
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
                                      padding: const EdgeInsets.only(right: 15),
                                      child: InkWell(
                                        child: Text(
                                          'Download',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                        onTap: () {
                                          launch(circularsJson[index]['path']);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ));
  }

 


  Future getStudentCirculars() async {
    Future.delayed(Duration.zero, () {
      showLoading(true,context);
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
          'type': circular,
          'usertype':studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          circularsJson = json.decode(response.body)['data'];
        });
        showLoading(false,context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false,context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,context,getStudentCirculars);
      } else {
          showLoading(false,context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi,context,getStudentCirculars);
      }
    }
  }
}
