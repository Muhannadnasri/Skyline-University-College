import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/bottomAppBar.dart';
import 'package:skyline_university/Global/formVisitor.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Login/E-Reques/StudentForm/dropList.dart';
import 'package:toggle_switch/toggle_switch.dart';

void main() => runApp(VisitorInfo());

class VisitorInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VisitorInfoState();
  }
}

class _VisitorInfoState extends State<VisitorInfo> {
  final visitor = GlobalKey<FormState>();

  var titleNameCnt = TextEditingController();
  var nationalityNameCnt = TextEditingController();
  var programNameCnt = TextEditingController();
  var qualificationNameCnt = TextEditingController();
  var organizationNameCnt = TextEditingController();
  var shortProgramNameCnt = TextEditingController();
  int initialIndex = 0;
  String languageStudied = 'English';
  Map visitorInformationFormJson = {};

  String name = '';
  String mobile = '';
  String facebookId = '';
  String email = '';
  String event = '';
  String other = '';

  String major = '';
  String school = '';
  String occupation = '';
  String organizationName = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      bottomNavigationBar: bottomappBar(
        context,
        () {
          setState(() {
            if (visitor.currentState.validate()) {
              visitor.currentState.save();

              setState(() {
                sendVisitorInformationForm();
              });
            }
          });
        },
      ),
      appBar: appBarLogin(
        context,
        'Visitor Information',
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Form(
                key: visitor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleWidget(),
                    formVisitor(
                      context,
                      (String value) {
                        if (value.isEmpty) {
                          return 'Your Name is required';
                        }
                        return null;
                      },
                      (x) {
                        setState(() {
                          name = x;
                        });
                      },
                      'Name',
                      TextInputType.text,
                    ),
                    formVisitor(
                      context,
                      (String value) {
                        if (!isNumeric(value)) {
                          return 'Your Mobile Number  is required';
                        }
                        return null;
                      },
                      (x) {
                        setState(() {
                          mobile = x;
                        });
                      },
                      'Mobile',
                      TextInputType.number,
                    ),
                    formVisitor(
                      context,
                      (String value) {
                        if (value.trim().isEmpty) {
                          return 'Your Facebook ID is required';
                        }
                        return null;
                      },
                      (x) {
                        setState(() {
                          facebookId = x;
                        });
                      },
                      'Facebook ID',
                      TextInputType.text,
                    ),
                    formVisitor(
                      context,
                      (String value) {
                        if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return 'Your Email is required';
                        }
                        return null;
                      },
                      (x) {
                        setState(() {
                          email = x;
                        });
                      },
                      'Email',
                      TextInputType.emailAddress,
                    ),
                    formVisitor(context, (String value) {
                      if (value.trim().isEmpty) {
                        return 'Your Facebook ID is required';
                      }
                      return null;
                    }, (x) {
                      setState(() {
                        event = x;
                      });
                    }, 'Event', TextInputType.text),
                    nationalityWidget(),
                    programWidget(),
                    shortProgramWidget(),
                    formVisitor(
                      context,
                      (String value) {
                        return null;
                      },
                      (x) {
                        setState(() {
                          other = x;
                        });
                      },
                      'Other , Please Specify',
                      TextInputType.text,
                    ),
                    switchlanguage(),
                    formVisitor(
                      context,
                      (String value) {
                        if (value.trim().length < 4) {
                          return 'Your Major is required';
                        }
                        return null;
                      },
                      (x) {
                        setState(() {
                          major = x;
                        });
                      },
                      'Specific Major/Emphasis/Short Course',
                      TextInputType.text,
                    ),
                    formVisitor(
                      context,
                      (String value) {
                        if (value.trim().isEmpty) {
                          return 'Your School is required';
                        }
                        return null;
                      },
                      (x) {
                        setState(() {
                          school = x;
                        });
                      },
                      'Name Of School/University',
                      TextInputType.text,
                    ),
                    qualificationWidget(),
                    formVisitor(
                      context,
                      (String value) {
                        if (value.trim().isEmpty) {
                          return 'Your Job Occupation is required';
                        }
                        return null;
                      },
                      (x) {
                        setState(() {
                          occupation = x;
                        });
                      },
                      'Current Occupation',
                      TextInputType.text,
                    ),
                    formVisitor(
                      context,
                      (String value) {
                        if (value.trim().isEmpty) {
                          return 'Your Organization Name is required';
                        }
                        return null;
                      },
                      (x) {
                        setState(() {
                          organizationName = x;
                        });
                      },
                      'Name of The Organization',
                      TextInputType.text,
                    ),
                    organizationWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget titleWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Title',
          style:
              TextStyle(color: isDark(context) ? Colors.white : Colors.black),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DropList(
                  type: 'title',
                ),
              ),
            ).then((val) async {
              setState(() {
                // miscName = val['MiscName'];
                // miscID = val['MiscID'];
                titleNameCnt.text = val['title'];
              });
            });
          },
          child: AbsorbPointer(
            child: TextFormField(
              validator: (x) => x.isEmpty ? "Please select title" : null,
              controller: titleNameCnt,
            ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }

  Widget nationalityWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nationality',
          style:
              TextStyle(color: isDark(context) ? Colors.white : Colors.black),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DropList(
                  type: 'countries',
                ),
              ),
            ).then((val) async {
              setState(() {
                // miscName = val['MiscName'];
                // miscID = val['MiscID'];
                nationalityNameCnt.text = val['country_enName'];
              });
            });
          },
          child: AbsorbPointer(
            child: TextFormField(
              validator: (x) =>
                  x.isEmpty ? "Please select your nationality" : null,
              controller: nationalityNameCnt,
            ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }

  Widget programWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Program',
          style:
              TextStyle(color: isDark(context) ? Colors.white : Colors.black),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DropList(
                  type: 'programEn',
                ),
              ),
            ).then((val) async {
              setState(() {
                // miscName = val['MiscName'];
                // miscID = val['MiscID'];
                programNameCnt.text = val['programEn'];
              });
            });
          },
          child: AbsorbPointer(
            child: TextFormField(
              validator: (x) => x.isEmpty ? "Please select program" : null,
              controller: programNameCnt,
            ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }

  Widget shortProgramWidget() {
    if (programNameCnt.text.toString() == 'SHORT TERM COURSE') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ShortProgram',
            style:
                TextStyle(color: isDark(context) ? Colors.white : Colors.black),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DropList(
                    type: 'ShortProgram',
                  ),
                ),
              ).then((val) async {
                setState(() {
                  // miscName = val['MiscName'];
                  // miscID = val['MiscID'];
                  shortProgramNameCnt.text = val['courseEn'];
                });
              });
            },
            child: AbsorbPointer(
              child: TextFormField(
                validator: (x) =>
                    x.isEmpty ? "Please select Short Program" : null,
                onChanged: (x) {
                  setState(() {
                    // isEditing = true;
                  });
                },
                controller: shortProgramNameCnt,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
        ],
      );
    } else {
      return SizedBox();
    }
  }

  Widget qualificationWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Qualification',
          style:
              TextStyle(color: isDark(context) ? Colors.white : Colors.black),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DropList(
                  type: 'Qualification',
                ),
              ),
            ).then((val) async {
              setState(() {
                // miscName = val['MiscName'];
                // miscID = val['MiscID'];
                qualificationNameCnt.text = val['qualificationEn'];
              });
            });
          },
          child: AbsorbPointer(
            child: TextFormField(
              validator: (x) =>
                  x.isEmpty ? "Please select Qualification" : null,
              controller: qualificationNameCnt,
            ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }

  Widget switchlanguage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mode Of Teaching',
          style:
              TextStyle(color: isDark(context) ? Colors.white : Colors.black),
        ),
        SizedBox(
          height: 10,
        ),
        ToggleSwitch(
          // minWidth: .0,
          minWidth: 100,
          minHeight: 40,

          icons: [Icons.language, Icons.language],
          initialLabelIndex: initialIndex,
          cornerRadius: 15.0,
          activeFgColor: Colors.white,
          inactiveBgColor: Colors.grey,
          inactiveFgColor: Colors.white,
          labels: ['English', 'Arabic'],
          activeBgColors: [Colors.green, Colors.red],
          onToggle: (index) {
            print('switched to: $index');
            setState(() {
              initialIndex = index;
              switch (initialIndex) {
                case 0:
                  {
                    setState(() {
                      languageStudied = 'English';
                    });
                  }

                  break;
                case 1:
                  {
                    setState(() {
                      languageStudied = 'Arabic';
                    });
                  }
                  break;
                default:
                  {
                    setState(() {
                      languageStudied = 'English';
                    });
                  }
              }
            });
          },
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }

  Widget organizationWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Organization',
          style:
              TextStyle(color: isDark(context) ? Colors.white : Colors.black),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DropList(
                  type: 'Organization',
                ),
              ),
            ).then((val) async {
              setState(() {
                // miscName = val['MiscName'];
                // miscID = val['MiscID'];
                organizationNameCnt.text = val['organizationNameAr'];
              });
            });
          },
          child: AbsorbPointer(
            child: TextFormField(
              validator: (x) => x.isEmpty ? "Please select Organization" : null,
              controller: organizationNameCnt,
            ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }

  Future sendVisitorInformationForm() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
          Uri.encodeFull(
              'https://skylineportal.com/moappad/api/test/visitorInformationForm'),
          headers: {
            "API-KEY": API,
          },
          body: {
            "name": name,
            "title": titleNameCnt.text.toString(),
            "other": programNameCnt.text.toString() == null ||
                    programNameCnt.text.toString() == null
                ? other
                : '',
            "shortCourse": shortProgramNameCnt.text.toString(),
            "mobile": mobile,
            "facebookId": facebookId,
            "email": email,
            "event": event,
            "programOfInterest": programNameCnt.text.toString(),
            "modeOfTeaching": languageStudied,
            "specificMajor": major,
            "nameOfSchoolUniversity": school,
            "level": qualificationNameCnt.text.toString(),
            "currentOccupation": occupation,
            "nameOfOrganization": organizationName,
            "typeOfOrganization": organizationNameCnt.text.toString(),
            "language": 'EN',
          }).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            visitorInformationFormJson = json.decode(response.body);
          },
        );
        showLoading(false, context);
        if (visitorInformationFormJson['success'] == '0') {
          showfailureSnackBar(context, visitorInformationFormJson['message']);
        }
        if (visitorInformationFormJson['success'] == '1') {
          showSuccessSnackBar(context, visitorInformationFormJson['message']);
        }
      }
    } catch (x) {
      print(x);
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, sendVisitorInformationForm);
        // showErrorServer(context, getAdmissionFormDropdownRecords());
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            sendVisitorInformationForm);
        // showErrorConnect(context, getAdmissionFormDropdownRecords());
      }
    }
  }
}
