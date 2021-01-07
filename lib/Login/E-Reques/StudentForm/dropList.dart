import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Global/lists.dart';

class DropList extends StatefulWidget {
  final String type;
  final String empId;
  final String departmentID;

  const DropList({Key key, this.type, this.empId, this.departmentID})
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
        appBar: appBarLogin(context, 'Online Request'),
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
                      itemsToShow[index][title],
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
          body = {};
        }

        break;
      case 'GeneralAppointmentDate':
        {
          body = {
            'user_id': username,
            'emp_no': widget.empId,
            'department': widget.departmentID,
          };
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
          url =
              'https://skylineportal.com/moappad/api/test/GeneralApptCatDeptTime';
        }
        break;
      case 'GeneralAppointmentDate':
        {
          url = 'https://skylineportal.com/moappad/api/test/GeneralApptDate';
        }
        break;
      case 'suggestions':
        {
          url =
              'https://skylineportal.com/moappad/api/test/GeneralApptCatDeptTime';
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
      default:
        {
          url =
              'https://skylineportal.com/moappad/api/test/OnlineRequestOnline';
        }
    }

    switch (widget.type) {
      case 'GeneralAppointmentCategory':
        {
          title = 'CATEGORY_DESCRIPTION';
        }
        break;
      case 'GeneralAppointmentTime':
        {
          title = 'timevalue';
        }
        break;
      case 'GeneralAppointmentDate':
        {
          title = 'Dates';
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
              case 'GeneralAppointmentDepartment':
                {
                  fileJson = json.decode(response.body)['data']['department'];
                }
                break;
              case 'GeneralAppointmentTime':
                {
                  fileJson = json.decode(response.body)['data']['time'];
                }
                break;
              case 'GeneralAppointmentDate':
                {
                  fileJson = json.decode(response.body)['data'];
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
