import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Global/rowSection.dart';
import 'package:skyline_university/Home/programs/professionalProgram.dart';
import 'package:skyline_university/Home/programs/undergraduateProgram.dart';

void main() => runApp(ProfessionalCourses());

class ProfessionalCourses extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfessionalCoursesState();
  }
}

class _ProfessionalCoursesState extends State<ProfessionalCourses> {
  List programsJson = [];
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
      appBar: appBar(context, 'Professional Programs'),
      body: ListView(
        children: <Widget>[
          FittedBox(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                rowSection(
                    context,
                    'images/admission.png',
                    'Centre for Continuing Learning',
                    '/centreContinuingLearning'),
                rowSection(
                    context,
                    'images/admission.png',
                    'Executive Development Program',
                    '/executiveDevelopmentProgram'),
                rowSection(context, 'images/admission.png',
                    'English Language Centre', '/englishLanguageCentre'),
                rowSection(context, 'images/admission.png',
                    'Masters Qualifying Program', '/mastersQualifyingProgram'),
              ],
            ),
          ),
        ],
      ),

      // ListView.builder(
      //     itemCount: programsJson.length,
      //     itemBuilder: (BuildContext context, int index) {
      //       return GestureDetector(
      //         onTap: () {
      //           print(index);
      //         },
      //         child: Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: Card(
      //             shape: BeveledRectangleBorder(
      //                 borderRadius: BorderRadius.circular(15.0)),
      //             elevation: 10,
      //             child: Container(
      //               child: ExpansionTile(
      //                 leading: Icon(
      //                   FontAwesomeIcons.info,
      //                   size: 20,
      //                 ),
      //                 title: Html(
      //                   data: programsJson[index]['name'].toString(),
      //                 ),
      //                 children: <Widget>[
      //                   Divider(color: Colors.black),
      //                   Row(
      //                     children: <Widget>[
      //                       Expanded(
      //                         child: Padding(
      //                           padding: const EdgeInsets.all(15.0),
      //                           child: Text(
      //                             programsJson[index]['description'],
      //                             style: TextStyle(fontSize: 13),
      //                           ),
      //                         ),
      //                       ),
      //                       SizedBox(
      //                         width: 10,
      //                       ),
      //                       GestureDetector(
      //                         onTap: () {
      //                           Navigator.push(
      //                             context,
      //                             MaterialPageRoute(
      //                               builder: (context) =>
      //                                   ProfessionalProgram(
      //                                 programName: programsJson[index]
      //                                     ['name'],
      //                                 programId: programsJson[index]['id']
      //                                     .toString(),
      //                                 programdescription: programsJson[index]
      //                                     ['description'],
      //                               ),
      //                             ),
      //                           );
      //                         },
      //                         child: Icon(
      //                           FontAwesomeIcons.arrowRight,
      //                           size: 20,
      //                           color: Colors.green,
      //                         ),
      //                       ),
      //                       SizedBox(
      //                         width: 10,
      //                       ),
      //                     ],
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //         ),
      //         //
      //       );
      //     }),
    );
  }

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
          'category_id': '3',
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
