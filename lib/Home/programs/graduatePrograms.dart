import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/global.dart';

import 'graduateProgram.dart';

void main() => runApp(GraduatePrograms());

class GraduatePrograms extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GraduateProgramsState();
  }
}

List programs = [];

File dataFile;
Map programsJson = {};
Map<String, String> body;

class _GraduateProgramsState extends State<GraduatePrograms> {
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
      appBar: appBar(context, 'Programs'),
      body: Container(
        color: Colors.grey[300],
        child: ListView.builder(
            itemCount: programs.length,
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
                          data: programs[index]['article-header'].toString(),
                        ),
                        children: <Widget>[
                          Divider(color: Colors.black),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    programs[index]['article-intro'],
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
                                      builder: (context) => GraduateProgram(
                                        programName: programs[index]['article-header'],
                                        programIntroduction: programs[index]
                                            ['INTRODUCTION'],
                                        programLink: programs[index]['Link'],
                                        programImage: programs[index]['Image'],
                                      ),
                                    ),
                                  );
                                },
                                child: Icon(
                                  FontAwesomeIcons.arrowRight,
                                  size: 20,
                                  color: Colors.green,
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
                //
              );
            }),
      ),
    );
  }

  Future getPrograms() async {
    new Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    body = {};
    try {
      http.Response response = await http
          .post("http://muhannadnasri.com/App/programs/data.json", body: body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var Json = json.decode(response.body);
        Directory appDocDir = await getApplicationDocumentsDirectory();
        dataFile = new File(appDocDir.path + "/dataFile.json");

        if (dataFile.existsSync()) {
          if (Json['graduate'] != null) {
            dataFile.writeAsStringSync(response.body);
          }
        } else {
          dataFile.createSync();
          dataFile.writeAsStringSync(response.body);
        }

        if (Json['graduate'] != null) {
          programsJson = Json;
        } else {
          programsJson = json.decode(dataFile.readAsStringSync());
        }

        showLoading(false, context);

        setState(() {
          programs = programsJson["graduate"];
        });
      } else {}
    } catch (x) {
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
