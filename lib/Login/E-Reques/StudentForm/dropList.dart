import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Global/lists.dart';
import 'package:intl/intl.dart';

class DropList extends StatefulWidget {
  final String type;
  final String empId;
  final String departmentID;
  final String selectedDate;

  const DropList(
      {Key key, this.type, this.empId, this.departmentID, this.selectedDate})
      : super(key: key);
  @override
  _DropListState createState() => _DropListState();
}

class _DropListState extends State<DropList> {
  var seachCnt = TextEditingController();
  String url = '';
  List itemsJson = [];
  List itemsToShow = [];
  Map body = {};
  List fileJson = [];
  List fileJsons = [];
  String title = '';

  @override
  void initState() {
    selectedName = "";
    getItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarLogin(context, 'Type Request'),
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              getItems();
            });
          },
          child: itemsJson == null
              ? exception(context, isLoading)
              : CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                        automaticallyImplyLeading: false,
                        expandedHeight: 50.0,
                        snap: true,
                        floating: true,
                        pinned: false,
                        backgroundColor:
                            isDark(context) ? Colors.black : Colors.white,
                        flexibleSpace: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              child: TextField(
                                controller: seachCnt,
                                decoration: InputDecoration(hintText: 'Search'),
                                onChanged: (x) {
                                  selectedName = x;
                                  searchItems();
                                },
                              ),
                            ),
                          ],
                        )),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          // if (itemsToShow[index]['archive'] == '0')

                          return buildItems(index);
                          // else
                          // return SizedBox();
                        },
                        childCount: itemsToShow.length,
                      ),
                    ),
                  ],
                ),
        ));
  }

  buildItems(index) {
    if (widget.type == 'GeneralAppointmentDate') {
      var parsedDate = DateTime.parse(itemsToShow[index][title]);
      DateFormat formatter = DateFormat('yyyy-MM-dd');
      String formatted = formatter.format(parsedDate);

      itemsToShow[index][title] = formatted;
      // print(formatted); // something like 2013-04-20
    }
    return Card(
      // color: itemsToShow[index]['archive'] == '0'
      //     ? Colors.white
      //     : Colors.grey[300],

      child: new Column(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: new Text(
                      itemsToShow[index][title].toString(),
                      // 'packages Name',
                      style: new TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    setState(() {
                      Navigator.pop(context, itemsToShow[index]);
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void searchItems() {
    setState(() {
      itemsToShow = itemsJson.where((i) {
        if (selectedName != "" && !i[title].toString().contains(selectedName))
          return false;

        return true;

        // if(archive==0){}
      }).toList();
    });
  }

  Future getItems() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });
    switch (widget.type) {
      case 'ShortProgram':
        body = {};
        break;
      case 'GeneralAppointmentCategory':
        {
          body = {};
        }
        break;
      case 'GeneralAppointmentDepartment':
        {
          body = {};
        }
        break;
      case 'GeneralAppointmentTime':
        {
          body = {
            'AppointMentDate': widget.selectedDate.toString(),
            'EMPNUMBER': widget.empId,
            'OPERATION': 'TIME'
          };
        }

        break;
      case 'GeneralAppointmentDate':
        {
          body = {
            'AppointMentDate':
                DateFormat("yyyy-MM-dd").format(DateTime.now()).toString(),
            'EMPNUMBER': widget.empId,
            'OPERATION': 'DATES'
          };
        }
        break;
      case 'Nationality':
        {
          body = {};
        }
        break;
      case 'Program':
        {
          body = {};
        }
        break;
      default:
        {
          body = {
            'user_id': username,
            'Operation': widget.type,
          };
        }
    }
    switch (widget.type) {
      case 'ShortProgram':
        {
          url = 'https://skylineportal.com/moappad/api/test/visitorCourses';
        }
        break;
      case 'Organization':
        {
          url =
              'https://skylineportal.com/moappad/api/test/VisitorInformationProgramAndCountries';
        }
        break;
      case 'title':
        {
          url =
              'https://skylineportal.com/moappad/api/test/VisitorInformationProgramAndCountries';
        }
        break;
      case 'countries':
        {
          url =
              'https://skylineportal.com/moappad/api/test/VisitorInformationProgramAndCountries';
        }
        break;
      case 'programEn':
        {
          url =
              'https://skylineportal.com/moappad/api/test/VisitorInformationProgramAndCountries';
        }
        break;
      case 'Qualification':
        {
          url =
              'https://skylineportal.com/moappad/api/test/VisitorInformationProgramAndCountries';
        }
        break;

      case 'GeneralAppointmentDepartment':
        {
          url =
              'https://skylineportal.com/moappad/api/test/GeneralApptCatDeptTime';
        }
        break;

      case 'GeneralAppointmentCategory':
        {
          url =
              'https://skylineportal.com/moappad/api/test/GeneralApptCatDeptTime';
        }
        break;
      case 'GeneralAppointmentTime':
        {
          url = 'https://skylineportal.com/moappad/api/test/GeneralApptDates';
        }
        break;
      case 'GeneralAppointmentDate':
        {
          url = 'https://skylineportal.com/moappad/api/test/GeneralApptDates';
        }
        break;

      case 'suggestions':
        {
          url =
              'https://skylineportal.com/moappad/api/test/GeneralApptCatDeptTime';
        }
        break;
      case 'complaints':
        {
          url =
              'https://skylineportal.com/moappad/api/test/GeneralApptCatDeptTime';
        }
        break;
      case 'Nationality':
        {
          url =
              'https://skylineportal.com/moappad/api/test/getAptitudeProgramAndNationality';
        }

        break;
      case 'know':
        {
          url = 'https://skylineportal.com/moappad/api/test/knowUs';
        }
        break;
      case 'Program':
        {
          url =
              'https://skylineportal.com/moappad/api/test/getAptitudeProgramAndNationality';
        }
        break;
      case 'Country':
        {
          url =
              'https://skylineportal.com/moappad/api/test/AdmissionFormDropdownRecords';
        }
        break;
      // case 'program':
      //   {
      //     url =
      //         'https://skylineportal.com/moappad/api/test/AdmissionFormDropdownRecords';
      //   }
      //   break;
      default:
        {
          url =
              'https://skylineportal.com/moappad/api/test/OnlineRequestOnline';
        }
    }

    switch (widget.type) {
      case 'ShortProgram':
        {
          title = 'courseEn';
        }
        break;
      case 'Country':
        {
          title = 'NationalityName';
        }
        break;
      case 'program':
        {
          title = 'DegreeType_Desc';
        }
        break;

      case 'GeneralAppointmentCategory':
        {
          title = 'CATEGORY_DESCRIPTION';
        }
        break;
      case 'GeneralAppointmentTime':
        {
          title = 'Session_TIME';
        }
        break;
      case 'GeneralAppointmentDate':
        {
          title = 'DateCol';
        }
        break;
      case 'GeneralAppointmentDepartment':
        {
          title = 'Department';
        }
        break;

      case 'suggestions':
        {
          title = 'CATEGORY_DESCRIPTION';
        }
        break;
      case 'complaints':
        {
          title = 'CATEGORY_DESCRIPTION';
        }
        break;
      case 'GeneralAppointmentCategory':
        {
          title = 'CATEGORY_DESCRIPTION';
        }
        break;

      case 'Nationality':
        {
          title = 'NationalityName';
        }
        break;
      // case 'Program':
      //   {
      //     title = 'DegreeType_Desc';
      //   }
      //   break;
      case 'know':
        {
          title = 'know';
        }
        break;

      case 'Organization':
        {
          title = 'organizationNameAr';
        }
        break;
      case 'title':
        {
          title = 'title';
        }
        break;
      case 'countries':
        {
          title = 'country_enName';
        }
        break;
      case 'programEn':
        {
          title = 'programEn';
        }
        break;
      case 'Qualification':
        {
          title = 'qualificationEn';
        }
        break;
      default:
        {
          title = 'MiscName';
        }
    }
    try {
      final response = await http.post(
        Uri.encodeFull(url),
        headers: {
          "API-KEY": API,
        },
        body: body,
      );
      if (response.statusCode == 200) {
        setState(
          () {
            // loading = false;

            switch (widget.type) {
              case 'ShortProgram':
                {
                  fileJson = json.decode(response.body)['data'];
                }
                break;
              case 'Country':
                {
                  fileJson = json.decode(response.body)['data']['countries'];
                }
                break;
              case 'program':
                {
                  fileJson = json.decode(response.body)['data']['program'];
                }
                break;
              case 'suggestions':
                {
                  fileJson = json.decode(response.body)['data']['category'];
                }
                break;
              case 'complaints':
                {
                  fileJson = json.decode(response.body)['data']['category'];
                }
                break;

              case 'GeneralAppointmentCategory':
                {
                  fileJson = json.decode(response.body)['data']['category'];
                }
                break;
              case 'title':
                {
                  fileJson = json.decode(response.body)['data']['title'];
                }
                break;
              case 'countries':
                {
                  fileJson = json.decode(response.body)['data']['countries'];
                }
                break;
              case 'programEn':
                {
                  fileJson = json.decode(response.body)['data']['programEn'];
                }
                break;
              case 'Qualification':
                {
                  fileJson =
                      json.decode(response.body)['data']['qualificationEn'];
                }
                break;
              case 'Organization':
                {
                  fileJson = json.decode(response.body)['data']['organization'];
                }
                break;
              case 'Nationality':
                {
                  fileJson = json.decode(response.body)['data']['nationality'];
                }
                break;
              case 'know':
                {
                  fileJson = json.decode(response.body)['data'];
                }
                break;

              // case 'Program':
              //   {
              //     fileJson = json.decode(response.body)['data']['programs'];
              //   }
              //   break;

              case 'GeneralAppointmentDepartment':
                {
                  fileJson = json.decode(response.body)['data']['department'];
                }
                break;
              case 'GeneralAppointmentTime':
                {
                  fileJson = json.decode(response.body)['data'];
                }
                break;
              case 'GeneralAppointmentDate':
                {
                  fileJson = json.decode(response.body)['data'];

                  // DateTime now = json.decode(response.body)['data']['DateCol'];
                  // DateFormat formatter = DateFormat('yyyy-MM-dd');
                  // String formatted = formatter.format(now);
                  // print(formatted); // something like 2013-04-20

                }
                break;
              default:
                {
                  fileJson = json.decode(response.body)['data'];
                }
            }
            itemsJson = fileJson;

            itemsToShow = itemsJson;
            selectedName = '';
            seachCnt.text = '';
          },
        );

        showLoading(false, context);
      }
    } catch (x) {
      print(x);
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getItems);
      } else {
        showLoading(false, context);
        showError(
            "Sorry, we can't connect", Icons.perm_scan_wifi, context, getItems);
      }
    }
  }
}
