import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/bottomAppBar.dart';
import 'package:skyline_university/Global/customdropdown.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/form.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(LetterRequest());

class LetterRequest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LetterRequestState();
  }
}

// Map<String, int> body;
final letterRequest = GlobalKey<FormState>();

class _LetterRequestState extends State<LetterRequest> {
  List sendletterRequestJson = [];
  Map requestAmountJson = {};
  List letterRequestTypeJson = [];
  String requestId;
  String address = '';
  String remark = '';
  @override
  void initState() {
    super.initState();

    getRequestType();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      bottomNavigationBar: bottomappBar(
        context,
        () {},
      ),
      appBar: appBarLogin(context, 'Letter Request'),
      body: letterRequestTypeJson == null || letterRequestTypeJson.isEmpty
          ? exception(context)
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
                              color:
                                  isDark(context) ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: CustomDropDown(
                                isExpanded: true,
                                items: letterRequestTypeJson
                                        ?.map(
                                          (item) => DropdownMenuItem<String>(
                                            value: item['MiscID'].toString(),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: FittedBox(
                                                child: Text(
                                                  item['MiscName'].toString(),
                                                  style: TextStyle(
                                                      color: isDark(context)
                                                          ? Colors.white
                                                          : Colors.black),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                        ?.toList() ??
                                    [],
                                value: requestId,
                                hint: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 0.0, 20.0, 5.0),
                                  child: new Text(
                                    'Select One',
                                    style: TextStyle(
                                        color: isDark(context)
                                            ? Colors.white
                                            : Colors.black),
                                  ),
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
                                  setState(() async {
                                    requestId = value;
                                    getAmount();
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                     

                      Column(
                        children: <Widget>[
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
                                            requestAmountJson.isEmpty ||
                                                    requestAmountJson == null
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
                          SizedBox(height: 10,),
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
                                            requestAmountJson.isEmpty ||
                                                    requestAmountJson == null
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
                          Container(
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Form(
                                  key: letterRequest,
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
                        ],
                      )
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
            'https://skylineportal.com/moappad/api/test/OnlineRequestOnline'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'Operation': 'LETTER',
        },
      );

      if (response.statusCode == 200) {
        setState(
          () {
            letterRequestTypeJson = json.decode(response.body)['data'];
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

  Future sendOnlineRequest() async {
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
          // 'request_type': requestAmountJson['data']['MiscName'],
          // 'request_process': groupValue == 1 ? "Normal" : "Urgent",
          // 'address': address,
          // 'remarks': remark,
          // 'amount': groupValue == 1 ? "NormalAmount" : "UrgentAmount",
          // 'BatchCode': againstMarksJson[i]['BatchCode'],
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        sendletterRequestJson = json.decode(response.body)['data'];
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, sendOnlineRequest);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            sendOnlineRequest);
      }
    }

    showLoading(false, context);
  }
}
