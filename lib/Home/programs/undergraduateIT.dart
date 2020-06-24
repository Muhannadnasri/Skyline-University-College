import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Home/programs/undergraduateProgram.dart';

void main() => runApp(UndergraduateIT());

class UndergraduateIT extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UndergraduateITState();
  }
}

class _UndergraduateITState extends State<UndergraduateIT> {
  List programsJson = [];
  Map programsJsonMessage = {};
  @override
  void initState() {
    super.initState();
    getPrograms();
    // programsJson = [];
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: appBar(context, 'School of Information Technology'),
      body: programsJson == null || programsJson.isEmpty
          ? exception(context)
          : ListView.builder(
              itemCount: programsJson.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
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
                                        programId: programsJson[index]['id']
                                            .toString(),
                                        programdescription: programsJson[index]
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
                );
              }),
    );
  }

  Future getPrograms() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });
    try {
      http.Response response = await http.post(
        Uri.encodeFull(
            "https://skylineportal.com/moappad/api/test/ProgramsByCategory"),
        headers: {
          "API-KEY": API,
        },
        body: {
          'category_id': '4',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          programsJson = json.decode(response.body)['data'];
          programsJsonMessage = json.decode(response.body);
        });

        showLoading(false, context);
        if (programsJsonMessage['success'] == '0') {
          showfailureSnackBar(context, programsJsonMessage['message']);
        }
        // if (programsJsonMessage['success'] == '1') {
        //   showSuccessSnackBar(context, programsJsonMessage['message']);
        // }
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
