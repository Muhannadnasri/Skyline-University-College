import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Global/homeBox.dart';
import 'package:skyline_university/Global/homeBoxValueCategory.dart';
import 'package:skyline_university/Global/lists.dart';
import 'package:http/http.dart' as http;

import '../../Global/appBarLoginImage.dart';
import '../../Global/homeBoxValue.dart';

void main() => runApp(HomeRequest());

class Item {
  final name;
  final clipType;

  Item(this.name, this.clipType);
}

class HomeRequest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeRequestState();
  }
}

class _HomeRequestState extends State<HomeRequest> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List categoryJson = [];
  List icons = [
    'images/orequest.png',
    'images/erequest.png',
    'images/attendance.png',
    'images/orequest.png',
    'images/orequest.png',
    'images/orequest.png',
    'images/orequest.png',
    'images/orequest.png',
    'images/orequest.png',
  ];
  @override
  void initState() {
    super.initState();
    getCategoryJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body:

            //  studentJson['data']['user_type'] == "STUDENT"
            //     ?
            Container(
          color: isDark(context) ? Color(0xFF121212) : Colors.grey[100],
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(10.0),
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width - 10,
                    child: GridView.builder(
                      itemCount: categoryJson.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 5,
                          crossAxisCount: 3,
                          mainAxisSpacing: 10),
                      itemBuilder: (BuildContext context, int index) {
                        return homeBoxValueCategory(
                          categoryJson[index]['CategoryID'].toString(),
                          context,
                          icons[index].toString(),
                          icons[index].toString(),
                          categoryJson[index]['CategoryName'].toString(),
                        );
                      },
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child:

                  //   Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //     children: <Widget>[
                  //       // rowSection(
                  //       //     context,
                  //       //     'images/orequest.png',
                  //       //     'images-white/orequest.png',
                  //       //     'Online Request',
                  //       //     "/onlineRequest"),
                  //       homeBoxValue(
                  //         context,
                  //         'images/erequest.png',
                  //         'images-white/erequest.png',
                  //         'Appeals',
                  //       ),
                  //       homeBoxValue(
                  //         context,
                  //         'images/rgpa.png',
                  //         'images-white/rgpa.png',
                  //         'Change of Major',
                  //       ),
                  //       homeBoxValue(
                  //         context,
                  //         'images/attendance.png',
                  //         'images-white/attendance.png',
                  //         'Current Semeter',
                  //       ),
                  //       // homeBox(
                  //       //   context,
                  //       //   'images-white/assessment.png',
                  //       //   'images/assessment.png',
                  //       //   "/assessmentMarkCourses",
                  //       //   'Assessment',
                  //       // ),
                  //       // homeBox(
                  //       //   context,
                  //       //   'images-white/result.png',
                  //       //   'images/result.png',
                  //       //   "/homeResult",
                  //       //   'Result',
                  //       // ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: <Widget>[
                  //       // homeBox(
                  //       //   context,
                  //       //   'images-white/class.png',
                  //       //   'images/class.png',
                  //       //   "/HomeClass",
                  //       //   'Classes',
                  //       // ),
                  //       // homeBox(
                  //       //   context,
                  //       //   'images-white/advisor.png',
                  //       //   'images/advisor.png',
                  //       //   "/myAdvisor",
                  //       //   'Advisor',
                  //       // ),
                  //       // homeBox(
                  //       //   context,
                  //       //   'images-white/fees.png',
                  //       //   'images/fees.png',
                  //       //   "/HomeFees",
                  //       //   'Fees',
                  //       // ),
                  //       homeBoxValue(
                  //         context,
                  //         'images/aptitude.png',
                  //         'images-white/aptitude.png',
                  //         'Duplicate Documents',
                  //       ),
                  //       homeBoxValue(
                  //         context,
                  //         'images/gpa.png',
                  //         'images-white/gpa.png',
                  //         'Certificates',
                  //       ),
                  //       homeBoxValue(
                  //         context,
                  //         'images/visitor.png',
                  //         'images-white/visitor.png',
                  //         'Exams',
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: GridView.builder(
                  //     itemCount: categoryJson.length,
                  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //         crossAxisCount: 3),
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return new Card(
                  //         child: new GridTile(
                  //           footer: new Text(
                  //               categoryJson[index]['CategsoryName']),
                  //           child: new Text(categoryJson[index][
                  //               'CategoryID']), //just for testing, will fill with image later
                  //         ),
                  //       );
                  //     },
                  //   ),

                  //   // Row(
                  //   //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   //   children: <Widget>[
                  //   //     homeBoxValue(
                  //   //       context,
                  //   //       'images/assessment.png',
                  //   //       'images-white/assessment.png',
                  //   //       'Forms',
                  //   //     ),
                  //   //     homeBoxValue(
                  //   //       context,
                  //   //       'images/fees.png',
                  //   //       'images-white/fees.png',
                  //   //       'Scholarships',
                  //   //     ),
                  //   //     homeBoxValue(
                  //   //       context,
                  //   //       'images/orequest.png',
                  //   //       'images-white/orequest.png',
                  //   //       'Fine',
                  //   //     ),
                  //   //   ],
                  //   // ),
                  // ),
                  // Image.asset(
                  //   isDark(context)
                  //       ? 'images-white/logo.png'
                  //       : 'images/logo.png',
                  //   height: 100,
                  //   width: 230,
                  // ),
                ],
              ),
            ],
          ),
        )
        // : studentJson['data']['user_type'] == "STF"
        //     ? Container(
        //         child: ListView(
        //           children: <Widget>[
        //             SizedBox(
        //               height: 20,
        //             ),
        //             Column(
        //               children: <Widget>[
        //                 SizedBox(
        //                   height: 10,
        //                 ),
        //                 Padding(
        //                   padding: const EdgeInsets.all(10.0),
        //                   child: Row(
        //                     mainAxisAlignment:
        //                         MainAxisAlignment.spaceAround,
        //                     children: <Widget>[
        //                       homeBox(
        //                         context,
        //                         'images-white/erequest.png',
        //                         'images/erequest.png',
        //                         "/HomeERequest",
        //                         'E-Request',
        //                       ),
        //                       homeBox(
        //                         context,
        //                         'images-white/contactslist.png',
        //                         'images/contactslist.png',
        //                         "/ContactList",
        //                         'Contact List',
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //                 Image.asset(
        //                   'images/logo.png',
        //                   height: 150,
        //                   width: 230,
        //                 ),
        //               ],
        //             ),
        //           ],
        //         ),
        //       )
        //     : studentJson['data']['user_type'] == "FAC"
        //         ? Container(
        //             child: ListView(
        //               children: <Widget>[
        //                 SizedBox(
        //                   height: 20,
        //                 ),
        //                 FittedBox(
        //                   child: Column(
        //                     children: <Widget>[
        //                       Padding(
        //                         padding: const EdgeInsets.all(10.0),
        //                         child: Row(
        //                           mainAxisAlignment:
        //                               MainAxisAlignment.spaceBetween,
        //                           children: <Widget>[
        //                             homeBox(
        //                               context,
        //                               'images-white/allocation.png',
        //                               'images/allocation.png',
        //                               "/courseAllocation",
        //                               'Courses',
        //                             ),
        //                             homeBox(
        //                               context,
        //                               'images-white/advisor.png',
        //                               'images/advisor.png',
        //                               "/advisors",
        //                               'Advisors',
        //                             ),
        //                             homeBox(
        //                               context,
        //                               'images-white/erequest.png',
        //                               'images/erequest.png',
        //                               "/HomeERequest",
        //                               'E-Request',
        //                             ),
        //                           ],
        //                         ),
        //                       ),
        //                       Padding(
        //                         padding: const EdgeInsets.all(10.0),
        //                         child: Row(
        //                           mainAxisAlignment:
        //                               MainAxisAlignment.spaceBetween,
        //                           children: <Widget>[
        //                             homeBox(
        //                               context,
        //                               'images-white/contactslist.png',
        //                               'images/contactslist.png',
        //                               "/ContactList",
        //                               'ContactList',
        //                             ),
        //                             homeBox(
        //                               context,
        //                               'images-white/cdp.png',
        //                               'images/cdp.png',
        //                               "/cdpFaculty",
        //                               'CDP',
        //                             ),
        //                           ],
        //                         ),
        //                       ),
        //                       Image.asset(
        //                         'images/logo.png',
        //                         height: 150,
        //                         width: 230,
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           )
        //         : SizedBox(),
        ,
        appBar: appBarLoginImage(context));
  }

  Future getCategoryJson() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      http.Response response = await http.post(
        Uri.parse(
            "https://skylineportal.com/moappad/api/test/onlineRequestCategory"),
        headers: {
          "API-KEY": API,
        },
      ).timeout(Duration(seconds: 50));

      if (response.statusCode == 200) {
        setState(() {
          categoryJson = json.decode(response.body)['data'];
          // cdpCourseMessageJson = json.decode(response.body);
          isLoading = false;
        });
        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getCategoryJson);
      } else {
        showLoading(false, context);

        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getCategoryJson);
      }
    }
  }
}

// categoryJson
