import 'dart:convert';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/form.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(AirTicketRequest());

class AirTicketRequest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AirTicketRequestState();
  }
}

final _airTicketRequest = GlobalKey<FormState>();

// Map<String, int> body;

class _AirTicketRequestState extends State<AirTicketRequest> {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final initialValue = DateTime.now();

  // String from;
  String fromCityOutbond = '';
  String fromCityInbond = '';
  String toCityInbond = '';
  String toCityOutbond = '';

  String remark = '';
  String toTimeOutbound;

  String fromTimeOutbound;

  List personalFamilyTimesJson = [];
  Map leaveBalanceJson = {};

  List personalFamilyFamilyJson = [];
  Map leaveApplicationJson = {};

  Map leaveHolidayJson = {};
  List personalFamilyPersonalJson = [];

  Map personalFamilyTimesMessageJson = {};

  int groupValue;
  String leaveType;

  //

  @override
  void initState() {
    super.initState();
    getPersonalFamilyTimes();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: appBarLogin(context, 'Air Ticket Request'),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          color: Colors.white,
          child: ListView.builder(
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    Container(
                      child: Text('OutBound'),
                    ),
                    Card(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Text(''),
                          ),
                          Form(
                            key: _airTicketRequest,
                            child: Column(
                              children: <Widget>[
                                globalForms(context, '', (String value) {
                                  if (value.trim().isEmpty) {
                                    return 'From is required';
                                  }
                                  return null;
                                }, (x) {
                                  setState(() {
                                    fromCityOutbond = x;
                                  });
                                }, 'From City', true, TextInputType.text,
                                    FontAwesomeIcons.mapMarked, Colors.blue),
                                globalForms(context, '', (String value) {
                                  if (value.trim().isEmpty) {
                                    return 'To is required';
                                  }
                                  return null;
                                }, (x) {
                                  setState(() {
                                    toCityOutbond = x;
                                  });
                                }, 'To City', true, TextInputType.text,
                                    FontAwesomeIcons.mapMarkedAlt, Colors.blue),
                                datePickers(context, (date) {
                                  toCityOutbond = date.toString();
                                }, 'Leave To'),
                              ],
                            ),
                          ),
                          Container(),
                        ],
                      ),
                    ),
                    Container(
                      child: Text('InBound'),
                    ),
                    Card(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Text(''),
                          ),
                          Form(
                            child: Column(
                              children: <Widget>[
                                globalForms(context, '', (String value) {
                                  if (value.trim().isEmpty) {
                                    return 'From is required';
                                  }
                                  return null;
                                }, (x) {
                                  setState(() {
                                    fromCityInbond = x;
                                  });
                                }, 'From City', true, TextInputType.text,
                                    FontAwesomeIcons.mapMarked, Colors.blue),
                                globalForms(context, '', (String value) {
                                  if (value.trim().isEmpty) {
                                    return 'To is required';
                                  }
                                  return null;
                                }, (x) {
                                  setState(() {
                                    toCityInbond = x;
                                  });
                                }, 'To City', true, TextInputType.text,
                                    FontAwesomeIcons.mapMarkedAlt, Colors.blue),
                                datePickers(context, (date) {
                                  toCityInbond = date.toString();
                                }, 'Leave To'),
                              ],
                            ),
                          ),
                          Container(),
                        ],
                      ),
                    ),
                    Form(
                      child: globalForms(context, '', (String value) {
                        if (value.trim().isEmpty) {
                          return 'Remark is required';
                        }
                        return null;
                      }, (x) {
                        setState(() {
                          remark = x;
                        });
                      }, 'Remarks', true, TextInputType.text,
                          FontAwesomeIcons.question, Colors.blue),
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }

  Future getPersonalFamilyTimes() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });
    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getPersonalFamilyTimes'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'emp_id': studentJson['data']['user_id'],
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            personalFamilyPersonalJson =
                json.decode(response.body)['data']['personal'];
            personalFamilyFamilyJson =
                json.decode(response.body)['data']['family'];

            personalFamilyTimesJson =
                json.decode(response.body)['data']['times'];

            personalFamilyTimesMessageJson = json.decode(response.body);
          },
        );
        showLoading(false, context);
      }
    } catch (x) {
      print(x);
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getPersonalFamilyTimes);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getPersonalFamilyTimes);
      }
    }
  }

  Future getAirTicketRequest() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/airlineTicketReimbursement'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'EmoNumber': studentJson['data']['user_id'],
          'LeaveFrom': fromTimeOutbound,
          'LeaveTo': toTimeOutbound,
          'Placefrom': fromCityInbond,
          'Placefrom1': fromCityOutbond,
          'Placeto': toCityOutbond,
          'Placeto1': toCityInbond,
          'Remarks': remark,
          'Day': '',
          'Day1': '',
          'Time': '',
          'Time1': '',
          'LoginIp': '1',
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            leaveHolidayJson = json.decode(response.body);
          },
        );
        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getPersonalFamilyTimes);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getPersonalFamilyTimes);
      }
    }
  }

  Widget datePickers(BuildContext context, onSaved, labelText) {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
        child: DateTimeField(
          format: format,
          onShowPicker: (context, currentValue) async {
            final date = await showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2100));
            if (date != null) {
              final time = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );
              return DateTimeField.combine(date, time);
            } else {
              return currentValue;
            }
          },
          // validator: validator,
          initialValue: initialValue,
          onSaved: onSaved,
          readOnly: true,
          decoration: InputDecoration(
            labelText: labelText,
            icon: Icon(
              Icons.date_range,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    ]);
  }
}
