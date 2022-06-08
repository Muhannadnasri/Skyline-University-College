import 'package:flutter/material.dart';

import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Global/homeBox.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: studentJson['data']['user_type'] == "STUDENT"
            ? Container(
                color: isDark(context) ? Color(0xFF121212) : Colors.grey[100],
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10.0),
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    FittedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                // rowSection(
                                //     context,
                                //     'images/orequest.png',
                                //     'images-white/orequest.png',
                                //     'Online Request',
                                //     "/onlineRequest"),
                                homeBoxValue(
                                  context,
                                  'images/erequest.png',
                                  'images-white/erequest.png',
                                  'Appeals',
                                ),
                                homeBoxValue(
                                  context,
                                  'images/rgpa.png',
                                  'images-white/rgpa.png',
                                  'Change of Major',
                                ),
                                homeBoxValue(
                                  context,
                                  'images/attendance.png',
                                  'images-white/attendance.png',
                                  'Current Semeter',
                                ),
                                // homeBox(
                                //   context,
                                //   'images-white/assessment.png',
                                //   'images/assessment.png',
                                //   "/assessmentMarkCourses",
                                //   'Assessment',
                                // ),
                                // homeBox(
                                //   context,
                                //   'images-white/result.png',
                                //   'images/result.png',
                                //   "/homeResult",
                                //   'Result',
                                // ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                // homeBox(
                                //   context,
                                //   'images-white/class.png',
                                //   'images/class.png',
                                //   "/HomeClass",
                                //   'Classes',
                                // ),
                                // homeBox(
                                //   context,
                                //   'images-white/advisor.png',
                                //   'images/advisor.png',
                                //   "/myAdvisor",
                                //   'Advisor',
                                // ),
                                // homeBox(
                                //   context,
                                //   'images-white/fees.png',
                                //   'images/fees.png',
                                //   "/HomeFees",
                                //   'Fees',
                                // ),
                                homeBoxValue(
                                  context,
                                  'images/aptitude.png',
                                  'images-white/aptitude.png',
                                  'Duplicate Documents',
                                ),
                                homeBoxValue(
                                  context,
                                  'images/gpa.png',
                                  'images-white/gpa.png',
                                  'Certificates',
                                ),
                                homeBoxValue(
                                  context,
                                  'images/visitor.png',
                                  'images-white/visitor.png',
                                  'Exams',
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                homeBoxValue(
                                  context,
                                  'images/assessment.png',
                                  'images-white/assessment.png',
                                  'Forms',
                                ),
                                homeBoxValue(
                                  context,
                                  'images/fees.png',
                                  'images-white/fees.png',
                                  'Scholarships',
                                ),
                                homeBoxValue(
                                  context,
                                  'images/orequest.png',
                                  'images-white/orequest.png',
                                  'Fine',
                                ),
                              ],
                            ),
                          ),
                          Image.asset(
                            isDark(context)
                                ? 'images-white/logo.png'
                                : 'images/logo.png',
                            height: 100,
                            width: 230,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : studentJson['data']['user_type'] == "STF"
                ? Container(
                    child: ListView(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  homeBox(
                                    context,
                                    'images-white/erequest.png',
                                    'images/erequest.png',
                                    "/HomeERequest",
                                    'E-Request',
                                  ),
                                  homeBox(
                                    context,
                                    'images-white/contactslist.png',
                                    'images/contactslist.png',
                                    "/ContactList",
                                    'Contact List',
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(
                              'images/logo.png',
                              height: 150,
                              width: 230,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : studentJson['data']['user_type'] == "FAC"
                    ? Container(
                        child: ListView(
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            FittedBox(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        homeBox(
                                          context,
                                          'images-white/allocation.png',
                                          'images/allocation.png',
                                          "/courseAllocation",
                                          'Courses',
                                        ),
                                        homeBox(
                                          context,
                                          'images-white/advisor.png',
                                          'images/advisor.png',
                                          "/advisors",
                                          'Advisors',
                                        ),
                                        homeBox(
                                          context,
                                          'images-white/erequest.png',
                                          'images/erequest.png',
                                          "/HomeERequest",
                                          'E-Request',
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        homeBox(
                                          context,
                                          'images-white/contactslist.png',
                                          'images/contactslist.png',
                                          "/ContactList",
                                          'ContactList',
                                        ),
                                        homeBox(
                                          context,
                                          'images-white/cdp.png',
                                          'images/cdp.png',
                                          "/cdpFaculty",
                                          'CDP',
                                        ),
                                      ],
                                    ),
                                  ),
                                  Image.asset(
                                    'images/logo.png',
                                    height: 150,
                                    width: 230,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(),
        appBar: appBarLoginImage(context));
  }
}
