import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/bottomAppBar.dart';
import 'package:skyline_university/Global/form.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(OnlineRequest());

class OnlineRequest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OnlineRequestState();
  }
}

final _onlineRequest = GlobalKey<FormState>();

// Map<String, int> body;

class _OnlineRequestState extends State<OnlineRequest> {
  List onlineRequestTypeJson = [];
  Map onlineRequestTypeMessageJson = {};
  Map onlineRequestJson = {};
  Map requestAmountJson = {};
  String address = '';
  String remark = '';

  int groupValue;
  String item;

  @override
  void initState() {
    super.initState();
    onlineRequestTypeJson = [];


    getRequestType();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      bottomNavigationBar: bottomappBar(
        context,
        () {
          if (_onlineRequest.currentState.validate() && item != null) {
            _onlineRequest.currentState.save();
            getOnlineRequest();
          } else {
            return showErrorInput('Please check your input');
          }

     
        },
      ),
      appBar: appBarLogin(context, 'Online Request'),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          color: Colors.grey[300],
          child: Container(
            color: Colors.grey[300],
            child: ListView(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Request Type',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        DropdownButton<String>(
                          style: TextStyle(fontSize: 13, color: Colors.black),
                          isExpanded: true,
                          value: item,
                          hint: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Select Option',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          items: onlineRequestTypeJson
                                  ?.map(
                                    (item) => DropdownMenuItem<String>(
                                      value: item['DetailsID'].toString(),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(item['Item'].toString()),
                                      ),
                                    ),
                                  )
                                  ?.toList() ??
                              [],
                          onChanged: (value) {
                            item = value;

                            getAmount();
                          },
                        ),
                      ],
                    ),
                    Card(
                      color: Colors.grey[300],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                height: 30,
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Normal Amount',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(requestAmountJson.isEmpty
                                            ? ''
                                            : requestAmountJson['data']
                                                        ['NormalAmount'] ==
                                                    ("NA")
                                                ? "Not Avalible"
                                                : requestAmountJson['data']
                                                        ['NormalAmount']
                                                    .toString()),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: UnderlineTabIndicator(
                          borderSide: BorderSide(width: 0.4)),
                    ),
                    Card(
                      color: Colors.grey[300],
                      child: Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                height: 30,
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Urgent Amount',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(requestAmountJson.isEmpty
                                      ? ''
                                      : requestAmountJson['data']
                                                  ['UrgentAmount'] ==
                                              ("NA")
                                          ? "Not Avalible"
                                          : requestAmountJson['data']
                                                  ['UrgentAmount']
                                              .toString()),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: UnderlineTabIndicator(
                          borderSide: BorderSide(width: 0.4)),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Form(
                            key: _onlineRequest,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                globalForms(context, '', (String value) {
                                  if (value.trim().isEmpty) {
                                    return 'Address  is required';
                                  }
                                  return null;
                                }, (x) {
                                  setState(() {
                                    address = x;
                                  });
                                }, 'Address', true, TextInputType.text,
                                    FontAwesomeIcons.mapMarkedAlt, Colors.blue),
                                globalForms(context, '', (String value) {
                                  if (value.trim().isEmpty) {
                                    return 'Remark is required';
                                  }
                                  return null;
                                }, (x) {
                                  setState(() {
                                    remark = x;
                                  });
                                }, 'Remark', true, TextInputType.text,
                                    FontAwesomeIcons.phoneAlt, Colors.blue),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.moneyCheck,
                                size: 20,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text("Pay Amount"),
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: <Widget>[
                                  Text('Normal'),
                                  Radio(
                                    value: 1,
                                    groupValue: groupValue,
                                    onChanged: (int e) {
                                      setState(() {
                                        groupValue = e;
                                      });
                                    },
                                    activeColor: Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: <Widget>[
                                  Text('Urgent'),
                                  Radio(
                                    value: 2,
                                    groupValue: groupValue,
                                    onChanged: (int e) {
                                      setState(() {
                                        groupValue = e;
                                      });
                                    },
                                    activeColor: Colors.red,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getRequestType() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getOnlineRequestTypes'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': '14146',
          'program': studentJson['data']['program'],
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      );


      if (response.statusCode == 200) {
        setState(
          () {
            onlineRequestTypeJson = json.decode(response.body)['data'];
            onlineRequestTypeMessageJson = json.decode(response.body);
          },
        );
        showLoading(false, context);
      }

      if (onlineRequestTypeMessageJson["success"] == "0") {
        showLoading(false, context);
        Fluttertoast.showToast(
            msg: onlineRequestTypeMessageJson["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey[400],
            textColor: Colors.black87,
            fontSize: 13.0);
        Navigator.pop(context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getRequestType);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getRequestType);
      }
    }
  }

  Future getAmount() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getOnlineRequestAmount'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'req_type_id': item,
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            requestAmountJson = json.decode(response.body);
          },
        );
        showLoading(false, context);
      }
    } catch (x) {
      
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getAmount);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getAmount);
      }
    }
  }

  Future getOnlineRequest() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/onlineRequest'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'request_type': requestAmountJson['data']['MiscName'],
          'request_process': groupValue == 1 ? "Normal" : "Urgent",
          'address': address,
          'remarks': remark,
          'amount': groupValue == 1 ? "NormalAmount" : "UrgentAmount",
          'token': '1',
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            onlineRequestJson = json.decode(response.body);
          },
        );
        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getOnlineRequest);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getOnlineRequest);
      }
    }
  }
}
