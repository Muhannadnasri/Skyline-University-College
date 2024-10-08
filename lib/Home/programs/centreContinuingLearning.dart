import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Home/programs/undergraduateProgram.dart';

void main() => runApp(CentreContinuingLearning());

class CentreContinuingLearning extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CentreContinuingLearningState();
  }
}

class _CentreContinuingLearningState extends State<CentreContinuingLearning> {
  List programsJson = [];
  bool isLoading = true;
  Map programsJsonMessage = {};
  @override
  void initState() {
    super.initState();
    getPrograms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appBar(context, 'Centre Continuing Learning'),
      body: Container(
        child: programsJson == null || programsJson.isEmpty
            ? exception(context, isLoading)
            : ListView.builder(
                itemCount: programsJson.length,
                itemBuilder: (BuildContext context, int index) {
                  return programsJson[index]['id'] == 56 ||
                          programsJson[index]['id'] == 57 ||
                          programsJson[index]['id'] == 58 ||
                          programsJson[index]['id'] == 59 ||
                          programsJson[index]['id'] == 60 ||
                          programsJson[index]['id'] == 61 ||
                          programsJson[index]['id'] == 62 ||
                          programsJson[index]['id'] == 63 ||
                          programsJson[index]['id'] == 64 ||
                          programsJson[index]['id'] == 65 ||
                          programsJson[index]['id'] == 66 ||
                          programsJson[index]['id'] == 67 ||
                          programsJson[index]['id'] == 68 ||
                          programsJson[index]['id'] == 69 ||
                          programsJson[index]['id'] == 70 ||
                          programsJson[index]['id'] == 71 ||
                          programsJson[index]['id'] == 72 ||
                          programsJson[index]['id'] == 73 ||
                          programsJson[index]['id'] == 74 ||
                          programsJson[index]['id'] == 75 ||
                          programsJson[index]['id'] == 76 ||
                          programsJson[index]['id'] == 77 ||
                          programsJson[index]['id'] == 78
                      ? Padding(
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
                                    data:
                                        programsJson[index]['name'].toString()),
                                children: <Widget>[
                                  Divider(color: Colors.black),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Text(
                                            programsJson[index]['description'],
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: isDark(context)
                                                    ? Colors.white
                                                    : Colors.black),
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
                                                programId: programsJson[index]
                                                        ['id']
                                                    .toString(),
                                                programdescription:
                                                    programsJson[index]
                                                        ['description'],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
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
                        )
                      : SizedBox();
                }),
      ),
    );
  }

  Future getPrograms() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });
    try {
      http.Response response = await http.post(
        Uri.parse(
            "https://skylineportal.com/moappad/api/test/ProgramsByCategory"),
        headers: {
          "API-KEY": API,
        },
        body: {
          'category_id': '3',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          programsJson = json.decode(response.body)['data'];
          programsJsonMessage = json.decode(response.body);
          isLoading = false;
        });

        showLoading(false, context);
        if (programsJsonMessage['success'] == '0') {
          showfailureSnackBar(context, programsJsonMessage['message']);
        }
      }
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
