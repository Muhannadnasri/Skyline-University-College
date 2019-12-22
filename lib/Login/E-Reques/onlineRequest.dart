import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/bottomAppBar.dart';
import 'package:skyline_university/Global/customdropdown.dart';
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
  Map onlineRequestJson = {};
  Map requestAmountJson = {};
  String address = '';
  String remark = '';
  String ex1 = "No value selected";
  int groupValue = 1;
  String requestId;

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
      bottomNavigationBar: onlineRequestTypeJson.isEmpty
          ? Container()
          : bottomappBar(
              context,
              () {
                if (_onlineRequest.currentState.validate() &&
                    requestId != null) {
                  _onlineRequest.currentState.save();
                  getOnlineRequest();
                } else {
                  return showErrorInput('Please check your input');
                }
              },
            ),
      appBar: appBarLogin(context, 'Online Request'),
      body: onlineRequestTypeJson.isEmpty
          ? Container()
          : GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: ListView(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
                          child: Text(
                            'Request Type',
                            style: TextStyle(
                                color: isDark(context)
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 12),
                          ),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
                            child: CustomDropDown(
                              isExpanded: true,
                              items: onlineRequestTypeJson
                                      ?.map(
                                        (item) => DropdownMenuItem<String>(
                                          value: item['DetailsID'].toString(),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              item['Item'].toString(),
                                              style: TextStyle(
                                                  color: isDark(context)
                                                      ? Colors.white
                                                      : Colors.black),
                                            ),
                                          ),
                                        ),
                                      )
                                      ?.toList() ??
                                  [],
                              value: requestId,
                              hint: new Text(
                                'Select One',
                                style: TextStyle(
                                    color: isDark(context)
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              underline: Container(
                                height: 1,
                                color: Color(0xFF2f2f2f),
                              ),
                              searchHint: new Text(
                                'Select One',
                                style: new TextStyle(
                                    fontSize: 20,
                                    color: isDark(context)
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  requestId = value;

                                  getAmount();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Card(
                          color: isDark(context)
                              ? Color(0xFF121212)
                              : Colors.white,
                          elevation: 5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        'Normal Amount',
                                        style: TextStyle(
                                            color: isDark(context)
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      height: 25,
                                      child: Text(
                                        requestAmountJson.isEmpty
                                            ? ''
                                            : requestAmountJson['data']
                                                        ['NormalAmount'] ==
                                                    ("NA")
                                                ? "Not Avalible"
                                                : requestAmountJson['data']
                                                        ['NormalAmount']
                                                    .toString(),
                                        style: TextStyle(
                                            color: isDark(context)
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Card(
                          color: isDark(context)
                              ? Color(0xFF121212)
                              : Colors.white,
                          elevation: 5,
                          child: Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        'Urgent Amount',
                                        style: TextStyle(
                                            color: isDark(context)
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      height: 25,
                                      child: Text(
                                        requestAmountJson.isEmpty
                                            ? ''
                                            : requestAmountJson['data']
                                                        ['UrgentAmount'] ==
                                                    ("NA")
                                                ? "Not Avalible"
                                                : requestAmountJson['data']
                                                        ['UrgentAmount']
                                                    .toString(),
                                        style: TextStyle(
                                            color: isDark(context)
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Form(
                              key: _onlineRequest,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                  }, 'Address', TextInputType.text),
                                  globalForms(context, '', (String value) {
                                    if (value.trim().isEmpty) {
                                      return 'Remark is required';
                                    }
                                    return null;
                                  }, (x) {
                                    setState(() {
                                      remark = x;
                                    });
                                  }, 'Remark', TextInputType.text),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Pay Amount",
                                  style: TextStyle(
                                      color: isDark(context)
                                          ? Colors.white
                                          : Colors.black),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
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
                                    Text('Normal',
                                        style: TextStyle(
                                            color: isDark(context)
                                                ? Colors.white
                                                : Colors.black)),
                                  ],
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Row(
                                  children: <Widget>[
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
                                    Text('Urgent',
                                        style: TextStyle(
                                            color: isDark(context)
                                                ? Colors.white
                                                : Colors.black)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ],
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
            'https://skylineportal.com/moappad/api/test/OnlineRequestTypes'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'program': studentJson['data']['program'],
        },
      );

      if (response.statusCode == 200) {
        setState(
          () {
            onlineRequestTypeJson = json.decode(response.body)['data'];
          },
        );
        showLoading(false, context);
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
            'https://skylineportal.com/moappad/api/test/OnlineRequestAmount'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'req_type_id': requestId,
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
            'https://skylineportal.com/moappad/api/test/onlineRequest'),
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
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            onlineRequestJson = json.decode(response.body);
          },
        );

        showLoading(false, context);

        showSuccessSnackBar(context, onlineRequestJson['message']);
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
