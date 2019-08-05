import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Home/News/oneNews.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

import '../home.dart';

void main() => runApp(Faculty());

class Faculty extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FacultyState();
  }
}

List faculty = [];

File dataFile;

Map<String, String> body;

class _FacultyState extends State<Faculty> {
  @override
  void initState() {
    super.initState();
    getFaculty();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    "Faculty Members",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                     logOut(context);},
                    child: Padding(
                      padding: const EdgeInsets.all(17),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.home,
                            color: Colors.white,
                            size: 15,
                          ),
                          SizedBox(
                            width: 5,
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
        child: ListView.builder(
            itemCount: faculty.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            elevation: 10,
                            color: Colors.grey[100],
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 15,),

                                Card(


                                  child: Image.network(
                                    faculty[index]['image'],
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Text(
                                  faculty[index]['Name'],style: TextStyle(color:Colors.black),
                                ),
                                SizedBox(height: 5,),

                                Text(
                                  faculty[index]['Job_Title'],style: TextStyle(color:Colors.grey[600])
                                ),
                                SizedBox(height: 10,),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
      ),
    );
  }

  



  Future getFaculty() async {
    new Future.delayed(Duration.zero, () {
      showLoading(true,context);
    });

    body = {};
    try {
      http.Response response = await http
          .post("http://muhannadnasri.com/App/faculty/data.json", body: body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var Json = json.decode(response.body);
        Directory appDocDir = await getApplicationDocumentsDirectory();
        dataFile = new File(appDocDir.path + "/dataFile.json");

        if (dataFile.existsSync()) {
          if (Json['faculty'] != null) {
            dataFile.writeAsStringSync(response.body);
          }
        } else {
          dataFile.createSync();
          dataFile.writeAsStringSync(response.body);
        }

        if (Json['faculty'] != null) {
          appJson = Json;
        } else {
          appJson = json.decode(dataFile.readAsStringSync());
        }

        showLoading(false,context);

        setState(() {
          faculty = appJson["faculty"];
        });
      } else {}
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false,context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,context,getFaculty);
      } else {
          showLoading(false,context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi,context,getFaculty);
      }
    }
  }
}
