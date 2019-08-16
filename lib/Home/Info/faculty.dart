import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(Faculty());

class Faculty extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FacultyState();
  }
}

List faculty = [];

Map facultyJson = {};
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
      appBar: appBar(context, 'Faculty members'),
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
                                SizedBox(
                                  height: 15,
                                ),
                                Card(
                                  child: Image.network(
                                    faculty[index]['image'],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  faculty[index]['Name'],
                                  style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(faculty[index]['Job_Title'],
                                    style: TextStyle(color: Colors.grey[600])),
                                SizedBox(
                                  height: 10,
                                ),
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
      showLoading(true, context);
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
          facultyJson = Json;
        } else {
          facultyJson = json.decode(dataFile.readAsStringSync());
        }

        showLoading(false, context);

        setState(() {
          faculty = facultyJson["faculty"];
        });
      } else {}
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getFaculty);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getFaculty);
      }
    }
  }
}
