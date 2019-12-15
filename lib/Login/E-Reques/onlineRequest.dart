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
  Map onlineRequestTypeMessageJson = {};
  Map onlineRequestJson = {};
  Map requestAmountJson = {};
  String address = '';
  String remark = '';
  String ex1 = "No value selected";
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
      bottomNavigationBar: onlineRequestTypeJson.isEmpty
          ? Container()
          : bottomappBar(
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
      body: onlineRequestTypeJson.isEmpty
          ? Container()
          : GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Container(
                color: Colors.transparent,
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20.0, 0.0, 20.0, 5.0),
                              child: CustomDropDown(
                                isExpanded: true,
                                items: onlineRequestTypeJson
                                        ?.map(
                                          (item) => DropdownMenuItem<String>(
                                            value: item['DetailsID'].toString(),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child:
                                                  Text(item['Item'].toString()),
                                            ),
                                          ),
                                        )
                                        ?.toList() ??
                                    [],
                                value: item,
                                hint: new Text('Select One'),
                                searchHint: new Text(
                                  'Select One',
                                  style: new TextStyle(fontSize: 20),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    // getAmount();
                                    item = value;
                                  });
                                  print(item);
                                },
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            color: Colors.white,
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
                                              color: Colors.grey[600]),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        height: 25,
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
                            color: Colors.white,
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
                                              color: Colors.grey[600]),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        height: 25,
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
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Pay Amount")),
                              ),
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
                                  Text('Normal'),
                                ],
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
                                  Text('Urgent'),
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
          'user_id': username,
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

        showErrorServer(context, getRequestType());
      } else {
        showLoading(false, context);
        showErrorConnect(context, getRequestType());
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
            'https://skylineportal.com/moappad/api/tes/OnlineRequestAmount'),
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
        showErrorServer(context, getAmount());
      } else {
        showLoading(false, context);
        showErrorConnect(context, getAmount());
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

        showErrorServer(context, getOnlineRequest());
      } else {
        showLoading(false, context);

        showErrorConnect(context, getOnlineRequest());
      }
    }
  }
}
