import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Home/programs/undergraduateProgram.dart';

void main() => runApp(UndergraduateIT());

class UndergraduateIT extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UndergraduateITState();
  }
}

List programsJson = [];

class _UndergraduateITState extends State<UndergraduateIT> {
  @override
  void initState() {
    super.initState();
    getPrograms();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: appBar(context, 'UndergraduateIT'),
      body: Container(
        color: Colors.grey[300],
        child: programsJson == null
            ? SizedBox()
            : ListView.builder(
                itemCount: programsJson.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      print(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        elevation: 10,
                        child: Container(
                          child: ExpansionTile(
                            leading: Icon(
                              FontAwesomeIcons.info,
                              size: 20,
                            ),
                            title: Html(
                              data: programsJson[index]['name'].toString(),
                            ),
                            children: <Widget>[
                              Divider(color: Colors.black),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        programsJson[index]['description'],
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              UndergraduateProgram(
                                            programName: programsJson[index]
                                                ['name'],
                                            programId: programsJson[index]['id']
                                                .toString(),
                                            programdescription:
                                                programsJson[index]
                                                    ['description'],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        FontAwesomeIcons.arrowRight,
                                        size: 20,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
      ),
    );
  }

  // Future getPrograms() async {
  //   new Future.delayed(Duration.zero, () {
  //     showLoading(true, context);
  //   });

  //   body = {};
  //   try {
  //     http.Response response = await http
  //         .post("http://muhannadnasri.com/App/programs/data.json", body: body);
  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       var Json = json.decode(response.body);
  //       Directory appDocDir = await getApplicationDocumentsDirectory();
  //       dataFile = new File(appDocDir.path + "/dataFile.json");

  //       if (dataFile.existsSync()) {
  //         if (Json['Undergraduate'] != null) {
  //           dataFile.writeAsStringSync(response.body);
  //         }
  //       } else {
  //         dataFile.createSync();
  //         dataFile.writeAsStringSync(response.body);
  //       }

  //       if (Json['Undergraduate'] != null) {
  //         programsJson = Json;
  //       } else {
  //         programsJson = json.decode(dataFile.readAsStringSync());
  //       }

  //       showLoading(false, context);

  //       setState(() {
  //         programs = programsJson["Undergraduate"];
  //       });
  //     } else {}
  //   } catch (x) {
  //     if (x.toString().contains("TimeoutException")) {
  //       showLoading(false, context);

  //       showError("Time out from server", FontAwesomeIcons.hourglassHalf,
  //           context, getPrograms);
  //     } else {
  //       showLoading(false, context);
  //       showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
  //           getPrograms);
  //     }
  //   }
  // }

  Future getPrograms() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });
    try {
      http.Response response = await http.post(
        Uri.encodeFull(
            "https://skylineportal.com/moappad/api/web/getProgramsByCategory"),
        headers: {
          "API-KEY": API,
        },
        body: {
          'usertype': '1',
          'category_id': '4',
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          programsJson = json.decode(response.body)['data'];
        });
        print(programsJson.toString());
        showLoading(false, context);
      }
    } catch (x) {
      print(x);
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getPrograms);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getPrograms);
      }
    }
  }
}
